function Run_methods( algo_type_d, algo_type,  img, noisy_img, denoised_img, SNR_dB, noisy_file) 
global  h  gm fs Ns Np  figr  Nh exe_time SCSA2D1Dseg
exe_time=floor(100*exe_time)/100;
N=max(size(img));
M=min(size(img)); 
 %% Results Evaluation 
[PSNR0, SSIM0, SI00, SI_1, SNR0 , MSE0]=image_evaluation(img, noisy_img); 
[PSNR, SSIM, SI00, SI_1, SNR, MSE]=image_evaluation(img, denoised_img); 
res_img=abs(img-denoised_img);
figure(figr);

 if M==1
   %% For signal 
   
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
    ylabel(strcat('File:',noisy_file,' , Time=',num2str(exe_time),' sec ,  N= ', num2str(N)))
    grid on  
    
   if algo_type_d==1, 
    title(strcat('Denoised signal : h=', num2str(h), ' ,  \gamma= ', num2str(gm), ' , fs=', num2str(fs),' , [', algo_type(1:end-1),']' ))    
    xlabel(strcat(' Noise= ',  SNR_dB,' ,  SNR0= ',  num2str(SNR0) , ' , SNR= ', num2str(SNR),   ' ,  PSNR = ', num2str(PSNR),' ,  Nh= ', num2str(Nh)))
   else

       title(strcat('Denoised signal : [', algo_type(1:end-1),']' ))    
       xlabel(strcat(' Noise= ',  SNR_dB,' ,  SNR0= ',  num2str(SNR0) ,   ' , SNR= ', num2str(SNR), ' ,  PSNR = ', num2str(PSNR)))
   end

 else
   
   
 %% or image

     imshow(denoised_img);
    xlabel(strcat(' Noise= ',  SNR_dB,' ,  SNR0= ',  num2str(SNR0) , ' , SNR= ', num2str(SNR), ' ,  PSNR= ', num2str(PSNR), ' , SSIM= ', num2str(SSIM)))
    ylabel(strcat('File:',noisy_file, ' , Time=',num2str(exe_time),' sec ,  size:  ', num2str(N), 'X ', num2str(N)  ))
    
    if algo_type_d==1
                if SCSA2D1Dseg==1
                     title(strcat('Denoised image : h_{mean}=', num2str(h), ' ,  \gamma_{mean}= ', num2str(gm), ' , fs_{mean}=', num2str(fs),' ,  Ns= ', num2str(Ns), ' , Np=', num2str(Np),' , [', algo_type(1:end-1),']' ))    
                    else

                title(strcat('Denoised image : h=', num2str(h), ' ,  \gamma= ', num2str(gm), ' , fs=', num2str(fs),' , [', algo_type(1:end-1),']' ))    
                end
    else
       title(strcat('Denoised image : [', algo_type(1:end-1),']' ))    
    end
     

    figure(figr+1);
    
    
    subplot(121);imshow(noisy_img);
    xlabel(strcat(' Noise= ',  SNR_dB,' ,  SNR0= ',  num2str(SNR0)))
    ylabel(strcat('File:',noisy_file,'  ,  size:  ', num2str(N), 'X ', num2str(N)  ))
    title('Noisy image')
   
    
    subplot(122);imshow(denoised_img);
    xlabel(strcat('  SNR= ', num2str(SNR), ' ,  PSNR= ', num2str(PSNR), ' , SSIM= ', num2str(SSIM)))
    ylabel(strcat( '  Time=',num2str(exe_time),' sec '))
    
    if algo_type_d==1
    title(strcat('Denoised image : h=', num2str(h), ' ,  \gamma= ', num2str(gm), ' , fs=', num2str(fs),' , [', algo_type(1:end-1),']' ))    
    
    else
       title(strcat('Denoised image : [', algo_type(1:end-1),']' ))    
    end
    
 end    
set(figure(figr), 'units', 'normalized', 'outerposition', [0 0 1 1]) 

