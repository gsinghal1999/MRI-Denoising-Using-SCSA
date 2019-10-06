
%% Plot performance 
% clear all; close all
% save_fig=0;save_mat=0;
% ROI_test=0; sz_ROI=45;
% nb_imges=1; SNR_ROI_Equation=1;
%Diff_SNBD_formlat='Mean(Denoised Image)';
% load('./SCSA_2D1D_Evaluation/comp_all__sz_ROI_45_10.4.1_h_min_0.1_hmax_4.4_all.mat')
col=hsv(10);

tab_performance0=str2double(tab(3:end-1,:));
 tab_performance0(~any(isnan(tab_performance0),1),:)
tab_performance10=tab_performance0'
[Y,I]=sort(tab_performance10(1,:));
tab_performance1=tab_performance10(1:end,I)' %use the column indices from sort() to sort all columns of A.

tab3=tab_performance1;
clearvars tab_performance1 SI_1_vect0
tab_performance1=tab3;

nh=size(tab_performance1,1);

    for i=1:nh   
    SI_1_vect0(i)=tab_performance1(i,8);  
    end 
     SI_th_max=100*SI_0;
    Idnx0=min(find(SI_1_vect0<=SI_th_max))
    % 'first maxima(SI)'   
    GMx=diff(SI_1_vect0);
%     indx=min(find(GMx<0));
%     if indx> Idnx0
%       Idnx0=indx;  
%     end
%     SI_th_max=SI_1_vect0(Idnx0)+1;
%     Idnx2=max(find(SI_th_min<=SI_1_vect0))
        Idnx2=max(find(SI_th_min<=SI_1_vect0))


       tab_performance=tab_performance1(Idnx0:Idnx2,:);
%     tab_performance=tab_performance1(1:end-1,:);
    nh=size(tab_performance,1);
    
    for i=1:nh 
    h_vect(i)=tab_performance(i ,1);
    SNRB0_vect(i)=tab_performance(i,2);
    SNRD0_vect(i)=tab_performance(i,3);
    PSNR_vect(i)=tab_performance(i,4);
    SSIM_vect(i)=tab_performance(i,5);
    SNRB_vect(i)=tab_performance(i,6);
    SNRD_vect(i)=tab_performance(i,7);
    SI_1_vect(i)=tab_performance(i,8);  
    SNRB_vect_r(i)=tab_performance(i,9);
    SNRD_vect_r(i)=tab_performance(i,10)
    SI_0_vect(i)=tab_performance(i,11);    
    sz_ROI_vect=tab_performance(i,12);
%     Diff_SNBD_vect=tab_performance(i,13);
%     Diff_SNBD_vect_r=tab_performance(i,14);
     Diff_SNBD_vect_r_dh(i)= tab_performance(i,15);
     PSNR0_vect(i)=tab_performance(i,17);
    SSIM0_vect(i)=tab_performance(i,16);
%     BDR_vect(i)= tab_performance(i,18);
%     BDR_vect(i)= tab_performance(i,19);   
%     BDR_vect_dh(i)= tab_performance(i,20);
    MSE0_vect(i)= tab_performance(i,21);   
    MSE_vect(i)= tab_performance(i,22);
    PSNR_vect_r(i)=tab_performance(i,23);
    SSIM_vect_r(i)=tab_performance(i,24);
    SI_1_vect_r(i)=tab_performance(i,25);
    SNR_vect_r(i)=tab_performance(i,26)
    MSE_vect_r(i)=tab_performance(i,27)     
    end 
    filename
% h_vect(1)
% h_vect(end)

% hmin=h_vect(1);hmax=h_vect(2);
Diff_SNBD_vect=abs(SNRB_vect-SNRD_vect);
Diff_SNBD_vect_r=abs(SNRB_vect_r-SNRD_vect_r);  
BDR_vect= SNRB_vect./SNRD_vect;
BDR_vect_r= SNRB_vect_r./SNRD_vect_r;

 

%%  Metrics Variations
h_vect_dh=h_vect(1:end-1);h_vect_dh2=h_vect_dh(1:end-1);

