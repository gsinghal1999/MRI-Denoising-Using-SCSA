%% 
close all;
%% Add folder 
addpath ../../
%
% Set the bounds, budget, and initial iterate.
bounds=[0, 1000];
budget=1000;
x0=[0.5]';
%
% Call imfil.
%
delete('hist_iter.mat')
step_hist=[0 0];
save('hist_iter.mat','step_hist');
[x,histout]=imfil(x0,'f_easy',budget,bounds);


%%  plot optimal SCSA     
scsa_budy

%% Results Evaluation
figure(1);subplot(211);
plot(y,'color','g','LineWidth',3);hold on;
plot(y_noisy,'color','b','LineWidth',1.5);hold on;
plot(yscsa,'color','r','LineWidth',2);hold on;legend('Original signal',strcat('Noisy signal with sigma =',num2str(sigma)),'Denoised signal','Denoised Eig')
title(strcat('Recontructed signal with h=',num2str(h)))
xlabel(strcat(' N=',num2str(N),'  with Nh=',num2str(Nh),'  Eigenvalues , PSNR= ',num2str(PSNR) ))


%% 3D implementation 
%%  plot optimization trajectrory 

load('hist_iter.mat');
X=step_hist(2:end,1)
Y=step_hist(2:end,2)

% [X Y]=meshgrid(,step_hist(2:end,1));
Z =1:max(size(step_hist(2:end,1)));
% Z=meshgrid(Z0,Z0);

figure(1);subplot(212);
plot3(X, Z, Y)
view([90 0])
xlabel('iteratoin')
ylabel('h')
zlabel('error')
title( strcat('Optimization trjectroy to  h^* =',num2str(x)));
%% END