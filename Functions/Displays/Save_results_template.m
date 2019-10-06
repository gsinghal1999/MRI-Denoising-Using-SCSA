
Results_path=strcat('./Results/', num2str(SNR_ROI_Equation),'_', algo_type,noisy_file,'_N_',num2str(N),'_SNR_',SNR_dB);   mkdir(Results_path);  
Results_path_SNR=strcat(Results_path, '/SNR_measurment/');  mkdir(Results_path_SNR)
%% ####################  ROI   ###############################

% Figure 2 :  ROI of the noisy image
figr_num=2;
name=strcat('Noisy_szROI_',num2str(sz_ROI));
save_figure_ROI(Results_path_SNR,figr_num,name)

% Figure 4 :  Results  noisy,  denoised and residual   images with h
figr_num=4;
name=strcat('dz_img_h_',num2str(h),'_gm_',num2str(gm));
save_figure_ROI(Results_path,figr_num,name)

% Figure 5 :  ROI of the Residual  image with h
figr_num=5;
name=strcat('Residual_szROI_',num2str(sz_ROI),'_h_',num2str(h),'_gm_',num2str(gm));
save_figure_ROI(Results_path_SNR,figr_num,name)


%% ####################  Performance evaluation   ###############################

% Figure 6 :  All the evaluation Metrics  with h_range
figr_num=6;
name=strcat('Matrics_szROI_',num2str(sz_ROI),'_hmin_',num2str(hmin),'_hmax_',num2str(hmax),'_gm_',num2str(gm));
save_figure_ROI(Results_path,figr_num,name)

% Figure 9 :   [Normalized ] All the evaluation Metrics  with h_range
figr_num=9;
name=strcat('Matrics_Normlized_szROI_',num2str(sz_ROI),'_hmin_',num2str(hmin),'_hmax_',num2str(hmax),'_gm_',num2str(gm));
save_figure_ROI(Results_path,figr_num,name)

% Figure 8 :  [Variation ] All the evaluation Metrics  with h_range
figr_num=8;
name=strcat('Matrics_variation_szROI_',num2str(sz_ROI),'_hmin_',num2str(hmin),'_hmax_',num2str(hmax),'_gm_',num2str(gm));
save_figure_ROI(Results_path,figr_num,name)

% Figure  : [Chosen metrics ]the evaluation Metrics  with h_range
figr_num=8;
name=strcat('Chosen_Matrics_szROI_',num2str(sz_ROI),'_hmin_',num2str(hmin),'_hmax_',num2str(hmax),'_gm_',num2str(gm));
save_figure_ROI(Results_path,figr_num,name)


 
%% save . mat files
            if save_mat==1
                save(strcat('./',Results_path,'/',num2str(SNR_ROI_Equation),'comp_all_sz_ROI_',num2str(sz_ROI),'_h_min_',num2str(hmin),'.mat'),'tab','gm','fs','hmin','hmax','sz_ROI','filename','rep','nh','std_imag_noisy','N','x_vars','img','noisy_img','SNR_ROI_Equation');
            %% save .mat file : h optimal range criteria
            save(strcat('./',Results_path,'/',num2str(SNR_ROI_Equation),'h_optimal_',num2str(sz_ROI),'.mat'),'h_criteria','CNR_formlat','gm','fs','rep','SNR_ROI_Equation','add_noise');
            end
            if save_xls==1
            xlswrite(strcat('./',Results_path,'/h_optimal_',num2str(sz_ROI),'_',num2str(SNR_ROI_Equation),'.xls'),tab)
            end
 