SNRB_vect_dh= derive_sig(SNRB_vect , h_vect);
SNRD_vect_dh= derive_sig(SNRD_vect , h_vect);
Diff_SNBD_vect_dh= derive_sig(Diff_SNBD_vect , h_vect);
BDR_vect_dh= derive_sig(BDR_vect , h_vect);
SI_1_vect_dh= derive_sig(SI_1_vect , h_vect);
SSIM_vect_dh= derive_sig(SSIM_vect , h_vect);
PSNR_vect_dh= derive_sig(PSNR_vect , h_vect);
AccM_BDR_vect_dh=accumul_mean(BDR_vect_dh);


SNRB_vect_r_dh= derive_sig(SNRB_vect_r , h_vect);
SNRD_vect_r_dh= derive_sig(SNRD_vect_r , h_vect);
Diff_SNBD_vect_r_dh=derive_sig(Diff_SNBD_vect_r , h_vect);
BDR_vect_r_dh= derive_sig(BDR_vect_r , h_vect);
SI_1_vect_r_dh= derive_sig(SI_1_vect , h_vect);
SSIM_vect_r_dh= derive_sig(SSIM_vect , h_vect);
PSNR_vect_r_dh= derive_sig(PSNR_vect , h_vect);
AccM_BDR_vect_r_dh=accumul_mean(BDR_vect_r_dh);



%  %% Save matrics in h_criteria_th.mat
% if  nb_imges==1
%    h_criteria{1,1}='Image name';h_criteria{1,2}='ROI_sz' ;h_criteria{1,3}='Diff__SNBD_global_min[Res]';
%    h_criteria{1,4}=strcat('hmin( SI<',num2str(SI_th_max),')');  h_criteria{1,5}=strcat('hmax( SI >',num2str(SI_th_min),')');h_criteria{1,6}=strcat('Diff__SNBD[Nor]~SI[Nor] ± ',num2str(EQ_th));
%    h_criteria{1,7}=strcat('Diff__SNBD[Nor]~SSIM ± ',num2str(EQ_th));       h_criteria{1,8}='first maxima(d(Diff_SNBD[Res]))';h_criteria{1,9}='First min (d(SNRW))';
%    h_criteria{1,10}='First max(d(SNRW))';h_criteria{1,11}=strcat('d(SNRW[Res])>',num2str(SNRW_Res_th),')');
%    h_criteria{1,12}='h*M';      h_criteria{1,13}='h*H';
%    h_criteria{1,14}='optimal_h';  h_criteria{1,15}='optimal_h[Res]'; 
% end 
%     
% % Image_Name
% h_criteria{nb_imges+1,1}=filename;
% 
% % ROI_SZ
% h_criteria{nb_imges+1,2}=num2str(x_vars(5));
% 
% %'Diff__SNBD_global_min[Res]'
% Diff_SNBD_vect_r_GMn=h_vect(find(Diff_SNBD_vect_r==min(Diff_SNBD_vect_r(1:end-1))));
% h_criteria{nb_imges+1,3}=num2str(Diff_SNBD_vect_r_GMn);        
% 
% %'minh( SI<300 )'
% Idnx0=min(find(SI_1_vect<SI_th_max))   
% h_criteria{nb_imges+1,4}=num2str(h_vect(Idnx0));
% 
% %'minh( SI>90 )'
% Idnx2=max(find(SI_th_min<SI_1_vect))
% h_criteria{nb_imges+1,5}=num2str(h_vect(Idnx2));    
% 
% %Diff_SNBD[Nor]==SI[Nor]
% err_Diff_SNBD_nor_SI=abs(normalize(Diff_SNBD_vect)-normalize(SI_1_vect));
% intersec=min(err_Diff_SNBD_nor_SI);
% 
% if intersec<EQ_th;
%     EQ_Diff_SNBD_nor_SI=h_vect(min(find(err_Diff_SNBD_nor_SI==intersec)));
%     h_criteria{nb_imges+1,6}=num2str(EQ_Diff_SNBD_nor_SI);  
%     else
%      h_criteria{nb_imges+1,6}='NaN'   ;
% end
% 
% %Diff_SNBD[Nor]==SI[Nor]
% err_Diff_SNBD_nor_SI=abs(normalize(Diff_SNBD_vect)-normalize(SI_1_vect));
% intersec=min(err_Diff_SNBD_nor_SI);
% 
% if intersec<EQ_th;
%     EQ_Diff_SNBD_nor_SI=h_vect(min(find(err_Diff_SNBD_nor_SI==intersec)));
%     h_criteria{nb_imges+1,6}=num2str(EQ_Diff_SNBD_nor_SI);  
%     else
%      h_criteria{nb_imges+1,6}='NaN'   ;
% end
% 
% 
% %Diff_SNBD[Nor]=SSIM
% err_Diff_SNBD_nor_SSIM=abs(normalize(Diff_SNBD_vect)-SSIM_vect);
% intersec=min(err_Diff_SNBD_nor_SSIM);
% 
% if intersec<EQ_th
%     EQ_Diff_SNBD_nor_SSIM=h_vect(min(find(err_Diff_SNBD_nor_SSIM==intersec)));
%     h_criteria{nb_imges+1,7}=num2str(EQ_Diff_SNBD_nor_SSIM);  
%     else
%      h_criteria{nb_imges+1,7}='NaN';
% end
% 
% 
% % 'first maxima(d(Diff_SNBD[Res]))'     % Diff_SNBD_vect_r_dh
% GMx=diff(Diff_SNBD_vect_r_dh);
% indx=find(GMx<0);
% Diff_SNBD_vect_r_dh_GMx=h_vect(min(indx))
% h_criteria{nb_imges+1,8}=num2str(Diff_SNBD_vect_r_dh_GMx );
% 
% % 'First min (d(SNRW))'
% GMx=diff(SNRB_vect_dh);
% idx=find(GMx>0);
% h_d_SNRW_min=h_vect(idx(1))
% h_criteria{nb_imges+1,9}=num2str(h_d_SNRW_min );
% 
% % 'First max(d(SNRW))'
% GMx=diff(SNRB_vect_dh);
% 
% if (max(GMx)>0 &&  min(GMx)<0 )
%  idx_pos=find(GMx>0) 
%  idx_neg=find(GMx<0) 
%  idx=find(idx_neg>idx_pos(1));  
%  h_d_SNRW_max=h_vect(idx(end))
% elseif GMx>0
%     h_d_SNRW_max=h_vect(end);
% else    
%     h_d_SNRW_max=h_vect(1);
% end   
% 
%
% 
% h_criteria{nb_imges+1,10}=num2str(h_d_SNRW_max );
% 
% 
% % 'd(SNRW[Res])>-0.99'
% 
% indx=find(SNRB_vect_r_dh>SNRW_Res_th); 
% h_SNRW_Res_th=h_vect(indx(1)) 
% h_criteria{nb_imges+1,11}=num2str(h_SNRW_Res_th );
% 
% % optimal h as suggested Professor Meriem
% hop_M='...';
% h_criteria{nb_imges+1,12}=num2str(hop_M);
% 
% % optimal h as suggested Professor Hacene
% hop_H='...';
% h_criteria{nb_imges+1,13}=num2str(hop_H);

