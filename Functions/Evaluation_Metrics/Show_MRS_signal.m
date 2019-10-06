% img0=img0-min(img0);
% denoised_img0=denoised_img0-min(denoised_img0);
% noisy_img=noisy_img-min(noisy_img);
if slice_seg==0
remove_spect=abs(denoised_img0-noisy_img)
remove_spect=remove_spect-remove_spect(845)+img0(845);
else
remove_spect=denoised_img0;
end
% compute_area

figr_num=figr;
figure (figr_num)
plot(t,img0,'g','LineWidth',2);hold on
plot(t,noisy_img,'b','LineWidth',2);hold on
% plot(t, denoised_img0,'r','LineWidth',2);hold on
plot(t,remove_spect,'r','LineWidth',2)
legend('Suppressed Water spectrum [reference]','Complete  Spectrum ',lgnd_scsa,'Residual Spectrum');
xlabel('ppm');ylabel('Intensity');set(gca,'YTickLabel',[]); xlim([0 5])
% title([ 'file ',noisy_file,' scsa_w = ' num2str(scsa_w), ', scsa_NA = ' num2str(scsa_NA), ' , scsa_Lac= ' num2str(scsa_Lac), ' , ref_w = ', num2str(ref_w), ' ,  ref_NA = ', num2str(ref_NA), ' , ref_Lac= ', num2str(ref_Lac), ' , p_w= ', num2str(p_w),' ,  p_NA = ', num2str(p_NA), ' , p_Lac= ', num2str(p_Lac)  ])
set(gcf,'color','w') ;set(gca,'Xdir','reverse');
m_txt=max([img,denoised_img0,noisy_img]);
text(1.9,1.6e6,'NAA');text(1.55,1.6e6,'Lac(1)');text(1.3,1.6e6,'Lac(2)');text(4.5,m_txt,'Water residue');
box 



res_img1=denoised_img0-noisy_img;

figr_num=figr_num+1; 
figure (figr_num)
plot(t,img0,'g','LineWidth',2);hold on
plot(t,remove_spect,'r','LineWidth',2)
legend('Suppressed Water spectrum [reference]','SCSA Spectrum ','Residual');
xlabel('ppm');ylabel('Intensity');set(gca,'YTickLabel',[]);xlim([0 5])
title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
set(gcf,'color','w') ;set(gca,'Xdir','reverse');m_txt=max([res_img1,img0]);
text(1.9,2e5,'NAA');text(1.5,1.5e5,'Lac(1)');text(1.35,1e5,'Lac(2)');text(4.5,m_txt,'Water residue');
box 

figr_num=figr_num+1; 
figure (figr_num)
plot(t,img0,'g','LineWidth',2);hold on
plot(t,remove_spect,'r','LineWidth',2)
legend('Suppressed Water spectrum [reference]',strcat('SCSA Spectrum with nh= ', num2str(nh)),'Residual');
xlabel('ppm');ylabel('Intensity')
xlim([3.0 5]);ylim([-2.e5 2.5e5]);set(gca,'YTickLabel',[])
title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
set(gcf,'color','w') ;set(gca,'Xdir','reverse');
m_txt=1e5;
text(1.9,2e5,'NAA');text(1.53,1.4e5,'Lac(1)');text(1.33,0.8e5,'Lac(2)');text(4.6,m_txt,'Water residue');
box 

figr_num=figr_num+1; 
figure (figr_num)
plot(t,img0,'g','LineWidth',2);hold on
plot(t,remove_spect,'r','LineWidth',2)
legend('Suppressed Water spectrum [reference]',strcat('SCSA Spectrum with nh= ', num2str(nh)),'Residual');
xlabel('ppm');ylabel('Intensity')
xlim([.8 2.2]);ylim([-2.e5 2.5e5]);set(gca,'YTickLabel',[])
title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
set(gcf,'color','w') ;set(gca,'Xdir','reverse');m_txt=max([res_img1,img0]);
text(1.9,2e5,'NAA');text(1.53,1.4e5,'Lac(1)');text(1.33,0.8e5,'Lac(2)');text(4.5,m_txt,'Water residue');
box 


