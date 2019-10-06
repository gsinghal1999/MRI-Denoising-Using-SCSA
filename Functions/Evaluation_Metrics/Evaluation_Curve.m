%%
    %**********************************************************************
    %                      Plot denoising performance [output =images]                   *
    %**********************************************************************

 % Modified by:  Abderrazak Chahid  
 % aberrazak.chahid@gmail.com
 % Original Author : Professor Taous_Meriem Laleg . EMAN Group KAUST 
 % taousmeriem.laleg@kaust.edu.sa 
 
 %% Description
 % Script plots the [rformance of  the SCSA algorithm  on 2D image of size n 
 
 % Done: Oct,  2016
 
%% input parapeters
% scsa_type : type of SCSA = [SCSA2D1D], [SCSA2D2D]
% algo_type : algorithm [One Block]
% figr : figure number
% filename0 : image name
% noisy_image: Noisy  image
% img_denoised: Denoised image
% fe : sampling frequency 
% h  : SCSA parameter
% gm  : SCSA parameter
% Nh : Mean Number of Eigen values chosen
% Ns : Namber of sub image per row/column
% Np : dimension of Padding
% path_save_results
% save_fig:  save figure if =1
% seg_type : 1=>PU-Seg  ,   2=>PPCB-Seg  ,

function [SI00,SI_0,PSNR0,SSIM0]=Evaluation_Curve(scsa_type,algo_type,figr,filename0,img,noisy_img,img_denoised,h,fe,gm,Nh,Ns,Np,path_save_results,save_fig,seg_type)
Nh=floor(Nh);
size_img=size(img);noisy_img = im2single(imresize(noisy_img,size_img));  
[PSNR0,SSIM0,SI00,SI_0]=image_evaluation(img,noisy_img);
[PSNR,SSIM,SI_0,SI_1]=image_evaluation(img,img_denoised);

sz_img=max(size(noisy_img));
sub_sz=seg_sz+2;
h_set=strcat(' h_{border} = ',num2str(h(1)),'  h_{center} =',num2str(h(2)),'  \gamma =',num2str(gm(1)));
   
%# plot  Original  image
angle=0;
figure(figr);

subplot(2,sub_sz,1);imshow(imrotate(noisy_img,angle));
        title('Noisy image')
        xlabel(strcat( 'PSNR=',num2str(PSNR0),' SSIM=',num2str(SSIM0),'  SI = ',num2str(SI00)))
        ylabel(scsa_type)

subplot(2,sub_sz,sub_sz+1);imshow(imrotate(img,angle));
        title(strcat('Original image'))
        xlabel(strcat( 'Size=',num2str(sz_img),'x',num2str(sz_img),'  SI = ',num2str(SI00)))
        ylabel(filename0(1:end-4))
        
subplot(2,sub_sz,2);imshow(imrotate(img_denoised,angle));
        title(algo_type)
        ylabel(h_set0)
        xlabel(strcat( '  Nh= ',num2str(Nh), '  PSNR = ',num2str(PSNR),'  SSIM = ',num2str(SSIM),'  SI = ',num2str(SI_1)))

 subplot(2,sub_sz,sub_sz+2);imshow(imrotate(abs(img_denoised-img),angle));
        title('Residual Image ') ;    
        xlabel('| Denoised Image - Original Image | ')
    
    


if save_fig==1
   mkdir(strcat( path_save_results,'pdf_files/'))
   mkdir(strcat( path_save_results,'figures/'))
   set(figure(figr),'units','normalized','outerposition',[0 0 1 1])
   set(figure(figr),'PaperOrientation','landscape');
   set(figure(figr),'PaperUnits','normalized');
   set(figure(figr),'PaperPosition', [0 0 1 1]);
   if seg_type==0 
       print(figure(figr), '-dpdf',strcat(path_save_results,'pdf_files/P_',num2str(figr),'_N',num2str(sz_img),'_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'.pdf'))
       saveas(figure(figr),strcat(path_save_results,'figures/P_',num2str(figr),'_N',num2str(sz_img),'_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'.fig'))               

   else
           print(figure(figr), '-dpdf',strcat(path_save_results,'pdf_files/P_',num2str(figr),'_N',num2str(sz_img),'_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'_Ns_',num2str(Ns),'_Np_',num2str(Np),'.pdf'))
           saveas(figure(figr),strcat(path_save_results,'figures/P_',num2str(figr),'_N',num2str(sz_img),'_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'_Ns_',num2str(Ns),'_Np_',num2str(Np),'.fig'))               
   end
   
end


end



% %%
%     %**********************************************************************
%     %                      Plot denoising performance [output =images]                   *
%     %**********************************************************************
% 
%  % Modified by:  Abderrazak Chahid  
%  % aberrazak.chahid@gmail.com
%  % Original Author : Professor Taous_Meriem Laleg . EMAN Group KAUST 
%  % taousmeriem.laleg@kaust.edu.sa 
%  
%  %% Description
%  % Script plots the [rformance of  the SCSA algorithm  on 2D image of size n 
%  
%  % Done: Oct,  2016
%  
% %% input parapeters
% % scsa_type : type of SCSA = [SCSA2D1D], [SCSA2D2D]
% % algo_type : algorithm [One Block]
% % figr : figure number
% % filename0 : image name
% % noisy_image: Noisy  image
% % img_denoised: Denoised image
% % fe : sampling frequency 
% % h  : SCSA parameter
% % gm  : SCSA parameter
% % Nh : Mean Number of Eigen values chosen
% % Ns : Namber of sub image per row/column
% % Np : dimension of Padding
% % path_save_results
% % save_fig:  save figure if =1
% % seg_type : 1=>PU-Seg  ,   2=>PPCB-Seg  ,
% 
% 
% function [SI00,SI_0,PSNR0,SSIM0]=Evaluation_Curve(angle,seg_sz,pos,scsa_type,algo_type,figr,filename0,img,noisy_img,img_denoised,h,fe,gm,Nh,Ns,Np,path_save_results,save_fig,seg_type)
% Nh=floor(Nh);
% size_img=size(img);noisy_img = im2single(imresize(noisy_img,size_img));  
% [PSNR0,SSIM0,SI00,SI_0]=image_evaluation(img,noisy_img);
% [PSNR,SSIM,SI_0,SI_1]=image_evaluation(img,img_denoised);
% 
% sz_img=max(size(noisy_img));
% sub_sz=seg_sz+2;
% h_set=strcat(' h_{border} = ',num2str(h(1)),'  h_{center} =',num2str(h(2)),'  \gamma =',num2str(gm(1)));
%    
% %# plot  Original  image
% 
% figure(figr);
% if pos ==0
%     h_set0=strcat(' h = ',num2str(h(1)),' gm = ',num2str(gm(1)));
% subplot(2,sub_sz,1);imshow(imrotate(noisy_img,angle));
%         title('Noisy image')
%         xlabel(strcat( 'PSNR=',num2str(PSNR0),' SSIM=',num2str(SSIM0),'  SI = ',num2str(SI00)))
%         ylabel(scsa_type)
% 
% subplot(2,sub_sz,sub_sz+1);imshow(imrotate(img,angle));
%         title(strcat('Original image'))
%         xlabel(strcat( 'Size=',num2str(sz_img),'x',num2str(sz_img),'  SI = ',num2str(SI00)))
%         ylabel(filename0(1:end-4))
%         
% subplot(2,sub_sz,2);imshow(imrotate(img_denoised,angle));
%         title(algo_type)
%         ylabel(h_set0)
%         xlabel(strcat( '  Nh= ',num2str(Nh), '  PSNR = ',num2str(PSNR),'  SSIM = ',num2str(SSIM),'  SI = ',num2str(SI_1)))
% 
%  subplot(2,sub_sz,sub_sz+2);imshow(imrotate(abs(img_denoised-img),angle));
%         title('Residual Image ') ;    
%         xlabel('| Denoised Image - Original Image | ')
%     
%     
% else
% 
% subplot(2,sub_sz,pos+2);imshow(imrotate(img_denoised,angle));
%     title(algo_type)
%     ylabel(h_set)
%     xlabel(strcat( '  Nh= ',num2str(Nh), '  PSNR = ',num2str(PSNR),'  SSIM = ',num2str(SSIM),'  SI = ',num2str(SI_1)))
%     
%  subplot(2,sub_sz,sub_sz+pos+2);imshow(imrotate(abs(img_denoised-img),angle));  
%     title('Residual Image ') ;    
%     xlabel('| Denoised Image - Original Image | ')
%     
% %% save fig pdf
% end
% 
% if save_fig==1
%    mkdir(strcat( path_save_results,'pdf_files/'))
%    mkdir(strcat( path_save_results,'figures/'))
%    set(figure(figr),'units','normalized','outerposition',[0 0 1 1])
%    set(figure(figr),'PaperOrientation','landscape');
%    set(figure(figr),'PaperUnits','normalized');
%    set(figure(figr),'PaperPosition', [0 0 1 1]);
%    if seg_type==0 
%        print(figure(figr), '-dpdf',strcat(path_save_results,'pdf_files/P_',num2str(figr),'_N',num2str(sz_img),'_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'.pdf'))
%        saveas(figure(figr),strcat(path_save_results,'figures/P_',num2str(figr),'_N',num2str(sz_img),'_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'.fig'))               
% 
%    else
%            print(figure(figr), '-dpdf',strcat(path_save_results,'pdf_files/P_',num2str(figr),'_N',num2str(sz_img),'_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'_Ns_',num2str(Ns),'_Np_',num2str(Np),'.pdf'))
%            saveas(figure(figr),strcat(path_save_results,'figures/P_',num2str(figr),'_N',num2str(sz_img),'_',num2str(seg_type),'_h_b_',num2str(h(1)),'_h_c_',num2str(h(2)),'_Ns_',num2str(Ns),'_Np_',num2str(Np),'.fig'))               
%    end
%    
% end
% 
% 
% end
