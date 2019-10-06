%%
    %**********************************************************************
    %           Gaussin distributio to  the h-paramter                    *
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

function H=Gaussian_h(nb_Ns,h_center,h_bord)
%% to test 
% h_center=2
% h_bord=0.9
% N=8
%%
N_min=1;
mu = [0 0]; 
SIGMA = [1 0; 0 1];
if mod(nb_Ns,2)==0
   nb=floor(nb_Ns/2); n0=0;
else
   nb=floor(nb_Ns/2)+1; n0=1;
end

x1 = linspace( 0,N_min,nb); 
x2= x1;
[X1,X2] = meshgrid(x1,x2);
H = mvnpdf([X1(:) X2(:)],mu,SIGMA);
H = reshape(H,length(x2),length(x1));
H=H-min(min(H));
H22=H*(h_center-h_bord)/max(max(H))+h_bord;
H21=fliplr(H22);
H2=[H21(:,1:end-n0) H22];
H1=flipud(H2);
H=[H1(1:end-n0,:);H2];
% figure(100)
% contourf(H)
% colorbar('eastoutside')

% x = linspace( -N_min,N_min,nb_Ns); 
% y=x;
% [C] = contour(x,y,H);
% clabel(C)
% title('Gaussian distributed h adaptive values ')
% xlabel('J'); ylabel('I'); zlabel('h-parameter value');


end