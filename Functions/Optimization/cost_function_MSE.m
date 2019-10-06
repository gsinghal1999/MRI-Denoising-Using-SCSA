function [fv,ifail,icount]=cost_function_MSE(x)
global   algo_type_d img_G noisy_img_G   noisy_file  SNR_dB  slice_mse Results_path_denoised...
              h_G gm_G  fs_G  h2_G  Ns_G  Np_G Ni_G figr_num show_performance store_decomposition ...
              dim_x  num_fv iter_counter tab_optz
 
%% Start the SCSA Algorithm
fprintf('.')
 [h_G, gm_G, fs_G, h2_G, Ns_G, Np_G,Ni_G]=assign_x(x);
figr_num=1;  show_performance=0 ; store_decomposition=0;
[algo_type, dz_type, name_denoised, denoised_img, Nh,exe_time]...
    = Run_SCSA_algorithms(algo_type_d, h_G, gm_G, fs_G, h2_G, Np_G, Ns_G, Ni_G,noisy_img_G, img_G, SNR_dB, noisy_file, Results_path_denoised);  

%% Evaluate performance
list_fv=list_cost_functions_x_seg(img_G,denoised_img,slice_mse,Np_G,Ns_G);   % provides the list of cost functions to compare in this optimization

num_fv=1;fv=list_fv(num_fv);

%% Save history
if dim_x==1
x_vect0=x;
else
    x_vect0=x';
end

 if iter_counter==1 
     tab_optz=[ h_G gm_G fs_G fv];
 else  
    tab_optz=[tab_optz;h_G gm_G fs_G fv];               
 end
 
iter_counter=iter_counter+1;           
%  if iter_counter==1 
%      tab_optz=[x_vect0, list_fv fv];
%  else  
%     tab_optz=[tab_optz;x_vect0, list_fv fv];                %  containes [x, list_fv, fv]
%  end

% This function never fails to return a value 
%
ifail=0;
%
% and every call to the function has the same cost.
%
icount=1;
