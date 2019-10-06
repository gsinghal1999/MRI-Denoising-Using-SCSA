function [fv,ifail,icount]=f_easy(x)
% F_EASY
% Simple example of using imfil.m
%
%function [fv,ifail,icount]=f_easy(x)
%
% fv=x'*x;
% fv=fv*(1 + .1*sin(10 * (x(1) + x(2)) ));

%% ############# The SCSA Script #######################
% clear all; %close all;

scsa_budy

 %% ############# End  SCSA Script #######################

fv=norm((yscsa-y))-(Nh/N)
% fv=-PSNR

%% History 
load('hist_iter.mat','step_hist');
new_step=[x fv];
step_hist=[step_hist;new_step]
save('hist_iter.mat','step_hist');
%
% This function never fails to return a value 
%
ifail=0;
%
% and every call to the function has the same cost.
%
icount=1;
