function denoising_evaluation(algo_type_d, algo_type, dz_type,  h, gm, fs, h2, Np, Ns, Ni, t, img, noisy_img, denoised_img, SNR_dB, noisy_file, Nh, figr, exe_time) 

global img0 slice_seg dnz_image_mat name_denoised_G  adapt_scsa Sig_type_MRS

N=max(size(img));
 %% Results Evaluation 
[PSNR0, SSIM0, SI00, SI_1, SNR0, MSE0]=image_evaluation(img, noisy_img); 
[PSNR, SSIM, SI00, SI_1, SNR, MSE]=image_evaluation(img, denoised_img); 
res_img=abs(img-denoised_img);
figure(figr); figr_num=figr; 

 if algo_type_d ==1 | algo_type_d ==6
   %% For signal 
   switch Sig_type_MRS
       case 1
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

       case 2
           
           % If the signal is MRS
            lgnd_scsa='SCSA Spectrum';
            denoised_img0=denoised_img;
            nh=Nh;
            Show_MRS_signal                % plot the MRS signals


       case 3
           
            
            figure (figr_num)
            plot(t,img,'b','LineWidth',2);hold on
            plot(t,noisy_img,'k','LineWidth',2);hold on
            plot(t, res_img,'g','LineWidth',2)
            plot(t, denoised_img ,'r','LineWidth',2);hold on
            legend('Suppressed Water spectrum [reference]','Complete  Spectrum ','SCSA Spectrum','Residual');
            xlabel('ppm')
            ylabel('Intensity')
            set(gca,'YTickLabel',[])
            xlim([0 5])
            title([ 'file ',noisy_file,' h = ' num2str(h), ' gm = ' num2str(gm), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , Nh= ', num2str(Nh), ' , N= ', num2str(N), ' samples'])
            set(gcf,'color','w') 
            set(gca,'Xdir','reverse');
            text(1.9,2e5,'NAA');text(1.55,2e5,'Lac(1)');text(1.35,2e5,'Lac(2)');text(4.5,2.6e7,'Water residue');

            box 

            figr_num=figr_num+1; 
            figure (figr_num)
            plot(t,img0,'g','LineWidth',2);
            hold on
            plot(t,res_img,'r','LineWidth',2);
            hold on
            plot(t, res_img-img0,'k','LineWidth',2)

            legend('Suppressed Water spectrum [reference]','SCSA Spectrum','Residual');
            xlabel('ppm')
            ylabel('Intensity')
            set(gca,'YTickLabel',[])
            xlim([0 5])
            title([ 'file ',noisy_file,' h = ' num2str(h), ' gm = ' num2str(gm), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , Nh= ', num2str(Nh), ' , N= ', num2str(N), ' samples'])
            set(gcf,'color','w') 
            set(gca,'Xdir','reverse');
            text(1.9,2e5,'NAA');text(1.4,2e5,'Lac(1)');text(1.35,2e5,'Lac(2)');text(4.5,1e6,'Water residue');
            box 

       otherwise
    
           disp('Signal cathgoy is not defined')
   end
   
   
 else
   
   
 %% or image

subplot(1, 4, 1);imshow(img);
    title(strcat('Original image '))
    xlabel(strcat( 'Size=', num2str(N), 'x', num2str(N), ' , SI= ', num2str(SI00)))
    ylabel(strcat(algo_type,'_',noisy_file))
    
subplot(1, 4, 2);imshow(noisy_img);
    title(strcat('Noisy image with noise =', SNR_dB))
    xlabel(strcat('SNR0=', num2str(SNR0), ' PSNR0=', num2str(PSNR0), ' SSIM=', num2str(SSIM0)))


    
subplot(1, 4, 3);imshow(denoised_img);
if adapt_scsa==1
        title(strcat('Denoised : h_{b}=', num2str(h2),', h_{c}=', num2str(h), ' ,  \gamma= ', num2str(gm), ' , fs=', num2str(fs) ))
        ylabel(strcat(' ,  Ns= ', num2str(Ns), ' , Np=', num2str(Np), ', Time=',num2str(exe_time),' sec'))

else
    title(strcat('Denoised image : h=', num2str(h), ' ,  \gamma= ', num2str(gm), ' , fs=', num2str(fs) ))
    ylabel(strcat('Time=',num2str(exe_time),' sec'))

end
xlabel(strcat( 'SNR= ', num2str(SNR), ' PSNR= ', num2str(PSNR), ' , SSIM= ', num2str(SSIM)))
lgnd_h=strcat('Average of Nh= ', num2str(floor(Nh)));

subplot(1, 4, 4);imshow(res_img);
    title('Residual Image ') ;  
     xlabel( lgnd_h )
     
 end    
set(figure(figr), 'units', 'normalized', 'outerposition', [0 0 1 1]) ;
 
%% Save results  
save_figure(dnz_image_mat ,figr,name_denoised_G )  

