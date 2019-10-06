%%
    %**********************************************************************
    %           SCSA2D1D PGSh : Gaussian distributed h                    *
    %**********************************************************************

 % Modified by:  Abderrazak Chahid  
 % aberrazak.chahid@gmail.com
 % Original Author : Professor Taous_Meriem Laleg . EMAN Group KAUST 
 % taousmeriem.laleg@kaust.edu.sa 
 
 %% Description
 % Functtion return a gaussian distribtion matrix o h in [h_in,h_center 
 
 % Done: Feb,  2017
 
%% input parapeters
% Ns     :  Number of susbimage by cocl/row
% h_center : maximum value of h-parameter
% h_bord : minimum value of h-parameter
% img : input image
% fs: sampling frequency


%% output  parapeters
% denoised_img : Output image
function [h, denoised_img, Nh_seg]=SCSA2D1D_PSGh(img, h_bord, h_center, fs, gm, Ns,Np)  
%%  # Generate the Distributed-h values  
% Generate h-distribution
% clear all;
%  load('data_test.mat')

Ns=64;  Np=12; 
h_matrix=Gaussian_h(Ns,h_center,h_bord);   
Nh_seg=0;
% img=rand([8 8]);
sz_img=size(img);
% Ns=2^(floor(log(Ns)/log(2))+(rem(log(Ns)/log(2),1)~=0)*1 )+1
% Np=2^(floor(log(Np)/log(2))+(rem(log(Np)/log(2),1)~=0)*1 ) 

%% Scale the image 
Nb_Ns=(mod(max(sz_img),Ns)>0)*1+ floor(max(sz_img(1))/Ns);
sz_img =Nb_Ns*Ns ;

% Np=(floor(Np/2)>0)*1+ floor(Np/2)
% Np=2.^(floor(log(Np)./log(2))+(rem(log(Np)./log(2),1)~=0)*1 ) 


%% # Rescale noisy image dor segmantation: 128, 256, 512, ... 

img = im2single(imresize(img,[sz_img sz_img]));  
img_padded=padarray(img,[Np Np],'circular'); 

Np_i=Np;Np_j=Np;
img0=img_padded(Np_i+1:end-Np_i,Np_j+1:end-Np_j,:);
max(max(abs(img-img0)))
% 
% % segment the image 'imaster'
% N = size(img_padded);
% Radius_NsNp=floor(Ns/2)+Np_j;
NsNp=Ns+2*Np;
r1=1;
% r1p=1;
for row = 1:Nb_Ns
    
    c1 = 1;
%     c1p = 1;
    for col = 1:Nb_Ns
      r2=r1+Ns-1;
      c2=c1+Ns-1;
      
%       r2p=r1p+NsNp-1;
%       c2p=c1p+NsNp-1; 

  r1p=r1;    
  c1p=c1;
   r2p=r1+Ns+2*Np-1;
   c2p=c1p+Ns+2*Np-1; 
%   if r1==1
%       r1p=r1;
%       r2p=r1+Ns+2*Np-1; 
%   else
%       r1p=r1-Np;r2p=r1p+Ns+2*Np;  
%   end
%       
%    if c1==1
%       c1p=c1;
%       c2p=c1+Ns+2*Np; 
%   else
%        c1p=c1-Np;c2p=c1p+Ns+2*Np+1; 
%        
%    end     
      
 corr_m=[r1 c1;r2 , c2]
 
 corr_p=[r1p c1p;
         r2p c2p] 
   
 


       %% ### Build the subimages from the noisy  image with padding
%          sub_img=img_padded(rr1:rr2,cc1:cc2,:);
         sub_img=img_padded(r1p:r2p,c1p:c2p,:);
%          cc=img_padded(r1:r2,c1:c2,:)
%          dd=sub_img(Np+1:end-Np,Np+1:end-Np,:);
        %%% ### Run the SCSA2D1D  on sub image
        [h,img2,Nh]=SCSA_2D1D(sub_img,h_matrix(row,col),fs,gm);
        denoised_img_segm(r1:r2,c1:c2,:)=img2(Np+1:end-Np,Np+1:end-Np,:);
        Nh_seg=Nh_seg+Nh;

c1=c1+Ns; 
    end
    
    % increment row start index
    r1 = r1 + Ns;
%     r1p = r1p + NsNp-1;
%     r1p=r1p+Ns+2*Np;
end


%   denoised_img = im2single(imresize(denoised_img,sz_img));  
  img_padded;
  img   ;
  s=0;
%%
    %**********************************************************************
    %           Gaussin distribution to  the h-paramter                    *
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


function H=Gaussian_h(nb_Ns,h_center,h_bord)
%% to test 
% h_center=2
% h_bord=0.9
% N=8
%%
N_min=1
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
H22=H*(h_center-h_bord)/max(max(H))+h_bord
H21=fliplr(H22);
H2=[H21(:,1:end-n0) H22]
H1=flipud(H2)
H=[H1(1:end-n0,:);H2]