% optimal h as suggested by criteria

if sim_data==1
    indx_opt=find(PSNR_vect==max(PSNR_vect));
    if max(size(indx_opt))>=2
    h_visual1=h_vect(min(indx_opt)) ;
     h_visual2=h_vect(max(indx_opt));
    
    else
        h_visual1=h_vect(indx_opt);
    end
    
else
    h_visual1=h_visual;indx_opt=1;
end





%% #### plot the chosen metric March 2017

%% Denoised image ROI

 h_op_Diff_SNBDR= h_vect(find(Diff_SNBD_vect==min(Diff_SNBD_vect)))
 h_op_SNRB=h_vect(find(SNRB_vect==min(SNRB_vect)))  
 h_op_SNRD=h_vect(find(SNRD_vect==min(SNRD_vect)))  
 h_op_Diff_BDR=h_vect(find(BDR_vect==max(BDR_vect)))  
 Diff_SNBD_min=h_vect(find(Diff_SNBD_vect==min(Diff_SNBD_vect)))  
  h_criteria{nb_imges+1,14}=num2str(Diff_SNBD_min);
  
figure(6);set(figure(6),'units','normalized','outerposition',[0 0 1 1])  

      if sim_data==1 &&  show_PSNR==1
     plot(h_vect,(PSNR_vect),'LineWidth',1.5)
     hold on 
     plot(h_vect,MSE_vect,'y','LineWidth',1.5)
     hold on
     end
    plot(h_vect,(SI_1_vect),'m','LineWidth',1.5)
     hold on
    plot(h_vect,(SNRB_vect),'b','LineWidth',1.5)
     hold on
    plot(h_vect,(SNRD_vect),'k','LineWidth',1.5)
         hold on
    plot(h_vect,(BDR_vect),'c','LineWidth',1.5)
    hold on
     plot(h_vect,(Diff_SNBD_vect),'r','LineWidth',1.5)
     if sim_data==1  
       hold on
      vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
      end    
    
     hold on
     vline(h_op_SNRB,'b',strcat('  h^*=',num2str(h_op_SNRB)))
     hold on
     vline(h_op_SNRD,'k',strcat(' h^*=',num2str(h_op_SNRD)))
      hold on
      vline(h_op_Diff_BDR,'c',strcat('   h^*=',num2str(h_op_Diff_BDR)))
     hold on
     vline(Diff_SNBD_min,'r',strcat('    h^*=',num2str(Diff_SNBD_min)))
    hold off
      if sim_data==1 &&  show_PSNR==1
     lgdd=legend('PSNR','MSE','Shapness','SNRB_{ROI}','SNRD_{ROI}','SNRBDRR_{ROI}=SNRB_{ROI} / SNRD_{ROI}','Diff__SNBD');%'Location','northwest')
     else
      lgdd=legend('Shapness','SNRB_{ROI}','SNRD_{ROI}','SNRBDRR_{ROI}=SNRB_{ROI} / SNRD_{ROI}','Diff__SNBD');%'Location','northwest')
     end
     set(lgdd,'FontSize',10);  
       lgdd2=title('  Metrics Evolution of the denoised image ')
     set(lgdd2,'FontSize',10);
     grid on
     xlabel('h values')
   
 %% Normalization 
