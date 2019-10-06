

function plot_performnce(img_orgin,img_orgin0,img_denoised,h,gm,fe,figr)
n=min(size(img_orgin));
%% Evaluation

[PSNR SNR MSE SSIM ERR]=image_evaluation(img_orgin,img_denoised);
img_denoised=im2single(img_denoised);
img_orgin0=im2single(img_orgin0);
img_orgin=im2single(img_orgin);


%%  Plot

figure(figr);
subplot(2,2,1);imshow(img_orgin,[]);
title(strcat(' Size=  ',num2str(n),'*',num2str(n)))
xlabel('Original  image')

subplot(2,2,2);imshow(img_orgin0,[]);
title(strcat(' Size=  ',num2str(n),'*',num2str(n)))
xlabel('Reference  image')

subplot(2,2,3);imshow(img_denoised,[]);title('Denoised Image') ;
xlabel(strcat('Denoised image :  h=',num2str(h),'  gm=',num2str(gm),'  fe=',num2str(fe)))
title(strcat('SNR = ',num2str(floor(SNR)), '  PSNR = ',num2str(floor(PSNR)), '  MSE = ',num2str(MSE), '  SSIM = ',num2str(SSIM))) ;

subplot(2,2,4);imshow(abs(img_orgin-img_denoised),[]);

xlabel('Residual')

% set(figure(figr),'units','normalized','outerposition',[0 0 1 1])




