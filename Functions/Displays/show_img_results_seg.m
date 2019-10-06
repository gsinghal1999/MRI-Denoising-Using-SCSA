function show_img_results_seg( algo_type, h, gm, fs, border_seg,img_padd , img, noisy_img, denoised_img, SNR_dB, figr,Nh,exe_time,Ns,Np) 
global img0 slice_seg dnz_image_mat name_denoised_G  h_G h2_G gm_G fs_G Np_G Ns_G  adapt_scsa Sig_type_MRS

N=max(size(img));
 %% Results Evaluation 
[PSNR0, SSIM0, SI00, SI_1, SNR0, MSE0]=image_evaluation(img, noisy_img); 
[PSNR, SSIM, SI00, SI_1, SNR, MSE]=image_evaluation(img, denoised_img); 
res_img=abs(img-denoised_img);
figure(figr); figr_num=figr; 


 %% or image
img_padd(border_seg(1),border_seg(3):border_seg(4))=1;
img_padd(border_seg(2),border_seg(3):border_seg(4))=1;

img_padd(border_seg(1):border_seg(2),border_seg(3))=1;
img_padd(border_seg(1):border_seg(2),border_seg(4))=1;

subplot(1, 4, 1);imshow(img_padd);
    title(strcat('Original image '))
    xlabel(strcat( 'Size=', num2str(N), 'x', num2str(N), ' ,  SI= ', num2str(SI00)))
    ylabel(strcat(algo_type))
    
subplot(1, 4, 2);imshow(noisy_img);
    title(strcat('Noisy image with noise =', SNR_dB))
    xlabel(strcat('SNR0=', num2str(SNR0), ' , PSNR0=', num2str(PSNR0), ' , SSIM=', num2str(SSIM0)))


    
subplot(1, 4, 3);
imshow(denoised_img);
title(strcat('Denoised :  h=', num2str(h), '  ,  \gamma= ', num2str(gm), ' , fs=', num2str(fs) ))
ylabel(strcat(' ,  Ns= ', num2str(Ns), ' , Np=', num2str(Np), ', Time=',num2str(exe_time),' sec'))
xlabel(strcat( 'SNR= ', num2str(SNR), ' , PSNR= ', num2str(PSNR), ' , SSIM= ', num2str(SSIM)))
lgnd_h=strcat('Average of Nh= ', num2str(floor(Nh)));

subplot(1, 4, 4);imshow(res_img);
    title('Residual Image ') ;  
     xlabel( lgnd_h )
      
set(figure(figr), 'units', 'normalized', 'outerposition', [0 0 1 1]) ;
 
%% Save results  
% save_figure(dnz_image_mat ,figr,name_denoised_G )  