figure(7);set(figure(7),'units','normalized','outerposition',[0 0 1 1])  
      if sim_data==1 &&  show_PSNR==1
     plot(h_vect,normalize(PSNR_vect),'LineWidth',1.5)
     hold on 
     plot(h_vect,normalize(MSE_vect),'y','LineWidth',1.5)
     hold on
     end
    plot(h_vect,normalize(SI_1_vect),'m','LineWidth',1.5)
     hold on
    plot(h_vect,normalize(SNRB_vect),'b','LineWidth',1.5)
     hold on
    plot(h_vect,normalize(SNRD_vect),'k','LineWidth',1.5)
         hold on
    plot(h_vect,normalize(BDR_vect),'c','LineWidth',1.5)
    hold on
    plot(h_vect,normalize(Diff_SNBD_vect),'r','LineWidth',1.5)          
       if sim_data==1  
       hold on
      vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
      end     
     
     hold on
     vline(h_op_SNRB,'b',strcat('  h^*=',num2str(h_op_SNRB)))
     hold on
     vline(h_op_SNRD,'k',strcat(' h^*=',num2str(h_op_SNRD)))
      hold on
      vline(h_op_Diff_BDR,'c',strcat('   h^*=',num2str(h_op_Diff_BDR)))
     hold on
     vline(Diff_SNBD_min,'r',strcat('    h^*=',num2str(Diff_SNBD_min)))
     
    hold off
      if sim_data==1 &&  show_PSNR==1
     lgdd=legend('PSNR','MSE','Shapness','SNRB_{ROI}','SNRD_{ROI}','SNRBDRR_{ROI}=SNRB_{ROI} / SNRD_{ROI}','Diff__SNBD');%'Location','northwest')
     else
      lgdd=legend('Shapness','SNRB_{ROI}','SNRD_{ROI}','SNRBDRR_{ROI}=SNRB_{ROI} / SNRD_{ROI}','Diff__SNBD');%'Location','northwest')
     end
     set(lgdd,'FontSize',10);  
       lgdd2=title('  Metrics Evolution of the denoised image [Normalized] ')
     set(lgdd2,'FontSize',10);
     grid on
     xlabel('h values')
   
    
 %% Variation Denosied image 
 
 h_op_Diff_SNBDR_dh=h_vect_dh(find(Diff_SNBD_vect_dh==min(Diff_SNBD_vect_dh)))
 h_op_SNRBR_dh=h_vect_dh(find(SNRB_vect_dh==min(SNRB_vect_dh)))  
 h_op_SNRDR_dh=h_vect_dh(find(SNRD_vect_dh==max(SNRD_vect_dh)))  
 h_op_BDR_dh=h_vect_dh(find(BDR_vect_dh==max(BDR_vect_dh)))  
 Diff_SNBDR_min_dh=h_vect_dh(find(Diff_SNBD_vect_dh==max(Diff_SNBD_vect_dh)))  
  h_criteria{nb_imges+1,15}=num2str(Diff_SNBDR_min_dh);
  
  figure(8);set(figure(8),'units','normalized','outerposition',[0 0 1 1])  
    plot(h_vect_dh,(SI_1_vect_dh),'m','LineWidth',1.5)
     hold on
    plot(h_vect_dh,(SNRB_vect_dh),'b','LineWidth',1.5)
     hold on
    plot(h_vect_dh,(SNRD_vect_dh),'k','LineWidth',1.5)
     hold on
    plot(h_vect_dh,(BDR_vect_dh),'c','LineWidth',1.5)
    hold on
    plot(h_vect_dh,(Diff_SNBD_vect_dh),'r','LineWidth',1.5)
    
