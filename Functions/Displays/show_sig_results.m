function show_sig_results( algo_type, h, gm, fs,  img, noisy_img, denoised_img, SNR_dB, figr,Nh,exe_time,Ns,Np) 
global t img0 slice_seg dnz_signal_mat name_denoised_G  h_G h2_G gm_G fs_G Np_G Ns_G  adapt_scsa Sig_type_MRS noisy_file

N=max(size(img));
 %% Results Evaluation 
[PSNR0, SSIM0, SI00, SI_1, SNR0, MSE0]=image_evaluation(img, noisy_img); 
[PSNR, SSIM, SI00, SI_1, SNR, MSE]=image_evaluation(img, denoised_img); 
res_img=abs(img-denoised_img);
figure(figr); figr_num=figr; 


 %% or signal

            % Standarrd signal 
            plot (t, img , 'g', 'LineWidth', 4) 
            hold on 
            plot (t, noisy_img, 'b', 'LineWidth', 3) 
            hold on 
            plot (t, denoised_img , 'r', 'LineWidth', 2)  
            hold on 
            plot (t, res_img , 'k', 'LineStyle', ':', 'LineWidth', 2.5)   
            lgdd=legend('Desired Signal ', 'Noisy signal', 'Denoised signal', 'Residual');
            set(lgdd, 'FontSize', 15); 
            title(strcat('Signal Denoising , Time=',num2str(exe_time),' sec'))
            xlabel('Time (s)')
            ylabel(strcat(algo_type,'_',noisy_file))
            grid on        
            title([ ' h = ' num2str(h), ' gm = ' num2str(gm), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , Nh= ', num2str(Nh), ' , N= ', num2str(N), ' samples'])

    
set(figure(figr), 'units', 'normalized', 'outerposition', [0 0 1 1]) ;
 
%% Save results  
% save_figure(dnz_signal_mat ,figr,name_denoised_G )  

