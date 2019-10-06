%%  SCSA distributed h denoising For each method
% seg_img             % using grid segmentation : 0) no    1) Yes
%#Padded grid Segmentation prameters
% Ns= 6                % Ns: Number of sub images per row/column,   
% Np=2                 % Np: dimension of padded borders

function [denoised_img, h_matrix, gm_matrix,fs_matrix,Nh,PSNR_full]=SCSA2D_denoising_segmentation(seg_img, segment_algo, img, noisy_img,h_range,gm_range,fs_range,cost_fun,init_x0,plot_cost,budget,bounds)
global h2_G  Ns_G  Np_G Ni_G N0 index  SNR_dB noisy_file dim_x dnz_image_mat dnz_image_mat_seg  tab_optz    algo_type...
             Results_path_denoised store_decomposition algo_type_d test_phase Emin


%% Check Image padding Comdiction
N0=min(size(noisy_img)); N=N0;scaling=0; Ns=Ns_G; Np=Np_G;Ni=Ni_G;scsa=1;Nh=-1;         
if segment_algo==1
    name_add='Scan_';
else
    name_add='Imfil_';
    
end

figr_num=2;tic
if  seg_img==1
    
            name_add=strcat(name_add,'w_seg_');
            %% Check Image padding Conditions
            N=min(size(noisy_img));  
            N0=N;scaling=0; noisy_img0= noisy_img;img0= img;
            sz_Ni=N0/Ns
%             if sz_Ni> Ns
%             Ns=Ni; 
%             end
            
             Ns_G=Ns;  Np_G=Np;
            if  rem(N0,Ns)~=0;
            N1=(floor(N0/Ns)+1)*Ns;
            scaling=1;
            noisy_img0= imresize(noisy_img,[N1 N1]);
            img0= imresize(img,[N1 N1]);
            end
            
            %% Image padding
            N=min(size(noisy_img0))
            nb_Ns=N/Ns;noisy_img0_padded=padarray(noisy_img0,[Np Np],'replicate');  img_padded=padarray(img0,[Np Np],'replicate');      
            Nsp=Ns+2*Np;

            %% # choose h for each sub-image 
            %%  # Generate the Distributed-h values  

            Nh_seg=0;

            fprintf('\n');
            disp('The Adaptive SCSA Algorithm has started. Please wait..')
            fprintf('\n');

            for index=0:nb_Ns*nb_Ns-1

            fprintf('.');

            %% # image griding           
            J=mod(index,nb_Ns);
            I= floor(index/nb_Ns);
            I_min=I*Ns+1;
            J_min=J*Ns+1;



            %% ### Build the subimages from the noisy  image with padding
            sub_noisy_img0_padd=noisy_img0_padded(I_min:I_min+Nsp-1,J_min:J_min+Nsp-1 );
            sub_img_padd=img_padded(I_min:I_min+Nsp-1,J_min:J_min+Nsp-1 );


            %%% ### Run the  SCSA2D1D  optimization on sub image
            tic
                if segment_algo==1
                [x_op,fv_op,Iterat]=SCSA_scan(plot_cost,sub_img_padd,sub_noisy_img0_padd,h_range,gm_range,fs_range)
                else
                [x_op,fv_op,Iterat]=optimize_with_Imfil(cost_fun,init_x0,budget,bounds,plot_cost,sub_img_padd,sub_noisy_img0_padd)
                end
           exe_time0=toc;     
                [h, gm, fs]= assign_x_vect(x_op);

            %%% ### Run the SCSAs  on sub image  
            tic
            [h,sub_denoised_img,Nh]=SCSA_2D1D(sub_noisy_img0_padd,h,fs,gm);
            time_exec=toc
            figr_num=1;  show_performance=0 ; store_decomposition=0; test_phase0=test_phase;test_phase=1
            [algo_type, dz_type, name_denoised, sub_denoised_img, Nh,exe_time]...
            = Run_SCSA_algorithms(algo_type_d, h, gm, fs, h2_G , Np_G, Ns_G , Ni_G ,sub_noisy_img0_padd, sub_img_padd, SNR_dB, noisy_file, Results_path_denoised);  
            test_phase=test_phase0;
            
       %% Evauation     
            unpadd_xy=Np+1:Np+Ns;
            img_n=sub_img_padd(unpadd_xy,unpadd_xy);
            noiy_img_n=sub_noisy_img0_padd(unpadd_xy,unpadd_xy);
            denoised_img_n=sub_denoised_img(unpadd_xy,unpadd_xy);
            Nh_seg=Nh_seg+Nh;

            border_seg=[I_min,I_min+Nsp-1,J_min,J_min+Nsp-1];
            %% Show results 
    %                 figr_num=figr_num+1;
             show_img_results_seg( algo_type(1:end-1), h, gm, fs,border_seg,img_padded,img_n ,noiy_img_n ,denoised_img_n , SNR_dB, figr_num,Nh,exe_time0,Ns,Np) 
             h_matrix(I+1,J+1)=h;gm_matrix(I+1,J+1)=gm;fs_matrix(I+1,J+1)=fs; 
             [PSNR_matrix(I+1,J+1), SSIM_matrix(I+1,J+1), SI00_matrix(I+1,J+1), SI_1_matrix(I+1,J+1), SNR_matrix(I+1,J+1), MSE_matrix(I+1,J+1)]=image_evaluation(img_n, denoised_img_n); 

            name_save0=strcat(name_add,'PSNR_',num2str(PSNR_matrix(I+1,J+1)),'_',algo_type,'dim_',num2str(dim_x), '_Ns_',num2str(Ns), '_Np_',num2str(Np),'_Ni_',num2str(Ni)); 
