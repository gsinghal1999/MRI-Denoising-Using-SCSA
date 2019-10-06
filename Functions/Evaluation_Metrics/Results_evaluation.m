
function [SNR_Bright0, SNR_Dark0, SNR_Bright, SNR_Dark, SNR_Bright_r, SNR_Dark_r,std_imag_noisy, ...
               std_imag_denoised, std_imag_r,moy_imag_noisy, moy_imag_denoised, moy_imag_r]...
          = Results_evaluation(filename, Image,img_noisy, Denoised_image,x_vars,h,fe,gm)
% This function Plots the results of SCSA image processing 
global  sim_data show_PSNR
n=min(size(Image));
sz_ROI=x_vars(5); cntr=floor(sz_ROI/2);x0_Dark=x_vars(1)-cntr; y0_Dark=x_vars(2)-cntr; x0_Bright= x_vars(3)-cntr;y0_Bright=x_vars(4)-cntr;
%% Plot the results 
res_img=abs(img_noisy-Denoised_image);
[PSNR,SSIM,SI00,SI_1,SNR,MSE]=image_evaluation(Image,Denoised_image);
[PSNR_r,SSIM_r,SI00,SI_r,SNR_r,MSE_r]=image_evaluation(Image,res_img);

[SNR_Bright0, SNR_Dark0]=SNR_ROI(filename,img_noisy,x_vars,' Noisy image',2);
[SNR_Bright, SNR_Dark]=SNR_ROI(filename,Denoised_image,x_vars,strcat(' Denoised Image h=',num2str(h)),3);
[SNR_Bright_r, SNR_Dark_r]=SNR_ROI(filename,res_img,x_vars,strcat(' Residual Image h=',num2str(h)),5);
SI_0=(floor(1000*sharpness_index(img_noisy))/1000);

%% Image Statiscs

moy_imag_noisy=mean2(img_noisy);
moy_imag_denoised=mean2(Denoised_image);
moy_imag_r=mean2(res_img);

std_imag_noisy=std2(img_noisy);
std_imag_denoised=std2(Denoised_image);
std_imag_r=std2(res_img);

%% Figures

figure(4);
subplot(1,3,1);imshow(img_noisy);
        hEllipse = imellipse(gca,[x0_Dark y0_Dark sz_ROI sz_ROI]) ; % Second argument defines ellipse shape and position.
        hEllipse2 = imellipse(gca,[x0_Bright y0_Bright sz_ROI sz_ROI]); % Second argument defines ellipse shape and position.
        title(strcat('SNRB_{ROI} = ',num2str(floor(SNR_Bright0)), '  , SNRD_{ROI} = ',num2str(floor(SNR_Dark0)),' , SI=',num2str(SI_0)))
        ylabel(strcat(' File : ',filename))
        xlabel(strcat('Noisy image Size=  ',num2str(n),'*',num2str(n)))

subplot(1,3,2);imshow(Denoised_image);
        xlabel(strcat('Denoised image :  h=',num2str(h),'  gm=',num2str(gm),'  fe=',num2str(fe)))
        if sim_data==1 && show_PSNR==1
        title(strcat('SNRB_{ROI} = ',num2str(floor(SNR_Bright)), '  , SNRD_{ROI}= ',num2str(floor(SNR_Dark)),' , SI=',num2str(SI_1))) ;
        ylabel(strcat('PSNR    = ',num2str(floor(PSNR)) ,'  , SSIM = ',num2str(SSIM)))
        else
        title(strcat('SNRB_{ROI} = ',num2str(floor(SNR_Bright)), '  , SNRD_{ROI}= ',num2str(floor(SNR_Dark)),' , SI=',num2str(SI_1))) ;
        end
        hEllipse = imellipse(gca,[x0_Dark y0_Dark sz_ROI sz_ROI]) ; % Second argument defines ellipse shape and position.
        hEllipse2 = imellipse(gca,[x0_Bright y0_Bright sz_ROI sz_ROI]); % Second argument defines ellipse shape and position.

subplot(1,3,3);imshow(res_img);
        xlabel('Residual')
        hEllipse = imellipse(gca,[x0_Dark y0_Dark sz_ROI sz_ROI]) ; % Second argument defines ellipse shape and position.
        hEllipse2 = imellipse(gca,[x0_Bright y0_Bright sz_ROI sz_ROI]); % Second argument defines ellipse shape and position.
