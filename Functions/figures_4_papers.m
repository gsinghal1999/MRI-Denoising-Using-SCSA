%% #################### To be run after the main ####################
Result_root=strcat(Results_path0,'/Results_4_paper0');
%% ####################  Run after the main the chosed figures evaluation   ###############################          
close all
% 
% %% Run the algorithm for optimal h and gm
% show_performance=1; figr_num=10;store_decomposition=1;test_phase=1;
% [algo_type, dz_type, name_denoised0, denoised_img, Nh,exe_time]...
%                 =Run_SCSA_algorithm(algo_type_d, h, gm,  fs, noisy_img, img, SNR_dB, noisy_file, Results_path_denoised);  
%  %%
 Results_path=strcat(Result_root,'/',algo_type,noisy_file,'_N_',num2str(N),'_SNR_',SNR_dB);

%% Save the figure
% Figure 3 :  The reconsrtucted signal residual  using the optimal h ,gm
name=strcat('Dnzed',name_op);
save_figure(Results_path,figr_num,name)

% Figure 4: The reconsrtucted signal  using the optimal h ,gm
figr_num=figr_num+1; name=strcat('Res',name_op);
save_figure(Results_path,figr_num,name)

% Figure 5 :   Zoom over the reconsrtucted signal  using the optimal h ,gm
figr_num=figr_num+2; name=strcat('Res_zoom',name_op);
save_figure(Results_path,figr_num,name)

% Figure 5 :  Zoom over the the reconsrtucted signal using the optimal h ,gm
figr_num=figr_num+3; name=strcat('Dnzed_zoom',name_op);
save_figure(Results_path,figr_num,name)


% 
% % Run the algorithm and chose the Nj eigenfunction that remove the water pulse  
% %% load data with reference
% 
% [filename rep]= uigetfile({ext}, 'File selector')  ;
% chemin = fullfile(rep, ext);  list = dir(chemin);  
% cname=strcat(rep, filename);  
% load(cname);
% %% plot the grapghs
% 
% algo_type_d=6; show_performance=1; figr_num=4;show_figrs=1;
% [algo_type, dz_type, name_denoised, denoised_img, Nh,exe_time]...
%                 =Run_SCSA_algorithm(algo_type_d, h, gm,fs, noisy_img, img, SNR_dB, noisy_file, Results_path_denoised);  
% 
% %% Save the figure
% % Figure 1111 :  The reconsrtucted signal using the optimal h and optinal Nh 
% figr_num=1111;name=strcat('Dnzed',name_op,'_Nh_',num2str(Nh));
% save_figure_ROI(Results_path,figr_num,name)
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %%  Zoomed erea
% if min(size(img))>1
%     
% sub_X=floor(1.7*N/3):N  ;sub_Y=floor(1.7*N/3):N;
% noisy_img_zoom=noisy_img(sub_X,sub_Y);
% denoised_img_zoom=denoised_img(sub_X,sub_Y);
%      
% figr=102;
% figure(figr);
% subplot(1,2, 1);imshow(noisy_img_zoom); title('Noisy image [Zoom]');
% subplot(1,2, 2); imshow(denoised_img_zoom); title('Denoised image [Zoom]');
%         
% %% Save the figure
% % Figure 102 :  All the evaluation Metrics  with h_range on the denoised  image
% figr_num=102; name=strcat('Zoom_Dnzed_op_h_',num2str(h),'_gm_',num2str(gm));
% save_figure_ROI(Results_path,figr_num,name)
%       
% end