%             save_figure( dnz_image_mat,figr_num,name_save0)  


            %% Plot the cost function              

            [h_op, gm_op, fs_op]= assign_x_vect(x_op);
            fv_op_i=fv_op;

            if plot_cost ==1 %&& dim_x==1
                figure(20)
                tab_optz=sortrows(tab_optz,1);
                h_vect=tab_optz(:,1);
                fv_vect=normalize(tab_optz(:,end));
                fv_op_dot=min(fv_vect);
                plot(h_vect ,fv_vect,'LineWidth',2);hold on
                plot(h_op,fv_op_dot,'or','MarkerSize',10,'MarkerFaceColor','r')   
                legend(strcat('[ h^*',num2str(h_op),', \gamma ^*',num2str(gm_op),', fs^*',num2str(fs_op),'] => fv^*=',num2str(fv_op_i)) );hold off
                title('Minimization of the MSE ')
                xlabel('h values')
                ylabel(' Cost function [Normalized]')
                %% Save plots
                name_save0=strcat(name_add,'cost_funct_',algo_type,'dim_',num2str(dim_x), '_Ns_',num2str(Ns_G), '_Np_',num2str(Np_G),'_Ni_',num2str(Ni_G)); 
                save_figure( strcat(dnz_image_mat_seg,'/Distribution_plots'),20,name_save0)     

            end
            %% ### Plug-back  subimages into output denoised image
            denoised_img0(I_min:I_min+Ns-1,J_min:J_min+Ns-1)=sub_denoised_img(unpadd_xy,unpadd_xy);
            pause(0.5)
            end

            Nh= Nh_seg/nb_Ns^2;

            %% Resall back the image
            if  scaling==1
            denoised_img= imresize(denoised_img0,[N0 N0]);
            img= imresize(img,[N0 N0]);
            noisy_img0= imresize(noisy_img0,[N0 N0]);

            else
            denoised_img=denoised_img0;
            end

            
            %% Save the optimal segmented image
            one_blk_time=toc;
            [PSNR, SSIM, SI0, SI, SNR, MSE]=image_evaluation(img, denoised_img); 
            % dnz_image_mat_seg=strcat('./Denoised_data/',algo_type,noisy_file,'_N_',num2str(N),'_SNR_',num2str(SNR_dB))
                if exist(dnz_image_mat_seg)~=7
                mkdir(dnz_image_mat_seg);
                end         
else
    
            
            
            Ns=N0; N1=N0;  Ns_G=Ns;  Np_G=Np;
            
            if segment_algo==1
                [x_op,fv_op,Iterat]=SCSA_scan(plot_cost,img,noisy_img,h_range,gm_range,fs_range)

            else
                [x_op,fv_op,Iterat]=optimize_imfil(cost_fun,init_x0,budget,bounds,plot_cost,img,noisy_img);

            end
              
            [h, gm, fs]= assign_x_vect(x_op); 

            dnz_image_mat_optimal= strcat(Results_path_denoised,'_optimal/',algo_type(1:end-1));

            % [h,denoised_img0,Nh]=SCSA_2D1D(noisy_img,h,fs,gm);
           
            store_decomposition=1;test_phase0=test_phase; test_phase=1;tic
            [algo_type, dz_type, name_denoised, denoised_img, Nh,exe_time]...
            = Run_SCSA_algorithms(algo_type_d, h, gm, fs, h2_G, Np_G, Ns_G, Ni_G,noisy_img, img, SNR_dB, noisy_file,dnz_image_mat_optimal);  
             exe_time0=toc; h_matrix=h;    gm_matrix=gm;   fs_matrix=fs; test_phase=test_phase0;
            [PSNR_matrix, SSIM_matrix, SI00_matrix, SI_1_matrix, SNR_matrix, MSE_matrix]=image_evaluation(img, denoised_img); 

  
    
end

