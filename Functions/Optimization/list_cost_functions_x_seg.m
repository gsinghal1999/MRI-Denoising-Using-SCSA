%% the solved cost function is the fv1 in the slice of the signal <slice_mse>
% and provides the list of cost functions to compare in this optimization
% with the solved cost function 

function list_fv=list_cost_functions_x_seg(img,denoised_img,slice_mse,Np,Ns)
global fv_2_Show lgnd_fv mse_seg 

if mse_seg ==1
    img_slice=img(slice_mse); denoised_img_slice=denoised_img(slice_mse);
    lgnd_fv={'Cost functions are','optimize gm','f(x)_1= MSE [local]','f(x)_2=- PSNR[local]','f(x)_3=MSE_{Residual}[local]','f(x)_4= -PSNR_{Residual}[local]','f(x)_2= |\lambda _{<0}(H_h)|','f(x)_5= -|\lambda _{<0}(H_h)|',...
    'f(x)_6= |\lambda(H_h)|-1000*PSNR','f(x)_7= -|\lambda(H_h)|-1000*PSNR','f(x)_8= |\lambda_{<0}(H_h)|-1.5*PSNR','f(x)_9= -|\lambda_{<0}(H_h)|-1.5*PSNR',...
    'f(x)_10= |\lambda(H_h)|+|\lambda_{<0}(H_h)|'};

else
        img_slice=img; denoised_img_slice=denoised_img;
        lgnd_fv={'Cost functions are','optimize gm','f(x)_1= MSE','f(x)_2=- PSNR','f(x)_3=MSE_{Residual}','f(x)_4= -PSNR_{Residual}','f(x)_2= |\lambda _{<0}(H_h)|','f(x)_5= -|\lambda _{<0}(H_h)|',...
    'f(x)_6= |\lambda(H_h)|-1000*PSNR','f(x)_7= -|\lambda(H_h)|-1000*PSNR','f(x)_8= |\lambda_{<0}(H_h)|-1.5*PSNR','f(x)_9= -|\lambda_{<0}(H_h)|-1.5*PSNR',...
    'f(x)_10= |\lambda(H_h)|+|\lambda_{<0}(H_h)|'};

end

res_img=denoised_img_slice-img_slice;         % Residual image

%% Water 1024 [Residual ]
[PSNR, SSIM, SI00, SI_0, SNR, MSE]=image_evaluation(img_slice(Np+1:Np+Ns,Np+1:Np+Ns),denoised_img_slice(Np+1:Np+Ns,Np+1:Np+Ns));  
[PSNR_r, SSIM_r, SI00_r, SI_0_r, SNR_r, MSE_r]=image_evaluation(img_slice(Np+1:Np+Ns,Np+1:Np+Ns),res_img(Np+1:Np+Ns,Np+1:Np+Ns));  

%% ############# End  SCSA Script #######################  
fv1= MSE;
fv2=-PSNR;
fv3= MSE_r;
fv4=-PSNR_r;

list_fv0=[fv1 fv2 fv3 fv4];num_fv=1;
if fv_2_Show>max(size(list_fv0))
list_fv=list_fv0;    fv_2_Show=max(size(list_fv0)) ;
else
list_fv=list_fv0(1:fv_2_Show);

end
end