%         title(strcat('SNRBR = ',num2str(floor(SNR_Bright_r)), '  , SNRDR = ',num2str(floor(SNR_Dark_r)),'  PSNR = ',num2str(PSNR), '  SSIM = ',num2str(SSIM))) ;
        if sim_data==1 && show_PSNR==1       
        title(strcat('SNRBR_{ROI}  = ',num2str(floor(SNR_Bright_r)), '  , SNRDR_{ROI}  = ',num2str(floor(SNR_Dark_r)),' , SI=',num2str(SI_r) ));
        ylabel(strcat('PSNR_{[Res]}  = ',num2str(floor(PSNR_r)),'  , SSIM_{[Res]}  = ',num2str(SSIM_r)))

        else
            title(strcat('SNRBR_{ROI}  = ',num2str(floor(SNR_Bright_r)), '  , SNRDR_{ROI}  = ',num2str(floor(SNR_Dark_r)),' , SI=',num2str(SI_r)));
        end

set(figure(4),'units','normalized','outerposition',[0 0 1 1]) 


function [SNR_Bright SNR_Dark]=SNR_ROI(filename, Image,x_vars,name_imag,figr)
global  show_figrs formul_ROI Bright_th Dark_th


% This function computes the SNR of the Bright and dark ROIs located by
% x_vars= [x0_Dark y0_Dark x0_Bright y0_Bright sz_ROI ] 
% SNR = (peak(Image)) / std(ROI)

n=min(size(Image));
sz_ROI=x_vars(5); cntr=floor(sz_ROI/2);x0_Dark=x_vars(3)-cntr; y0_Dark=x_vars(4)-cntr; x0_Bright= x_vars(1)-cntr;y0_Bright=x_vars(2)-cntr;

figure(figr);
subplot(3,3, 1);
        imshow(Image);
        title(name_imag)
        xlabel(strcat(' Size=  ',num2str(n),'*',num2str(n)))
        ylabel(strcat(' File :  ',filename))

subplot(3,3, 2);
        imshow(Image);
        title(strcat('ROIs in the',name_imag));

% %----- Burn ellipse into image -----
% % Create elliptical mask, h, as an ROI object over the second image.
subplot(3,3, 2);
        hEllipse = imellipse(gca,[x0_Dark y0_Dark sz_ROI sz_ROI]) ; % Second argument defines ellipse shape and position.
        hEllipse2 = imellipse(gca,[x0_Bright y0_Bright sz_ROI sz_ROI]); % Second argument defines ellipse shape and position.
% Create a binary image ("mask") from the ROI object.


Image_Dark= Image;
binaryImage1 = hEllipse.createMask();
Image_Dark(~binaryImage1) = 0;

Image_Bright= Image;
binaryImage2 = hEllipse2.createMask();
Image_Bright(~binaryImage2) = 0;

Image0= Image;
binaryImage=binaryImage1 + binaryImage2;
Image0(~binaryImage) = 0;

subplot(3,3, 3);
        imshow(Image0);
        title('ROIs Masks ');



%% compute SNR of the Dark  ROIs
ROI_Dark=Image_Dark(y0_Dark:y0_Dark+sz_ROI-1,x0_Dark:x0_Dark+sz_ROI-1);
man_var0=ROI_Dark(:);
vect_Dark=man_var0(find(man_var0>0 & man_var0<Dark_th));

th_signal=max(max(Image));
th_noise=max(vect_Dark);vect_Dark_peak=th_noise*ones(size(vect_Dark));

if formul_ROI==1
    
estim_signal_Dark=max(max(Image));
estim_noise_Dark=std2(vect_Dark);

end

SNR_Dark=estim_signal_Dark/estim_noise_Dark;


subplot(3,3, 4);
        imshow(ROI_Dark);
        title('Dark ROI');
        xlabel(strcat('SNR= ',num2str(SNR_Dark)))
       
subplot(3,3, 5:6);
        plot(vect_Dark);
        title('Dark ROI Variation');
%         hline = refline([0 th_signal]);
%         hline.Color = 'r';
%         hline.LineWidth =2;
%         hline1 = refline([0 th_noise]);
%         hline1.Color = 'g';
%         hline1.LineWidth =2;
      legend('Dark Pixels in signal format','High__Threshold','Low__Threshold')
      
%  subplot(3,3, 6);
%         plot(vect_Dark_peak);
%         hold on
%         plot(vect_Dark_noise);
%         hold off
%         title('Dark ROI signal and Noise');
%         legend('Estimated Signal','Estimated Noise')
%         
               
