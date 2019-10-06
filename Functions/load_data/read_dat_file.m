function img=read_dat_file(file_path,precision_s_d) 
fid = fopen(file_path,'r');
upload_buffer = fread(fid,inf,precision_s_d);
fclose(fid);
sz_img=sqrt(max(size(upload_buffer)));
img=reshape(upload_buffer, sz_img, sz_img);