% [PSNR, SSIM, SI00, SI_1, SNR, MSE]=image_evaluation(img, denoised_img);     
[PSNR_full, SSIM_full, SI00_full, SI_1_full, SNR_full, MSE_full]=image_evaluation(img, denoised_img); 
[PSNR0]=image_evaluation(img, noisy_img); 
PSNR=PSNR_full;
if  seg_img==1
    
%% Save results variables
mkdir(dnz_image_mat_seg)
name_save=strcat('Optimal',name_add,'PSNR_',num2str(PSNR_full),'_N_',num2str(N),'_dim_',num2str(dim_x), '_Ns_',num2str(Ns), '_Np_',num2str(Np),'_Ni_',num2str(Ni));
name_denoised= strcat(dnz_image_mat_seg,'/',name_save,'.mat');
save(name_denoised,'noisy_img',  'img',  'denoised_img',  'h_matrix',  'SNR_dB',   'fs_matrix',  'gm_matrix','PSNR_matrix','SSIM_matrix','SI00_matrix','SI_1_matrix','SNR_matrix','MSE_matrix',...
                                   'N', 'N0',   'Ns', 'Np','Nh',  'one_blk_time',  'algo_type',  'noisy_file',  'scsa','PSNR_full','SSIM_full','SI00_full','SI_1_full','SNR_full','MSE_full');
     
%% returnShow results
figr_num=figr_num+1;
show_img_results( algo_type(1:end-1), h, gm, fs, img, noisy_img,denoised_img, SNR_dB, figr_num,Nh,exe_time0,Ns,Np) 
save_figure( strcat(dnz_image_mat_seg,'/Distribution_plots'),figr_num,name_save)  

    if nb_Ns>1
    figr_num=figr_num+1;
    show_value_matrix(PSNR_matrix,figr_num,'PSNR')
    save_figure( strcat(dnz_image_mat_seg,'/Distribution_plots'),figr_num,strcat(name_save,'_PSNR'))  

    figr_num=figr_num+1;
    show_value_matrix(h_matrix,figr_num,'h distribution ')
    save_figure(strcat(dnz_image_mat_seg,'/Distribution_plots'),figr_num,strcat(name_save,'_h_matrix'))  
    
    figr_num=figr_num+1;
    show_value_matrix(gm_matrix,figr_num,'\gamma distribution ')
    save_figure(strcat(dnz_image_mat_seg,'/Distribution_plots'),figr_num,strcat(name_save,'_gm_matrix'))  

    figr_num=figr_num+1;
    show_value_matrix(fs_matrix,figr_num,'fs distribution ')
    save_figure(strcat(dnz_image_mat_seg,'/Distribution_plots'),figr_num,strcat(name_save,'_fs_matrix'))  

    end
    
    
else
 
%% Save results variables
mkdir(dnz_image_mat)
name_save=strcat('Optimal',name_add,'PSNR_',num2str(PSNR_full),'_N_',num2str(N),'_dim_',num2str(dim_x), '_h_',num2str(h), '_gm_',num2str(gm),'_fs_',num2str(fs));
name_denoised= strcat(dnz_image_mat,'/',name_save,'.mat');
save(name_denoised,'noisy_img',  'img',  'denoised_img','h','gm','fs','SNR_dB', 'N', 'N0',   'Ns', 'Np','Nh','PSNR0','PSNR',  'exe_time0',  'algo_type',  'noisy_file', 'Emin', 'scsa','PSNR_full','SSIM_full','SI00_full','SI_1_full','SNR_full','MSE_full');


%% Save the optimal performance for the algorithm in a txt file 
name_file= strcat(dnz_image_mat,'/',name_save,'.txt');
save_performance_txt 

 %% return Show results
figr_num=figr_num+1;
show_img_results( algo_type(1:end-1), h, gm, fs, img, noisy_img,denoised_img, SNR_dB, figr_num,Nh,exe_time0,Ns,Np) 
save_figure( dnz_image_mat,figr_num,name_save)  


         if plot_cost ==1  %&& dim_x==1
            figure(20)
            tab_optz=sortrows(tab_optz,1);
            h_vect=tab_optz(:,1);
            fv_vect=normalize(tab_optz(:,end));
            fv_op_dot=min(fv_vect);
            plot(h_vect ,fv_vect,'LineWidth',2);hold on
            plot(h,fv_op_dot,'or','MarkerSize',10,'MarkerFaceColor','r')   
            legend(strcat('[ h^*',num2str(h),', \gamma ^*',num2str(gm),', fs^*',num2str(fs),'] => fv^*=',num2str(fv_op)) );hold off
            title(strcat('Minimization of the MSE : PSNR=',num2str(PSNR_full) ,' , time=',num2str(exe_time0),' sec, Nh=',num2str(Nh)))
            xlabel('h values')
            ylabel(' Cost function [Normalized]')
            %% Save plots
            name_save0=strcat(name_add,'cost_funct_',name_save); 
             save_figure(dnz_image_mat,20,name_save0);


         end

end