%% compute SNR of the d Bright ROIs  
% ROI_Bright=Image_Bright(x0_Bright:x0_Bright+-1,y0_Bright:y0_Bright-1);
ROI_Bright=Image_Bright(y0_Bright:y0_Bright+sz_ROI-1,x0_Bright:x0_Bright+sz_ROI-1);
man_var0=ROI_Bright(:);

vect_Bright=man_var0(find(man_var0>Bright_th));
th_signal=max(max(Image));
th_noise=max(vect_Bright);

if formul_ROI==1
    
estim_signal_Bright=max(max(Image));
estim_noise_Bright=std2(vect_Bright);

end

SNR_Bright=estim_signal_Bright/estim_noise_Bright;


subplot(3,3, 7);
        imshow(ROI_Bright);
        title('Bright ROI');
        xlabel(strcat('SNR= ',num2str(SNR_Bright)))
        
 
        


subplot(3,3, 8:9);
        plot(vect_Bright);
        title('Bright ROI Variation');
%         hline = refline([0 th_signal]);
%         hline.Color = 'r';
%         hline.LineWidth =2;
%         hline1 = refline([0 th_noise]);
%         hline1.Color = 'g';
%         hline1.LineWidth =2;
        legend('Bright Pixels in signal format','High__Threshold','Low__Threshold')     
        
        
%  subplot(3,3, 9);
%         plot(vect_Bright_peak);
%         hold on
%         plot(vect_Bright_noise);
%         title('Bright ROI signal and Noise');
%         legend('Estimated Signal','Estimated Noise')
%         hold off

set(figure(figr),'units','normalized','outerposition',[0 0 1 1]) 

% if  show_figrs==0
% 
% close(figure(figr));
% end

