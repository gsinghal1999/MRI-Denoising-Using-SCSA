%%
    %**********************************************************************
    %          Plot Segmentation denoising performance                    *
    %**********************************************************************

 % Modified by:  Abderrazak Chahid  
 % aberrazak.chahid@gmail.com
 % Original Author : Professor Taous_Meriem Laleg . EMAN Group KAUST 
 % taousmeriem.laleg@kaust.edu.sa 
 
 %% Description
 % Script plots the Prformance of  the SCSA algorithm  on 2D image of size n
 % using segmentiton technique
 
 % Done: Oct,  2016
 
%% input parapeters
% scsa_type : type of SCSA = [SCSA2D1D], [SCSA2D2D]
% lgnd_seg : algorithm UP-Seg, PCB-Seg
% figr : figure number
% filename0 : image name
% img: Noisy  image
% img_denoised: Denoised image
% fe : sampling frequency 
% h  : SCSA parameter
% gm  : SCSA parameter
% Nh : Mean Number of Eigen values chosen
% t1 : time of one block
% Ns : Namber of sub image per row/column
% Np : dimension of Padding
% img_denoised_segmt: Denoised segmented image 
% t2 :t1 : time of one block segmented image 
% Nh_seg :  Mean Number of Eigen values chosen for segmetation 

function Evaluation_Curve_zoom(scsa_type,lgnd_seg,figr,filename0,h,fe,gm,img,img_denoised,Nh,t1,Ns,Np,img_denoised_segmt,t2,Nh_seg)
Nh=floor(Nh);
Nh_seg=floor(Nh_seg);
[PSNR,SSIM]=image_evaluation(img,img_denoised);
[PSNR2,SSIM2]=image_evaluation(img,img_denoised_segmt);
SI_0=(floor(100*sharpness_index(img))/100);
SI_1=(floor(100*sharpness_index(img_denoised))/100);
SI_2=(floor(100*sharpness_index(img_denoised_segmt))/100);

%# plot  Original  image
% sz_img=max(size(img));
% figure(figr);subplot(2,2,1);imshow(img);
%         title(strcat('Noisy  image',scsa_type,num2str(sz_img),'x',num2str(sz_img)))
%         xlabel(strcat( 'gm=',num2str(gm),'  fe=',num2str(fe),'  SI = ',num2str(SI_0)))
%         ylabel(filename0(1:end-4))
% 
% subplot(2,2,2);imshow(img_denoised);
%     title(strcat('SCSA fixed h Denoised Image :  h=',num2str(h) , ' / Nh= ',num2str(Nh))) ;
%     xlabel(strcat('  PSNR = ',num2str(PSNR),'  SSIM = ',num2str(SSIM), '  SI = ',num2str(SI_1)))
%     ylabel(strcat('Time=',num2str(t1)))
%     
%  subplot(2,2,3);imshow(abs(img_denoised-img_denoised_segmt));
%     title('Residual |SCSA - Segmented|') ;
% 
% subplot(2,2,4);imshow(img_denoised_segmt);
%         title(strcat(lgnd_seg,' Nh = ',num2str(Nh_seg))) ; 
%         xlabel(strcat(' Ns = ',num2str(Ns),'  Np = ',num2str(Np),'  PSNR = ',num2str(PSNR2),'  SSIM = ',num2str(SSIM2), '  SI = ',num2str(SI_2)))
%         ylabel(strcat('Time=',num2str(t2)))
%             

           

%# plot  Zoom areas
sz_img=max(size(img));
figure(figr+1);subplot(1,3,1);imshow(img(x0:x0+dim,x0:x0+dim));
        title(strcat('Noisy  image',scsa_type,num2str(sz_img),'x',num2str(sz_img)))
        xlabel(strcat( 'gm=',num2str(gm),'  fe=',num2str(fe),'  SI = ',num2str(SI_0)))
        ylabel(filename0(1:end-4))

subplot(1,3,2);imshow(img_denoised(x0:x0+dim,x0:x0+dim));
    title(strcat('SCSA fixed h Denoised Image :  h=',num2str(h) , ' / Nh= ',num2str(Nh))) ;
    xlabel(strcat('  PSNR = ',num2str(PSNR),'  SSIM = ',num2str(SSIM), '  SI = ',num2str(SI_1)))
    ylabel(strcat('Time=',num2str(t1)))
    
subplot(1,3,3);imshow(img_denoised_segmt(x0:x0+dim,x0:x0+dim));
        title(strcat(lgnd_seg,' Nh = ',num2str(Nh_seg))) ; 
        xlabel(strcat(' Ns = ',num2str(Ns),'  Np = ',num2str(Np),'  PSNR = ',num2str(PSNR2),'  SSIM = ',num2str(SSIM2), '  SI = ',num2str(SI_2)))
        ylabel(strcat('Time=',num2str(t2)))
            
  
        
if save_fig==1
   mkdir(strcat( path_save_results,'pdf_files/'))
   mkdir(strcat( path_save_results,'figures/'))
   set(figure(figr),'units','normalized','outerposition',[0 0 1 1])
   set(figure(figr),'PaperOrientation','landscape');
   set(figure(figr),'PaperUnits','normalized');
   set(figure(figr),'PaperPosition', [0 0 1 1]);
   
   if seg_type==0 
       print(figure(figr), '-dpdf',strcat(path_save_results,'pdf_files/Zoom_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'.pdf'))
       saveas(figure(figr),strcat(path_save_results,'figures/Zoom_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'.fig'))               

   else
           print(figure(figr), '-dpdf',strcat(path_save_results,'pdf_files/Zoom_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'_Ns_',num2str(Ns),'_Np_',num2str(Np),'.pdf'))
           saveas(figure(figr),strcat(path_save_results,'figures/Zoom_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'_Ns_',num2str(Ns),'_Np_',num2str(Np),'.fig'))               
   end
        
end