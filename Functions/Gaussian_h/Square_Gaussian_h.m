%%
    %**********************************************************************
    %         Square Gaussin distributio to  the h-paramter               *
    %**********************************************************************

 % Modified by:  Abderrazak Chahid  
 % aberrazak.chahid@gmail.com
 % Original Author : Professor Taous_Meriem Laleg . EMAN Group KAUST 
 % taousmeriem.laleg@kaust.edu.sa 
 
 %% Description
 % Functtion return a gaussian distribtion matrix o h in [h_in,h_center 
 
 % Done: Oct,  2016
 
%% input parapeters
% nb_Ns     :  Matrix dimension 
% h_center : maximum value of h-parameter
% h_bord : minimum value of h-parameter
%% output  parapeters
% H : h-parameter gaussian distribution
% function H=Gaussian_h(nb_Ns,h_center,h_bord)
% %% to test 
% % h_center=2
% % h_bord=0.9
% % N=8
% %%
% N_min=1
% mu = [-1/nb_Ns -1/nb_Ns]; 
% SIGMA = [1 0; 0 1];
% x1 = linspace( -N_min,N_min,nb_Ns); 
% x2= x1;
% [X1,X2] = meshgrid(x1,x2);
% H = mvnpdf([X1(:) X2(:)],mu,SIGMA);
% H = reshape(H,length(x2),length(x1));
% H=H-min(min(H));
% H=H*(h_center-h_bord)/max(max(H))+h_bord
% 
% end

function H=Square_Gaussian_h(nb_Ns,h_center,h_bord)
%% to test 
% clear all
% h_center=2.45
% h_bord=0.5
% nb_Ns=8
%%
mu = 0; 
SIGMA = 1;
if mod(nb_Ns,2)==0
   nb=floor(nb_Ns/2); n0=0;
else
   nb=floor(nb_Ns/2)+1; n0=1;
end

x = linspace( 0,1,nb); 
h = normpdf(x,mu,SIGMA);
h=h-min(min(h));
h=h*(h_center-h_bord)/max(max(h))+h_bord

H22=zeros(nb);

for i=1:nb
   H22(i,1:nb-i+1)=h(nb-i+1);
   H22(i:end, nb-i+1)=h(nb-i+1);
end

H21=fliplr(H22);
H2=[H21(:,1:end-n0) H22];
H1=flipud(H2);
H=[H2;H1(1:end-n0,:)]
% figure(100)
% subplot(121);contourf(H);
% title('Square Gaussian distributed h-paramter')
% colorbar('eastoutside')
% 
% x = linspace( -1,1,nb_Ns); 
% y=x;
% subplot(122);[C] = contour(x,y,H);
% clabel(C)
% title('h-parameter value');


end