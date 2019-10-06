function [x,histout]=driver_easy;
% DRIVER_EASY
% Minimize f_easy with imfil.m
%
% function [x,histout,complete_history]=driver_easy;
%

%% Add folder 
addpath ../../
%
% Set the bounds, budget, and initial iterate.
bounds=[0, 10000];
budget=100;
x0=[0.5]';
%
% Call imfil.
%
delete('hist_iter.mat')
step_hist=[0 0];
save('hist_iter.mat','step_hist');
[x,histout]=imfil(x0,'f_easy',budget,bounds);
%
% Use the first two columns of the histout array to examine the
% progress of the iteration.
%
%histout(:,1:2)



 
