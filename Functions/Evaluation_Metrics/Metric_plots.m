%%
    %**********************************************************************
    %           Plot denoising metrics   for ISBI without PCBh             *
    %**********************************************************************

 % Modified by:  Abderrazak Chahid  
 % aberrazak.chahid@gmail.com
 % Original Author : Professor Taous_Meriem Laleg . EMAN Group KAUST 
 % taousmeriem.laleg@kaust.edu.sa 
 
 %% Description
 % Script plots the prformance of  the SCSA algorithm  on 2D image of size n
 % as PSNR, SSIM and Sharpness
 
 % Done: Oct,  2016
 
%% input parapeters
% scsa_type : type of SCSA = [SCSA2D1D], [SCSA2D2D]
% figr : figure number
% filename0 : image name
% Ns : Namber of sub image per row/column
% Np : dimension of Padding
% path_save_results
% save_fig:  save figure if =1
% seg_type : 1=>PUh  ,   2=>PPCBh  ,


function Metric_plots(seg_list,Ns,Np,scsa_type,seg_sz,figr,filename0,tab,path_save_results,save_fig,init_perf,real_data)

tab_performance00=str2double(tab(2:end,:));
Ns_list=unique(tab_performance00(:,1))
flag_loop=0;

%% plot all in oe 
lgnd_seg{1}='SCSA Fixed-h ';
flag_lgnd=1; 
                            
col=hsv(size(Ns_list,1)+2);
  fig_now=figr+1;
figure(fig_now);
    
for Ns_i=1:max(size(Ns_list))
    flag_loop=flag_loop+1;
    Lst_Ns=find(tab_performance00(:,1)==Ns_list(Ns_i));
    
    tab_performance0=tab_performance00(Lst_Ns,:);
    tab_performance10=tab_performance0';
    [Y,I]=sort(tab_performance10(4,:));
    tab_performance1=tab_performance10(1:end,I)'; %use the column indices from sort() to sort all columns of A.

    tab3=tab_performance1;
    clearvars tab_performance1
    tab_performance1=tab3;

    %% variables extraction

    h_bord_vect=num2str(tab_performance1(:,3));
    h_center_vect=num2str(tab_performance1(:,4));

    % tab{1,5}='SI00';tab{1,6}='SI_0';tab{1,7}='SI_1' ;tab{1,8}='SI_2';tab{1,9}='SI_3';tab{1,10}='SI_4';
    % tab{1,11}='SSIM0';tab{1,12}='SSIM1';tab{1,13}='SSIM2';tab{1,14}='SSIM3';tab{1,15}='SSIM4';
    % tab{1,16}='PSNR0';  tab{1,17}='PSNR1';tab{1,18}='PSNR2'; tab{1,19}='PSNR3';tab{1,20}='PSNR4';

    % SI00_vect=tab_performance1(:,5);

    % SI_0_vect=tab_performance1(:,6);
    % SI_1_vect=tab_performance1(:,7);
    % SI_2_vect=tab_performance1(:,8);
    % SI_3_vect=tab_performance1(:,9);
    % SI_4_vect=tab_performance1(:,10);

    SI_vect=tab_performance1(:,6:6+seg_sz);

    % 
    % SSIM0_vect=tab_performance1(:,11);
    % SSIM1_vect=tab_performance1(:,12);
    % SSIM2_vect=tab_performance1(:,13);
    % SSIM3_vect=tab_performance1(:,14);
    % SSIM4_vect=tab_performance1(:,15);

    SSIM_vect=tab_performance1(:,7+seg_sz:7+2*seg_sz);
    % 
    % PSNR0_vect=tab_performance1(:,16);  
    % PSNR1_vect=tab_performance1(:,17);
    % PSNR2_vect=tab_performance1(:,18); 
    % PSNR3_vect=tab_performance1(:,19);
    % PSNR4_vect=tab_performance1(:,20);

    PSNR_vect=tab_performance1(:,8+2*seg_sz:8+3*seg_sz);

    SNR_cnt_vect=tab_performance1(:,9+3*seg_sz:9+4*seg_sz);

    SNR_crn_vect=tab_performance1(:,10+4*seg_sz:10+5*seg_sz);


    M=size(PSNR_vect,1);

    % h0=1:sqrt(M):M;
    x=(1:M-1)';
    h_vect=strcat('h=[',h_bord_vect,'-',h_center_vect,']');
    h_vect00=tab_performance1(:,4);
    h_vect0=(h_vect00(x));

    SI00_vect=init_perf(1)*ones(size(x));