%     hold on
%     
%     if show_PSNR==1  
%              if sim_data==1
%               vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
%             else
%              vline(h_visual1,'g',strcat('h_{visual}=',num2str(h_visual1)))
%              end
%         else
%              hold on
%              vline(h_visual1,'g',strcat('to h^*=',num2str(h_visual1)))
%     end
%     
%           if max(size(indx_opt))>=2
%                hold on
%            vline(h_visual2,'g',strcat('to h^*=',num2str(h_visual2)))
%           end

      if sim_data==1  
       hold on
      vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
      end
      
     hold on
     vline(h_op_SNRDR_dh,'k',strcat(' h^*=',num2str(h_op_SNRDR_dh)))
      hold on
     vline(h_op_SNRBR_dh,'b',strcat('  h^*=',num2str(h_op_SNRBR_dh)))
     hold on
     vline(h_op_BDR_dh,'c',strcat('   h^*=',num2str(h_op_BDR_dh)))
     hold on
     vline(Diff_SNBDR_min_dh,'r',strcat('    h^*=',num2str(Diff_SNBDR_min_dh))) 
    hold off
     lgdd=legend('Shapness','SNRB_{ROI}','SNRD_{ROI}','SNRBDRR_{ROI}=SNRB_{ROI} / SNRD_{ROI}','Diff__SNBD');%'Location','northwest')
     set(lgdd,'FontSize',10);  
       lgdd2=title('  Metrics Variation of the denoised image ')
     set(lgdd2,'FontSize',10);
     grid on
     xlabel('h values')    
           
  %% Normalized
  
 figure(9);set(figure(9),'units','normalized','outerposition',[0 0 1 1])  
    plot(h_vect_dh,normalize(SI_1_vect_dh),'m','LineWidth',1.5)
     hold on
    plot(h_vect_dh,normalize(SNRB_vect_dh),'b','LineWidth',1.5)
     hold on
    plot(h_vect_dh,normalize(SNRD_vect_dh),'k','LineWidth',1.5)
     hold on
    plot(h_vect_dh,normalize(BDR_vect_dh),'c','LineWidth',1.5)
    hold on
    plot(h_vect_dh,normalize(Diff_SNBD_vect_dh),'r','LineWidth',1.5)   
