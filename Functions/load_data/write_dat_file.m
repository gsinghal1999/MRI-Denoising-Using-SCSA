function img=write_dat_file(dat_path,img,name_file,precision_s_d) 
if strcmp(precision_s_d,'single')
    name_file=strcat('s_',name_file,'.dat')
    img=single(img);
else
    name_file=strcat('d_',name_file,'.dat')
    img=double(img);

end
filename=strcat(dat_path,name_file);
fileID = fopen( filename,'w');
fwrite(fileID,img,precision_s_d);
fclose(fileID);
