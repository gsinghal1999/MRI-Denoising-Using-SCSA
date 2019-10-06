
%% Choose the Data set
ext = './Input_data/*.mat';  
t=0;


% ext = '../0_Image_Data/mat_Simulated_images/*.mat';  

%% #########################    Load data   ################################
[filename rep]= uigetfile({ext}, 'File selector')  ;
chemin = fullfile(rep, ext);  list = dir(chemin);  
cname=strcat(rep, filename);  
load(cname);  
N=max(size(img));  
if min(size(img))==N
    t=0;
end


%% #Evaluation of SNR of the noisy image/signal
[PSNR0, SSIM0, SI00, SI_0, SNR0, MSE0]=image_evaluation(img, noisy_img);  

%% ################### Start the optimization  #############################
img0=img;
% img=noisy_img-img0;
img0_loaded=img0;
img_loaded=img;
noisy_img_loaded=noisy_img;
t_loaded=t;