%     hold on
%     
%     if show_PSNR==1
%      if sim_data==1
%       vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
%     else
%      vline(h_visual1,'g',strcat('h_{visual}=',num2str(h_visual1)))
%      end          
%     else
%              hold on
%              vline(h_visual1,'g',strcat('to h^*=',num2str(h_visual1)))
%     end
%     
%       if max(size(indx_opt))>=2
%            hold on
%        vline(h_visual2,'g',strcat('to h^*=',num2str(h_visual2)))
%       end
 
      if sim_data==1  
       hold on
      vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
      end
      
      hold on
     vline(h_op_SNRDR_dh,'k',strcat(' h^*=',num2str(h_op_SNRDR_dh)))
      hold on
     vline(h_op_SNRBR_dh,'b',strcat('  h^*=',num2str(h_op_SNRBR_dh)))
     hold on
     vline(h_op_BDR_dh,'c',strcat('   h^*=',num2str(h_op_BDR_dh)))
     hold on
     vline(Diff_SNBDR_min_dh,'r',strcat('    h^*=',num2str(Diff_SNBDR_min_dh))) 
    hold off
     lgdd=legend('Shapness','SNRB_{ROI}','SNRD_{ROI}','SNRBDRR_{ROI}=SNRB_{ROI} / SNRD_{ROI}','Diff__SNBD');%'Location','northwest')
     set(lgdd,'FontSize',10);  
       lgdd2=title('  Metrics Variation of the denoised image [Normalized]')
     set(lgdd2,'FontSize',10);
     grid on
     xlabel('h values')   
     
     
%% Residual 
 h_op_Diff_SNBDR_r=h_vect(find(Diff_SNBD_vect_r==min(Diff_SNBD_vect_r)))
 h_op_SNRB_r=h_vect(find(SNRB_vect_r==min(SNRB_vect_r)))  
 h_op_SNRD_r=h_vect(find(SNRD_vect_r==min(SNRD_vect_r)))  
 h_op_Diff_BDR_r=h_vect(find(BDR_vect_r==min(BDR_vect_r)))  
 Diff_SNBD_min_r=h_vect(find(Diff_SNBD_vect_r==min(Diff_SNBD_vect_r)))  
  h_criteria{nb_imges+1,16}=num2str(Diff_SNBD_min_r);
  
figure(11);set(figure(11),'units','normalized','outerposition',[0 0 1 1])  

      if sim_data==1 &&  show_PSNR==1
     plot(h_vect,(PSNR_vect_r),'LineWidth',1.5)
     hold on 
     plot(h_vect,MSE_vect_r,'y','LineWidth',1.5)
     hold on
     end
    plot(h_vect,(SI_1_vect_r),'m','LineWidth',1.5)
     hold on
    plot(h_vect,(SNRB_vect_r),'b','LineWidth',1.5)
     hold on
    plot(h_vect,(SNRD_vect_r),'k','LineWidth',1.5)
         hold on
    plot(h_vect,(BDR_vect_r),'c','LineWidth',1.5)
    hold on
    plot(h_vect,(Diff_SNBD_vect_r),'r','LineWidth',1.5)

%     hold on
%       if show_PSNR==1
%           if sim_data==1
%           vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
%         else
%          vline(h_visual1,'g',strcat('h_{visual}=',num2str(h_visual1)))
%           end
%     else
%              hold on
%              vline(h_visual1,'g',strcat('to h^*=',num2str(h_visual1)))
% 
%       end
% 
%       if max(size(indx_opt))>=2
%            hold on
%        vline(h_visual2,'g',strcat('to h^*=',num2str(h_visual2)))
%       end
%      hold on
%   

      if sim_data==1  
       hold on
      vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
      end
          
     vline(h_op_SNRB_r,'b',strcat('  h^*=',num2str(h_op_SNRB_r)))
     hold on
     vline(h_op_SNRD_r,'k',strcat(' h^*=',num2str(h_op_SNRD_r)))
      hold on
      vline(h_op_Diff_BDR_r,'c',strcat('   h^*=',num2str(h_op_Diff_BDR_r)))
     hold on
     vline(Diff_SNBD_min_r,'r',strcat('    h^*=',num2str(Diff_SNBD_min_r)))
     
    hold off
      if sim_data==1 &&  show_PSNR==1
     lgdd=legend('PSNR','MSE','Shapness','SNRBR_{ROI}','SNRDR_{ROI}','SNRBR_{ROI}  / SNRDR_{ROI}','Diff__SNBD');%'Location','northwest')
     else
      lgdd=legend('Shapness','SNRBR_{ROI}','SNRDR_{ROI}','SNRBR_{ROI}  / SNRDR_{ROI}','Diff__SNBD');%'Location','northwest')
     end
     set(lgdd,'FontSize',10);  
       lgdd2=title('  Metrics Evolution of the residual image ')
     set(lgdd2,'FontSize',10);
     grid on
     xlabel('h values')
   
  %% Normalization 
