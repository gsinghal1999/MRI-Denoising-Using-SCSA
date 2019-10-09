
%% ########   SCSAs optimal parameters / Segmentation [Image]  ###########
%     Apply the listed SCSA algorithm and loks for an optimal 
%     h, gm and fs. this script allows to use segmentation for
%                       images and signals
%       Important: Please use gray images stored in '.mat' files 
%            Data samples are in the folder "Noisy_image"
%% ###############################################################
%  Authors:
%  Garvil Singhal (gsinghal1999@gmail.com)
%  Abderrazak Chahid (abderrazak.chahid@gmail.com)
%  Adviser:
%  Taous-Meriem Laleg (taousmeriem.laleg@kaust.edu.sa)
% Done: July,  2017
% Last edits: July, 2019
%  
%% ##################################################################################
close all;   clear all
global save_fig save_mat save_xls save_pdf test_phase  sim_data ...
           show_performance algo_type_d Results_path_denoised  img0 fv_2_Show... 
           slice_mse mse_seg dim_x h_G gm_G  fs_G  h2_G  Ns_G  Np_G  Ni_G SNR_dB lgnd_fv lgnd_x lgnd_x0 slice_seg adapt_scsa...
           Sig_type_MRS noisy_file seg_img 
       
%% #################################      Input Parameters      ################################################

%% #  Choose   algorithm to be used  from this  list:
                                  
% seg_img=1;                          % 0) SCSA2D1D       4) Adaptive-SCSA2D1D    
algo_type_d=3 ;                    % 3) SCSA2D1D       4) SCSA2D2D                
segment_algo=1 ;                    % 1) scanning                  2) optimization with Imfil
cost_fun='cost_function_MSE';       % if using the Imfil optimization
dim_x=2;                            % the number of variable to optimize : h, h_center, gm,  Ns, Np , fs known that  [fs , gm: are the last parameters to optimize for each method]
Nb_x0=3;                            % the number pf intial guesses
plot_cost=0;                        % if you need to plot the cost function evolution 
%% Bounds 
Li_h=0;Ui_h=5; Nb_h=20;             % The upper and lower bounds of <h> ; Nb_h=Number of values                            
Li_gm=0;Ui_gm=1;  Nb_gm=20;         % The upper and lower bounds of <gm>; Nb_gm=Number of values     
Li_fs=1;Ui_fs=3;   Nb_fs=3;         % The upper and lower bounds of <fs>  ; Nb_fs=Number of values     

%% Choose the simulation parameters
sim_data=1; test_phase=1;up_sample=3;
fv_2_Show=3;                                                 % The number Methods to be compred
show_performance=1 ;                                         % show the performance of the SCSA Algorithm
save_fig=1;  save_mat=1;  save_xls=1;  save_pdf=1;           % Saving Results status    
% save_fig=0;  save_mat=1;  save_xls=0;  save_pdf=0;         % Saving Results status    
h_G=12;   h2_G=h_G/(1.5); gm_G=4; Ns_G=8;  Np_G=0; fs_G=1; % if <dim_x>=1 ==> It's preferable to  gm such that 
                                                             %  gm_1D=0.5;   gm_2D1D=4;    gm_2D2D=1;      
%%  Results Destination 
Results_path_denoised='./Denoised_data'; Results_root0='./Results/';
pathout2='./Denoised_images/mat';  % Path to the denoised Data
%% #######################################################################################################################
%% Add folder 
addpath ./Functions; Include_functions;    % includes the needed function and scripts from parent folder

%%  #Load_data in mat format 
Load_data_to_study ;%load('./data_test/Load_BrainWeb_pn7_N_8.mat');%    load('./data_test/Load_data_7pn.mat');   %  load('./data_test/Load_data_1pn.mat');     %  

%%  Start the Algorithm

for seg_img=1                          % 0) SCSA2D1D       4) Adaptive-SCSA2D1D    

Np_list=[2];Ns_list=[8];%[256 32 8 4 2];
Np_list=unique(seg_img*Np_list);
Ns_list=unique(seg_img*Ns_list);
%% set square image
cnt=0;
[M1,N1]=size(noisy_img); Nmax=max(N1,M1);
if N1~=M1
    noisy_img(Nmax,Nmax)=0;
    img(Nmax,Nmax)=0;

