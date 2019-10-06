function show_sig_results_seg( algo_type, h, gm, fs, border_seg,img_padd , img, noisy_img, denoised_img, SNR_dB, figr,Nh,exe_time) 
global t0 t 

N=max(size(img_padd));
 %% Results Evaluation 
[PSNR0, SSIM0, SI00, SI_1, SNR0, MSE0]=image_evaluation(img, noisy_img); 
[PSNR, SSIM, SI00, SI_1, SNR, MSE]=image_evaluation(img, denoised_img); 
res_img=abs(img-denoised_img);

figure(figr);

 %% or signal
subplot(1, 2, 1); plot (t0, img_padd , 'g', 'LineWidth', 4) ;hold on
    title(strcat('The sub-signal location '))
    lgdd=legend('Desired Signal ');
    set(lgdd, 'FontSize', 15); 
    xlabel(strcat( 'Size=', num2str(N),', h = ', num2str(h), ', gm = ', num2str(gm),' , fs = ', num2str(fs)))
    ylabel(strcat(algo_type))
    
  subplot(1, 2, 2);                    
            plot (t, noisy_img, 'b', 'LineWidth', 3) 
            hold on 
            plot (t, denoised_img , 'r', 'LineWidth', 2)  
            hold on 
            plot (t, res_img , 'k', 'LineStyle', ':', 'LineWidth', 2.5)   
            lgdd=legend( 'Noisy signal', 'Denoised signal', 'Residual');
            set(lgdd, 'FontSize', 15); 
            title(strcat('Signal Denoising , Time=',num2str(exe_time),' sec'))
            xlabel('Time (s)')
            grid on        
            title([  '  PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , Nh= ', num2str(Nh), ' , N= ', num2str(N), ' samples'])

    
set(figure(figr), 'units', 'normalized', 'outerposition', [0 0 1 1]) ;


%% Save results  
% save_figure(dnz_image_mat ,figr,name_denoised_G )  