figure(12);set(figure(12),'units','normalized','outerposition',[0 0 1 1])  
      if sim_data==1 &&  show_PSNR==1
     plot(h_vect,normalize(PSNR_vect_r),'LineWidth',1.5)
     hold on 
     plot(h_vect,normalize(100*MSE_vect_r),'y','LineWidth',1.5)
     hold on
     end
    plot(h_vect,normalize(SI_1_vect_r),'m','LineWidth',1.5)
     hold on
    plot(h_vect,normalize(SNRB_vect_r),'b','LineWidth',1.5)
     hold on
    plot(h_vect,normalize(SNRD_vect_r),'k','LineWidth',1.5)
         hold on
    plot(h_vect,normalize(BDR_vect_r),'c','LineWidth',1.5)
    hold on
    plot(h_vect,normalize(Diff_SNBD_vect_r),'r','LineWidth',1.5)

%     hold on
%        if show_PSNR==1
%          if sim_data==1
%           vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
%         else
%          vline(h_visual1,'g',strcat('h_{visual}=',num2str(h_visual1)))
%          end
%     else
%              hold on
%              vline(h_visual1,'g',strcat('to h^*=',num2str(h_visual1)))
%        end
%     
%       if max(size(indx_opt))>=2
%            hold on
%        vline(h_visual2,'g',strcat('to h^*=',num2str(h_visual2)))
%       end
 if sim_data==1  
       hold on
      vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
 end
      
      
     hold on
  
     vline(h_op_SNRB_r,'b',strcat('  h^*=',num2str(h_op_SNRB_r)))
     hold on
     vline(h_op_SNRD_r,'k',strcat(' h^*=',num2str(h_op_SNRD_r)))
      hold on
      vline(h_op_Diff_BDR_r,'c',strcat('   h^*=',num2str(h_op_Diff_BDR_r)))
     hold on
     vline(Diff_SNBD_min_r,'r',strcat('    h^*=',num2str(Diff_SNBD_min_r)))
     
    hold off
      if sim_data==1 &&  show_PSNR==1
     lgdd=legend('PSNR','MSE','Shapness','SNRBR_{ROI}','SNRDR_{ROI}','SNRBR_{ROI}  / SNRDR_{ROI}','Diff__SNBD');%'Location','northwest')
     else
      lgdd=legend('Shapness','SNRBR_{ROI}','SNRDR_{ROI}','SNRBR_{ROI}  / SNRDR_{ROI}','Diff__SNBD');%'Location','northwest')
     end
     set(lgdd,'FontSize',10);  
       lgdd2=title('  Metrics Evolution of the residual image [Normalized]')
     set(lgdd2,'FontSize',10);
     grid on
     xlabel('h values')
   
    
  %% Variation Residual image 
 h_op_Diff_SNBDR_r_dh=h_vect_dh(find(Diff_SNBD_vect_r_dh==min(Diff_SNBD_vect_r_dh)))
 h_op_SNRBR_r_dh=h_vect_dh(find(SNRB_vect_r_dh==max(SNRB_vect_r_dh)))  
 h_op_SNRDR_r_dh=h_vect_dh(find(SNRD_vect_r_dh==min(SNRD_vect_r_dh)))  
 h_op_BDR_r_dh=h_vect_dh(find(BDR_vect_r_dh==max(BDR_vect_r_dh)))  
 Diff_SNBDR_min_r_dh=h_vect_dh(find(Diff_SNBD_vect_r_dh==min(Diff_SNBD_vect_r_dh)))  
  h_criteria{nb_imges+1,17}=num2str(Diff_SNBDR_min_r_dh);

 figure(13);set(figure(13),'units','normalized','outerposition',[0 0 1 1])  
    plot(h_vect_dh,normalize(SI_1_vect_r_dh),'m','LineWidth',1.5)
     hold on
    plot(h_vect_dh,normalize(SNRB_vect_r_dh),'b','LineWidth',1.5)
     hold on
    plot(h_vect_dh,normalize(SNRD_vect_r_dh),'k','LineWidth',1.5)
     hold on
    plot(h_vect_dh,normalize(BDR_vect_r_dh),'c','LineWidth',1.5)
    hold on
    plot(h_vect_dh,normalize(Diff_SNBD_vect_r_dh),'r','LineWidth',1.5)
    
