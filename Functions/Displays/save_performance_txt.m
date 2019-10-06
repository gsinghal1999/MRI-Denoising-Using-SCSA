%% #############################  Store the experemental performance ################## 
fileID = fopen(name_file,'w');
fprintf(fileID,'The Matlab implementation of  the %s  Algorithm  Using: \n - data=%s \n - h=%2f \n - gm=%2f\n - fs=%2d\n - PSNR0=%2f\n ',noisy_file, algo_type(1:end-1), h,gm,fs,PSNR0);
fprintf(fileID,'These parameters givre the following results: \n  - Nh=%d \n  - Emin= =%4e\n  - PSNR=%2f\n',Nh,Emin,PSNR_full);
fprintf(fileID,'\n Done by Abderrazak Chahid   on %s',date);
fclose(fileID);
%% ####################################################################################  


