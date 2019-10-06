% cost_fun='cost_function_MSE'
% plot_cost=<0|1>

function [x_op_vect_op,fv_op,Iter ]=SCSA1Ds_scan(plot_cost,img,noisy_img,h_range,gm_range,fs_range)
global   algo_type_d  dim_x  noisy_file  SNR_dB  slice_mse Results_path_denoised h2_G  Ns_G  Np_G  Ni_G...
          figr_num show_performance store_decomposition  num_fv iter_counter tab_optz seg_img 

      disp('Searching for the optimal parameter using Scanning. Please wait a moment...:)')
fv_op=inf;iter_counter=0;

h_range=unique(floor(h_range*100)/100);
gm_range=unique(floor(gm_range*100)/100);
fs_range=unique(floor(fs_range*100)/100);


for h=h_range
    
    for gm=gm_range
        
        for fs=fs_range
            h
            gm
            fs
            tic
            figr_num=1;  show_performance=0 ; store_decomposition=0;
            [algo_type, dz_type, name_denoised, denoised_img, Nh,exe_time]...
            = Run_SCSA_algorithms(algo_type_d, h, gm, fs, h2_G , Np_G, Ns_G , Ni_G ,noisy_img, img, SNR_dB, noisy_file, Results_path_denoised);  
        toc
        %% Evauation     
         [PSNR, SSIM, SI00, SI_1, SNR, MSE]=image_evaluation(img,denoised_img); 
            fv_op_n=MSE;
            
             if fv_op_n<fv_op
                fv_op= fv_op_n;x_op_vect_op=[h gm fs];
             end
           iter_counter=iter_counter+1;
           
           
%% Save history

 if iter_counter==1 
     tab_optz=[h gm fs fv_op_n];
 else  
    tab_optz=[tab_optz;h gm fs fv_op_n];               
 end
 
 
        end
    end
end

Iter=iter_counter;
[h_op, gm_op, fs_op]= assign_x_vect(x_op_vect_op);
fv_op_i=fv_op;