%     hold on
%     if show_PSNR==1
%      if sim_data==1
%       vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
%     else
%      vline(h_visual1,'g',strcat('h_{visual}=',num2str(h_visual1)))
%      end           
%     else
%              hold on
%              vline(h_visual1,'g',strcat('to h^*=',num2str(h_visual1)))
%     end
%     
%       if max(size(indx_opt))>=2
%            hold on
%        vline(h_visual2,'g',strcat('to h^*=',num2str(h_visual2)))
%       end
 
      if sim_data==1  
       hold on
      vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
      end
      
     hold on
     vline(h_op_SNRDR_r_dh,'k',strcat(' h^*=',num2str(h_op_SNRDR_r_dh)))
      hold on
     vline(h_op_SNRBR_r_dh,'b',strcat('  h^*=',num2str(h_op_SNRBR_r_dh)))
     hold on
     vline(h_op_BDR_r_dh,'c',strcat('   h^*=',num2str(h_op_BDR_r_dh)))
     hold on
     vline(Diff_SNBDR_min_r_dh,'r',strcat('    h^*=',num2str(Diff_SNBDR_min_r_dh))) 
    hold off
     lgdd=legend('Shapness','SNRBR_{ROI}','SNRDR_{ROI}','SNRBR_{ROI}  / SNRDR_{ROI}','Diff__SNBD');%'Location','northwest')
     set(lgdd,'FontSize',10);  
       lgdd2=title('  Metrics Variation of the residual image [Normalized] ')
     set(lgdd2,'FontSize',10);
     grid on
     xlabel('h values')   
     
     
figure(14);set(figure(14),'units','normalized','outerposition',[0 0 1 1])  
    plot(h_vect_dh,(SI_1_vect_r_dh),'m','LineWidth',1.5)
     hold on
    plot(h_vect_dh,(SNRB_vect_r_dh),'b','LineWidth',1.5)
     hold on
    plot(h_vect_dh,(SNRD_vect_r_dh),'k','LineWidth',1.5)
     hold on
    plot(h_vect_dh,(BDR_vect_r_dh),'c','LineWidth',1.5)
    hold on
    plot(h_vect_dh,(Diff_SNBD_vect_r_dh),'r','LineWidth',1.5)
    
%     hold on
%       if show_PSNR==1
%          if sim_data==1
%           vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
%         else
%          vline(h_visual1,'g',strcat('h_{visual}=',num2str(h_visual1)))
%          end
%     else
%              hold on
%              vline(h_visual1,'g',strcat('to h^*=',num2str(h_visual1)))
%       end
%     
%       if max(size(indx_opt))>=2
%            hold on
%        vline(h_visual2,'g',strcat('to h^*=',num2str(h_visual2)))
%       end
%       
      if sim_data==1  
       hold on
      vline(h_visual1,'g',strcat('h_{op}=',num2str(h_visual1)))
      end
      
     hold on
     vline(h_op_SNRDR_r_dh,'k',strcat(' h^*=',num2str(h_op_SNRDR_r_dh)))
      hold on
     vline(h_op_SNRBR_r_dh,'b',strcat('  h^*=',num2str(h_op_SNRBR_r_dh)))
     hold on
     vline(h_op_BDR_r_dh,'c',strcat('   h^*=',num2str(h_op_BDR_r_dh)))
     hold on
     vline(Diff_SNBDR_min_r_dh,'r',strcat('    h^*=',num2str(Diff_SNBDR_min_r_dh))) 
    hold off
     lgdd=legend('Shapness','SNRBR_{ROI}','SNRDR_{ROI}','SNRBR_{ROI}  / SNRDR_{ROI}','Diff__SNBD');%'Location','northwest')
     set(lgdd,'FontSize',10);  
       lgdd2=title('  Metrics Variation of the residual image ')
     set(lgdd2,'FontSize',10);
     grid on
     xlabel('h values')          
     
     
clearvars tab_performance
