%% Add folder 
addpath ../../../SCSA1D/Functions_Routines
%% General parameter
N = 100;            % number of points
fs=1;                % Sampling frequancy
sigma=0.0           % noise standard deviation
h=x               % SCSA tuning parmter 
gm=0.5;     % SCSA paramters
Nh0 = 80;
%% Generate signal: choose one option=1 or option=2
t=[(1-N)/(2*N):1/N:(N-1)/(2*N)]';
% y= Nh0*(Nh0+1)*sech(t).^2;

% fo = 10;
% f1 = 100;
% y = 10*chirp(t,fo,N,f1,'quadratic',[],'concave');

y=-100*t.^2;

%% generate noise 
y_noisy = y + randn(size(y))*sigma*(max(y)-min(y)); % noisy signal 


%% Start the SCSA Algorithm
[yscsa,Nh,SC_h] = eig_analysis(y_noisy,fs,h,gm);

PSNR=psnr(yscsa,y);

% 
% %% scaling the input 
% y_noisy0=(y_noisy-min(y_noisy))./max(y_noisy)
% 
% %% Start the SCSA Algorithm
% [yscsa0,Nh,SC_h] = eig_analysis(y_noisy0,fs,h,gm);
% 
% yscsa=yscsa0*max(y_noisy)+min(y_noisy);
% 
% PSNR=psnr(yscsa,y);
% 
% 
