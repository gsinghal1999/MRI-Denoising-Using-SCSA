% This function returns the SNR and PSNR SSIM between the  Original_image and Noisy_image

function [PSNR,SSIM,SI_0,SI_1,SNR,MSE,cross_core]=image_evaluation(Original_image,Noisy_image)
Noisy_image=double(Noisy_image);Original_image= double(Original_image);
[m0 n0]=size(Noisy_image);
[m1 n1]=size(Original_image);

if (m0 ~= m1 | n0~=n1)
    flag=1;
end
% Evaluate the denoised image
MSE = mean2((Noisy_image - Original_image).^2);
[SSIM, SSIM_img] = ssim(Noisy_image,Original_image);
SNR=snr(Noisy_image,Original_image);
PSNR=psnr(Noisy_image,Original_image);
SI_0=(floor(100*sharpness_index(Original_image))/100);
SI_1=(floor(100*sharpness_index(Noisy_image))/100);


%Cross correlation 
cc = corrcoef(Original_image,Noisy_image);
sz_cc=max(size(cc));
if sz_cc==1
    cross_core=cc;
else
cross_core = cc(1,2);
end

%% precise 10^-2 precision
SSIM=floor(SSIM*1000)/1000;
% MSE=floor(MSE*1000)/1000;
SNR=floor(SNR*1000)/1000;
PSNR=floor(PSNR*1000)/1000;