%% plot 

  %% Build legend
lgnd_method={strcat('SCSA-PUh with Ns=',num2str(Ns_list(Ns_i))),strcat('SCSA-PSGHh with Ns=',num2str(Ns_list(Ns_i))),strcat('SCSA-PSGh with Ns=',num2str(Ns_list(Ns_i)))};

for seg_i=seg_list
    flag_lgnd=flag_lgnd+1;
    lgnd_seg{flag_lgnd}=lgnd_method{seg_i};
end


    subplot(3-real_data,1,1);
    if Ns_i==1
        plot(x,SI_vect(1:M-1,1),'--','LineWidth',2);hold on
    end
        for j=2:seg_sz+1
         plot(x,SI_vect(1:M-1,j),'LineWidth',2);hold on
        end
        
        lgdd=legend(lgnd_seg,'Location','eastoutside')
        set(lgdd,'FontSize',12);
        title('Sharpness')
        grid on;
        %xlim([1 11])
        
    subplot(3-real_data,1,2); 
        if Ns_i==1
        plot(x,SSIM_vect(1:M-1,1),'--','LineWidth',2);hold on
        
                if real_data==1
                        set(gca,'XLim',[1 M-1],'XTick',1:M-1,'XTickLabel',h_vect)
                        set(gca, 'XTickLabelRotation', 45)
                end
        end
        for j=2:seg_sz+1
            plot(x,SSIM_vect(1:M-1,j),'LineWidth',2);hold on
        end
        lgdd=legend(lgnd_seg,'Location','eastoutside')
        set(lgdd,'FontSize',12);   
        title('SSIM')
        grid on;
        %xlim([1 11])


if real_data==0
     subplot(3-real_data,1,3);
         if Ns_i==1
            plot(x,PSNR_vect(1:M-1,1),'--','LineWidth',2);hold on
            set(gca,'XLim',[1 M-1],'XTick',1:M-1,'XTickLabel',h_vect)
            set(gca, 'XTickLabelRotation', 45)
         end
        for j=2:seg_sz+1
            plot(x,PSNR_vect(1:M-1,j),'LineWidth',2);hold on
        end
    lgdd=legend(lgnd_seg,'Location','eastoutside')
    set(lgdd,'FontSize',12);
    title('PSNR') ; 
    grid on;
    %xlim([1 11])
%     ylabel(strcat(' Ns =',num2str(Ns),', Np =',num2str(Np)))

         
end
end
lgnd_seg{flag_lgnd+1}='Noisy image';
subplot(3-real_data,1,1);plot(x,SI00_vect,'k','LineWidth',2);
lgdd=legend(lgnd_seg,'Location','eastoutside')
set(lgdd,'FontSize',12); 
hold off
subplot(3-real_data,1,2)
lgdd=legend(lgnd_seg,'Location','eastoutside')
set(lgdd,'FontSize',12); 
hold off
if real_data==0
subplot(3-real_data,1,3)
lgdd=legend(lgnd_seg,'Location','eastoutside')
set(lgdd,'FontSize',12); 
hold off
end  
%% save figures
    
if save_fig==1
    set(figure(fig_now),'units','normalized','outerposition',[0 0 1 1])
    set(figure(fig_now),'PaperOrientation','landscape');
    set(figure(fig_now),'PaperUnits','normalized');
    set(figure(fig_now),'PaperPosition', [0 0 1 1]);
    print(figure(fig_now), '-dpdf',strcat(path_save_results,'Mtr_Ns__',num2str(Ns),'_Np__',num2str(Np),'all.pdf'))
    saveas(figure(fig_now),strcat(path_save_results,'Mtr_Ns__',num2str(Ns),'_Np__',num2str(Np),'all.fig'))         
end


end