% 
% %------------------------------ PERDECOMP ------------------------------
% 
% %       Periodic plus Smooth Image Decomposition
% %
% %               author: Lionel Moisan
% %
% %   This program is freely available on the web page
% %
% %   http://www.mi.parisdescartes.fr/~moisan/p+s
% %
% %   I hope that you will find it useful.
% %   If you use it for a publication, please mention 
% %   this web page and the paper it makes reference to.
% %   If you modify this program, please indicate in the
% %   code that you did so and leave this message.
% %   You can also report bugs or suggestions to 
% %   lionel.moisan [AT] parisdescartes.fr
% %
% % This function computes the periodic (p) and smooth (s) components
% % of an image (2D array) u
% %
% % usage:    p = perdecomp(u)    or    [p,s] = perdecomp(u)
% %
% % note: this function also works for 1D signals (line or column vectors)
% %
% % v1.0 (01/2014): initial Matlab version from perdecomp.sci v1.2
% 
% function [p,s] = perdecomp(u)
% 
% [ny,nx] = size(u); 
% u = double(u);
% X = 1:nx; Y = 1:ny;
% v = zeros(ny,nx);
% v(1,X)  = u(1,X)-u(ny,X);
% v(ny,X) = -v(1,X);
% v(Y,1 ) = v(Y,1 )+u(Y,1)-u(Y,nx);
% v(Y,nx) = v(Y,nx)-u(Y,1)+u(Y,nx);
% fx = repmat(cos(2.*pi*(X -1)/nx),ny,1);
% fy = repmat(cos(2.*pi*(Y'-1)/ny),1,nx);
% fx(1,1)=0.;   % avoid division by 0 in the line below
% s = real(ifft2(fft2(v)*0.5./(2.-fx-fy)));
% p = u-s;
% 
% 
% %--------------------------------- DEQUANT ---------------------------------
% %
% % author: Lionel Moisan                                   
% %
% % Image dequantization using a (1/2,1/2) translation in Fourier domain 
% %
% % reference: A. Desolneux, S. Ladjal, L. Moisan, J.-M. Morel, 
% % "Dequantizing image orientation", IEEE Transactions on Image Processing,
% % vol. 11(10), pp. 1129-1140, 2002.
% %
% % usage:   v = dequant(u)
% %
% % input: a 2D array (Matlab matrix)
% % output: a 2D array (same size as u)
% %
% % v1.0 (02/2014): initial version 
% 
% function v = dequant(u)
% 
% [ny,nx] = size(u);
% mx = floor(nx/2); my = floor(ny/2);
% Tx = exp(-i*pi/nx*( mod(mx:mx+nx-1,nx)-mx ));
% Ty = exp(-i*pi/ny*( mod(my:my+ny-1,ny)-my ));
% v = real(ifft2(fft2(u).*(Ty.'*Tx))); 
% 
% 
% %--------------------------------- LOGERFC ---------------------------------
% %
% % author: Lionel Moisan                                   
% %
% % Compute the logarithm of the complementary error function for any x
% %
% % usage:   y = logerfc(x)
% %
% % for x<=20, logerfc(x) = log(erfc(x)) 
% % for x>20, a direct asymptotic formula is used to avoid machine underflow
% %
% % note: x can also be a vector or a matrix
% %
% % v1.0 (02/2014): initial version 
% % v1.1 (02/2014): extension to x vector or matrix
% 
% function y = logerfc(x)
%   y = x;
%   T = (x>20);
%   if sum(T(:))>0
%     X = x(T);
%     z = X.^(-2);
%     s = ones(size(X));
%     for k=8:-1:1
%       s = 1-(k-0.5)*z.*s;
%     end
%     y(T) = -0.5*log(pi)-X.^2+log(s./X);
%   end
%   y(~T) = log(erfc(x(~T)));
% 
%  
%   
%   
% %------------------------- sharpness_index -------------------------
% 
% %    Compute the sharpness index (SI) of a numerical image
% %
% %               author: Lionel Moisan
% %
% %  This program is freely available on the web page
% %
% %     http://www.mi.parisdescartes.fr/~moisan/sharpness/
% %
% %  It implements the Sharpness Index (SI) described in the paper
% %
% %  G. Blanchet, L. Moisan, An explicit Sharpness Index related to
% %  Global Phase Coherence, proceedings of the IEEE International Conference 
% %  on Acoustics, Speech, and Signal Processing (ICASSP), pp. 1065-1068, 2012. 
% %
% %  If you use it for a publication, please mention this paper
% %  If you modify this program, please indicate in the code that you 
% %  did so and leave this message.
% %  You can report bugs or suggestions to lionel.moisan [AT] parisdescartes.fr
% %
% % usage:    si = sharpness_index(u)   or   si = sharpness_index(u,pmode) 
% %
% % u is an image (a 2D array = a Matlab matrix)
% %
% % available preprocessing modes are:
% %
% % pmode = 0             raw sharpness index of u
% % pmode = 1             sharpness index of the periodic component of u 
% % pmode = 2             sharpness index of the 1/2,1/2-translated of u 
% % pmode = 3 (default)   sharpness index of the 1/2,1/2-translated 
% %                       of the periodic component of u
% %
% % Default mode (pmode = 3) should be used, unless you want to work on very
% % specific images that are naturally periodic or not quantized (see paper)
% %
% % note: this function also works for 1D signals (line or column vectors)
% %
% % v1.0 (02/2014): initial version from sharpness_index.sci v1.4
% 
% % dependencies: dequant, perdecomp, logerfc
% 
% 
% function si = sharpness_index(u,pmode)
% 
% if (nargin<2) pmode = 3; end
% if (pmode==1) | (pmode==3) u = perdecomp(u); end
% if (pmode==2) | (pmode==3) u = dequant(u); end
% u = double(u);
% [ny,nx] = size(u);
% gx = u(:,[2:nx,1])-u; fgx = fft2(gx);
% gy = u([2:ny,1],:)-u; fgy = fft2(gy);
% tv = sum(sum(abs(gx)+abs(gy)));
% Gxx = real(ifft2(fgx.*conj(fgx)));
% Gyy = real(ifft2(fgy.*conj(fgy)));
% Gxy = real(ifft2(fgx.*conj(fgy)));
% oomega = @(t) real(t.*asin(t)+sqrt(1-t.^2)-1);
% var = 0;
% axx = Gxx(1,1);      if (axx>0) var = var+  axx*sum(sum(oomega(Gxx/axx))); end
% ayy = Gyy(1,1);      if (ayy>0) var = var+  ayy*sum(sum(oomega(Gyy/ayy))); end
% axy = sqrt(axx*ayy); if (axy>0) var = var+2*axy*sum(sum(oomega(Gxy/axy))); end
% var = var*2/pi;
% if var>0 
%   % t = ( E(TV)-tv )/sqrt(var(TV))
%   t = ( (sqrt(axx)+sqrt(ayy))*sqrt(2*nx*ny/pi) - tv )/sqrt(var);
%   % si = -log10(P(N(0,1)>t))
%   si = -logerfc(t/sqrt(2))/log(10)+log10(2); 
% else 
%   si = 0; 
% end
