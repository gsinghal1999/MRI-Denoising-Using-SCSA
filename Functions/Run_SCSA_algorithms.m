%%
    %**********************************************************************
    %                        SCSA_2D1D  Function                          *
    %**********************************************************************

 % Modified by:  Abderrazak Chahid  
 % aberrazak.chahid@gmail.com
 % Original Author : Professor Taous_Meriem Laleg . EMAN Group KAUST 
 % taousmeriem.laleg@kaust.edu.sa 
 
 %% Description
 %  Runs the SCSA*** methods on  image stored in  "noisy_img" variable 

%##########  Inputs  ###############
%algo_type_d       : type of the SCSA Algorithm : 1) SCSA1D         2) SCSA1D_matrix    3)  SCSA2D1D  
                                                % 4) SCSA2D2D       5)SCSA2D2D_sparse   6) SCSA1D_Nh
                                                % 7)SCSA2D1D-PCBh   8) SCSA2D1D-PSGHh
%h ,gm, fs        : SCSA Parameters
%noisy_img      : noisy image variable
%img                :  original  image variable
%SNR_dB       : SNR of the noisy image
%noisy_file      : name of the used noisy image 
%Results_path:  the resultant .mat file will be stored

%##########  Outputs  ###############
% Results_path
% algo_type  type of the SCSA Algorithm  in string fomat
% dz_type  : 
% SNR_dB the SNR of the noisy signal
% one_blk_time : Excution time
% dnz_image_mat : path where the denoised data is stored

function [algo_type,dz_type,name_denoised,denoised_img,Nh,one_blk_time]=Run_SCSA_algorithms(algo_type_d, h, gm, fs, h2, Np, Ns, Ni, noisy_img,img, SNR_dB, noisy_file, Results_path )
global show_performance figr_num  test_phase t seg_type disp_msg  adapt_scsa dnz_image_mat ...
           img name_denoised_G seg_img N0 index dnz_image_mat_seg   segment_algo algo_type img_origin store_decomposition



disp_msg=1;  
Sz_img=size(noisy_img);
if gm<0
    if min(Sz_img)==1
       gm=0.5; 
    else
        gm=4;       
    end
else
    
end
%% Select  type of algorithm

    if algo_type_d==1
            algo_type='SCSA1D_';               % SCSA of signals  
            dz_type='sig_dz_';
          
        elseif algo_type_d==2
                algo_type='SCSA1D_matrix_';               % SCSA of images using columns by column and row by row algorithm  
                dz_type='sig_dz_';
                
                elseif algo_type_d==3   
                    algo_type='SCSA2D1D_';               % SCSA of images using columns by column and row by row algorithm  
                    dz_type='img_dz_';
                    
                    elseif algo_type_d==4
                        algo_type='SCSA2D2D_';               % SCSA of images using columns by column and row by row algorithm  
                        dz_type='img_dz_';

                        elseif algo_type_d==5
                            algo_type='SCSA2D2D_sparse_';               % SCSA of images using columns by column and row by row algorithm  
                            dz_type='sig_dz_';
                            
                            elseif algo_type_d==6
                                algo_type='SCSA1D_Nh_var_';               % SCSA of images using columns by column and row by row algorithm  
                                dz_type='sig_dz_';
                            
                                elseif algo_type_d==7
                                    algo_type='SCSA-PCGh_';               % SCSA of images using columns by column and row by row algorithm  
                                    dz_type='img_dz_';
                                    seg_type=1;
                                    
                                    elseif algo_type_d==8
                                        algo_type='SCSA-PSGh_';               % SCSA of images using columns by column and row by row algorithm  
                                        dz_type='img_dz_';
                                        seg_type=2;
                     
    else
    disp('Error the algo_type_d is not   in the allowed defined range')
    end
    
if store_decomposition==1
img_origin=img; 
end   
N=max(Sz_img); adapt_scsa=0;
if algo_type_d==7 | algo_type_d==8
    adapt_scsa=1;
 name_denoised= strcat(dz_type,'_hb_',num2str(h2),'_hc_',num2str(h),  '_gm_',num2str(gm), '_fs_',num2str(fs),'_Ns_',num2str(Ns),'_Np_',num2str(Np),  '.mat');  
else  
name_denoised= strcat(dz_type,'_h_',num2str(h),  '_gm_',num2str(gm), '_fs_',num2str(fs), '.mat');
end


if seg_img==1
    
    if segment_algo==1
       algo_type= strcat(algo_type(1:end-1),'-Seg-Scan_');  %algo_type_seg;
    else
           algo_type= strcat(algo_type(1:end-1),'-Seg-Imfil_');  %algo_type_seg;
    end
    dnz_image_mat=strcat(Results_path,'/',strcat(algo_type,noisy_file,'_N_',num2str(N0),  '_SNR_',SNR_dB,'/Segmented_Ns_',num2str(Ns),'_Np_',num2str(Np),'/Subimage_',num2str(index)));
    dnz_image_mat_seg=strcat(Results_path,'/',strcat(algo_type,noisy_file,'_N_',num2str(N0),  '_SNR_',SNR_dB));