% 
% 
% 
% figr_num=figr_num+1; 
% figure (figr_num)
% plot(t,img0','g','LineWidth',2);hold on
% plot(t, res_img,'r','LineWidth',2);hold on
% % plot(t, res_img1,'k','LineWidth',2)
% legend('Suppressed Water spectrum [reference]','SCSA Spectrum ','Residual');
% xlabel('ppm');ylabel('Intensity');set(gca,'YTickLabel',[]);xlim([0 5])
% title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
% set(gcf,'color','w') ;set(gca,'Xdir','reverse');m_txt=max([res_img1,res_img,img0,]);
% text(1.9,2e5,'NAA');text(1.5,1.5e5,'Lac(1)');text(1.35,1e5,'Lac(2)');text(4.5,m_txt,'Water residue');
% box 
% 
% 
% figr_num=figr_num+1; 
% figure (figr_num)
% plot(t,img0','g','LineWidth',2);hold on
% plot(t, res_img,'r','LineWidth',2);hold on
% % plot(t,  res_img1,'k','LineWidth',2)
% legend('Suppressed Water spectrum [reference]',strcat('SCSA Spectrum with nh= ', num2str(nh)),'Residual');
% xlabel('ppm');ylabel('Intensity')
% xlim([.8 2.2]);ylim([-2.e5 2.5e5]);set(gca,'YTickLabel',[])
% title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
% set(gcf,'color','w') ;set(gca,'Xdir','reverse');m_txt=max([res_img1,res_img,img0,]);
% text(1.9,2e5,'NAA');text(1.53,1.4e5,'Lac(1)');text(1.33,0.8e5,'Lac(2)');text(4.5,m_txt,'Water residue');
% box 
% 
% figr_num=figr_num+1; 
% figure (figr_num)
% plot(t,img0','g','LineWidth',2);hold on
% plot(t, res_img,'r','LineWidth',2);hold on
% % plot(t,  res_img1,'k','LineWidth',2)
% legend('Suppressed Water spectrum [reference]',strcat('SCSA Spectrum with nh= ', num2str(nh)),'Residual');
% xlabel('ppm');ylabel('Intensity')
% xlim([3.0 5]);ylim([-2.e5 2.5e5]);set(gca,'YTickLabel',[])
% title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
% set(gcf,'color','w') ;set(gca,'Xdir','reverse');
% m_txt=1e5;
% text(1.9,2e5,'NAA');text(1.53,1.4e5,'Lac(1)');text(1.33,0.8e5,'Lac(2)');text(4.6,m_txt,'Water residue');
% box 
% 







% 
% figr_num=figr_num+1; 
% figure (figr_num)
% plot(t,img0,'g','LineWidth',2);hold on
% plot(t,noisy_img,'b','LineWidth',2);hold on
% plot(t, res_img,'r','LineWidth',2);hold on
% plot(t, denoised_img0 ,'k','LineWidth',2)
% legend('Suppressed Water spectrum [reference]','Complete  Spectrum ',lgnd_scsa,'Residual Spectrum');
% xlabel('ppm');ylabel('Intensity');set(gca,'YTickLabel',[]);
% xlim([.8 2.2]);ylim([-2.e5 2.5e5]);set(gca,'YTickLabel',[])
% title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
% set(gcf,'color','w') ;set(gca,'Xdir','reverse');m_txt=max([img,denoised_img0,noisy_img]);
% text(1.9,1.6e6,'NAA');text(1.55,1.6e6,'Lac(1)');text(1.3,1.6e6,'Lac(2)');text(4.5,m_txt,'Water residue');
% box 
% 
% 
% figr_num=figr_num+1; 
% figure (figr_num)
% plot(t,img0','g','LineWidth',2);hold on
% plot(t, res_img,'r','LineWidth',2);hold on
% % plot(t, res_img1,'k','LineWidth',2)
% legend('Suppressed Water spectrum [reference]','SCSA Spectrum ','Residual');
% xlabel('ppm');ylabel('Intensity');set(gca,'YTickLabel',[]);xlim([0 5])
% title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
% set(gcf,'color','w') ;set(gca,'Xdir','reverse');m_txt=max([res_img1,res_img,img0,]);
% text(1.9,2e5,'NAA');text(1.5,1.5e5,'Lac(1)');text(1.35,1e5,'Lac(2)');text(4.5,m_txt,'Water residue');
% box 
% 
% figr_num=figr_num+1; 
% figure (figr_num)
% plot(t,img0,'g','LineWidth',2);hold on
% plot(t,noisy_img,'b','LineWidth',2);hold on
% plot(t, res_img,'r','LineWidth',2);hold on
% % plot(t, denoised_img0 ,'k','LineWidth',2)
% legend('Suppressed Water spectrum [reference]','Complete  Spectrum ',lgnd_scsa,'Residual Spectrum');
% xlabel('ppm');ylabel('Intensity');set(gca,'YTickLabel',[]); xlim([0 5])
% title([ 'file ',noisy_file,' h = ' num2str(h), ', \gamma = ' num2str(gm), ' , fs = ' num2str(fs), ' , PSNR0 = ', num2str(PSNR0), ' ,  PSNR = ', num2str(PSNR), ' , nh= ', num2str(nh), ' , N= ', num2str(N), ' samples'])
% set(gcf,'color','w') ;set(gca,'Xdir','reverse');m_txt=max([img,denoised_img0,noisy_img]);
% text(1.9,1.6e6,'NAA');text(1.55,1.6e6,'Lac(1)');text(1.3,1.6e6,'Lac(2)');text(4.5,m_txt,'Water residue');
% box 