end


    PSNR_op=-inf;
    result_performce=[];
    for segment_algo=1
        for dim_x=2   
             for Np_G=Np_list
                for Ns_G=Ns_list

                    if Ns_G <= N

                        if Ns_G==1
                          Np_G=1;  
                        end

                        h=h_G; gm=gm_G;  fs=fs_G;  h2=h2_G;  Ns=Ns_G;  Np=Np_G; Ni=Ni_G;
                        %% Run one of the chosen algorithm
                        setup_scan_initials; setup_optimization_Imfil_intials;
                        tic
                        [denoised_img_n, h_matrix, gm_matrix,fs_matrix,Nh]=SCSA2D_denoising_segmentation(seg_img,segment_algo, img, noisy_img,h_range,gm_range,fs_range,cost_fun,init_x0,plot_cost,budget,bounds);
                        time_n=toc;
                        %% get the best denoised_image
                        denoised_img=double(denoised_img_n(1:M1,1:N1));
                        img_cleaan=double(img(1:M1,1:N1));
                        PSNR=psnr(denoised_img,img_cleaan);

                        if PSNR>PSNR_op
                            denoised_img_op=denoised_img;
                            h_op=h_G; gm_op=gm_G;  fs_op=fs_G;  h2_op=h2_G;  Ns_op=Ns_G;  Np_op=Np_G; Ni_op=Ni_G;
                            time_exec=time_n;
                            PSNR_op=PSNR;
                        end


                    end
                end
             end
        end
    end


    disp('*************** Done  ***************')
    %% ##########################################################################


    if seg_img==0
    suffixfile='__SCSA';

    else

       suffixfile='__AdSCSA'; 
    end

    h=h_op; gm=gm_op;  fs=fs_op;  h2=h2_op;  Ns=Ns_op;  Np=Np_op; Ni=Ni_op;
    time_exec
    %% 
    img_clean=img(1:M1,1:N1);img_clean=double( img_clean/(max(max(img_clean))) );
    img_noisy=noisy_img(1:M1,1:N1);img_noisy=double( img_noisy/(max(max(img_noisy))) );
    img_denoised=denoised_img_op;img_denoised=double( img_denoised/(max(max(img_denoised))) );

    eval(['img_denoised', suffixfile,'=denoised_img_op;' ]);
    eval(['time_exec', suffixfile,'=time_exec;' ]);


    fprintf('denoised %s \n',suffixfile )
    PSNR0=psnr(img_clean,img_noisy);
    SSIM0=ssim(img_clean,img_noisy);

    PSNR=psnr(img_clean,img_denoised);
    SSIM=ssim(img_clean,img_denoised);

    cnt=cnt+1;name_method{cnt}=suffixfile(3:end);
    result_performce=[result_performce; PSNR SSIM time_exec ];

    %         time_exec

    figure(152);
    subplot(1,3,1); imshow(img_clean); title('Clean image');  
    subplot(1,3,2); imshow(img_noisy);  title('Noisy image');  xlabel(strcat('PSNR_0=',num2str(PSNR0) ,', SSIM_0=',num2str(SSIM0)))
    subplot(1,3,cnt+2); imshow(img_denoised),title(suffixfile(3:end)); xlabel(strcat('PSNR=',num2str(PSNR) ,', SSIM=',num2str(SSIM)))



    %% save results
    % pathpng='R:\chahida\Comparison_State_of_Art\Image_Denoising\\Matlab_codes\Noisy_images\png_MRI\';mkdir(pathpng);
    % imwrite(img_clean,strcat(pathpng,name_image_clean,'.png'));
    % imwrite(img_noisy,strcat(pathpng,name_s,'.png'));
    %% build table
    colnames={ 'PSNR','SSIM','time'};
    perform_output= array2table(result_performce, 'VariableNames',colnames);
    perform_output.Method=name_method';
    perform_output

    %% save in mat and fig
    name_s=filename(1:end-4);
    pathout2=strcat(pathout2,'\SCSA_based_methods\',suffixfile(3:end));
    mkdir(pathout2)
    save(strcat(pathout2,'\',name_s,'.mat'),'perform_output','img_denoised*','img_clean','img_noisy','h','fs','gm','Ns','Np','Ni', 'h2','time_exec','name_s')
    savefig(figure(152),strcat(pathout2,'\',name_s,'.fig') )
    name_s
    strcat('PSNR_0=',num2str(PSNR0) ,', SSIM_0=',num2str(SSIM0))
    
    clearvars 
end
%% THE END
load handel
sound(y,Fs)    
                    