else
    dnz_image_mat=strcat(Results_path,'/',strcat(algo_type,noisy_file,'_N_',num2str(N),  '_SNR_',SNR_dB));
end

save_denoised=strcat(dnz_image_mat,'/',name_denoised);
name_denoised_G=name_denoised(1:end-4);


    list_mat=dir(save_denoised);
  
if  test_phase==1 %|  size(list_mat,1)==0
       
    tic

	if algo_type_d==1  
                    if min(Sz_img)==1 
                        [h,denoised_img,Nh] = SCSA_1D(noisy_img,fs,h,gm);
                    else
                        disp('ERROR:  the noisy signal is not a vector !!')
                    end

                             elseif algo_type_d==2
                                if min(Sz_img)==1 
                                      [h,denoised_img,Nh] = scsa_matrix(noisy_img,fs,h,gm);
                                else
                                      disp('ERROR:  the noisy signal is not a vector !!')
                                end
                            
                                        elseif algo_type_d==3
                                            if Sz_img(1)==Sz_img(2)
                                                   [h,denoised_img,Nh]=SCSA_2D1D(noisy_img,h,fs,gm);
                                            else
                                                    disp('ERROR:  the noisy image is not a square array !!')
                                            end

                                                      elseif algo_type_d==4
                                                            if Sz_img(1)==Sz_img(2)
                                                                      [h,denoised_img,Nh]=SCSA_2D2D(noisy_img,h,fs,gm);
                                                            else
                                                                    disp('ERROR:  the noisy image is not a square array !!')
                                                            end

                                                                     elseif algo_type_d==5
                                                                          if Sz_img(1)==Sz_img(2)
                                                                                     [h,denoised_img,Nh]=SCSA_2D2D_sparse(noisy_img,h,fs,gm);
                                                                             else
                                                                                disp('ERROR:  the noisy image is not a square array !!')
                                                                          end
                                      
                                                                                     elseif algo_type_d==6
                                                                                          if min(Sz_img)==1 
                                                                                                     [h,denoised_img,Nh]=SCSA_1D_Nh_var(noisy_img,img,fs,h,gm); 
                                                                                             else
                                                                                                disp('ERROR:  the noisy signal is not a vector !!')
                                                                                          end

                                                                                                      elseif algo_type_d==7
                                                                                                          if Sz_img(1)==Sz_img(2) 
                                                                                                                      disp_msg=0;[h,denoised_img,Nh,Ns,Np]=SCSA_adaptive(noisy_img, fs, h2, h, gm, Np, Ns, Ni);
                                                                                                             else
                                                                                                                disp('ERROR:  the noisy image is not a square array !!')
                                                                                                          end

                                                                                                                          elseif algo_type_d==8
                                                                                                                              if Sz_img(1)==Sz_img(2) 
                                                                                                                                         disp_msg=0; [h,denoised_img,Nh,Ns,Np]=SCSA_adaptive(noisy_img, fs, h2, h, gm, Np, Ns, Ni);
                                                                                                                                 else
                                                                                                                                    disp('ERROR:  the noisy image is not a square array !!')

                                                                                                                              end

                                    

	else
                            disp('ERROR:  the algo_type_d value  is not in the allowed defined range')
        
    end
        

        
       scsa=1;one_blk_time=toc;
        

                
%% ## Save fixed-h  denoised image using <.mat> format in  <./denoised image> forder
    if test_phase==0 % &  seg_img==0
          if exist(dnz_image_mat)~=7
            mkdir(dnz_image_mat);
          end

            save(save_denoised,'noisy_img',  'img',  'denoised_img',  'h',  'SNR_dB',   'fs',  'gm',  'N',  'Nh',  'one_blk_time',  'algo_type',  'noisy_file',  'scsa',  'algo_type','h2','Np','Ns','Ni');
    end
    
else
        fprintf('-->Loaded')   
        %% ## load fixed-h denoised image using <.mat> format in  <./denoised image> forder
        load(save_denoised)
        
        
end
    
        %% plot evalution 
        
        if show_performance==1
           denoising_evaluation(algo_type_d, algo_type, dz_type,  h, gm, fs, h2, Np, Ns, Ni,t, img, noisy_img, denoised_img, SNR_dB, noisy_file, Nh, figr_num,one_blk_time)                 
         %% Save figure
            name=strcat('dz_img_h_',num2str(h),  '_gm_',num2str(gm));
%             save_figure_ROI(dnz_image_mat,figr_num,name)

        end
info=0; 
end
