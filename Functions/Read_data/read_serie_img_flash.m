
%% #################   Adaptive h Method   #######################
%   This script has been modified to store data in : .mat, .pdf, .fig
%  modifed by:
%  Abderrazak Chahid (abderrazak.chahid@gmail.com)
%  Adviser:
%  Taous-Meriem Laleg (taousmeriem.laleg@kaust.edu.sa)
 % Done: Nov,  2016
 
%% ###############################################################

current = cd;
root_folder_name = uigetdir;
%% This script drows the different MRI Image Folders
list = dir(root_folder_name)
list_folders = list(~strncmpi('.', {list.name}, 1));M=max(size(list));
nb_imgs=max(size(list_folders));
rep0=pwd;

for nb_imges=2:nb_imgs

folder_name=strcat(root_folder_name,'\',list_folders(nb_imges).name)
cd(folder_name);

l=[];

for j= 1: length(folder_name)
    
 if folder_name(j) == '\'
     l = [l, j]; 
 end; 
end
name_folder_images = folder_name(l(length(l))+1: length(folder_name));
cd(rep0);
eval(strcat('mkdir ./Extracted_',date,'/',name_folder_images,'/', 'figure'))
eval(strcat('mkdir ./Extracted_',date,'/',name_folder_images,'/', 'pdf_file'))
eval(strcat('mkdir ./Extracted_',date,'/',name_folder_images,'/', 'mat_file'))
cd(folder_name);
filePattern = fullfile(folder_name, '*.IMA');

jpegFiles = dir(filePattern);
imag = [];
imm = [];
immm = [];
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(folder_name, baseFileName);
  %fprintf(1, 'Now reading %s\n', fullFileName);
  [fid, errmsg] = fopen(fullFileName, 'r');

fseek(fid,0,'eof');
Epos = ftell(fid);

fseek(fid,Epos -(448*512*2),'bof');

% fseek(fid,0,'bof');
% Epos = ftell(fid);
% for the dcm images the asl are 72 by 128 and the MPRAGE are 256 by 256
% imag = fread(fid, Epos, 'char=>char')';


imageArray = fread(fid, [448, 512], 'int16');
fclose(fid);
secc = size(imageArray,1);
d = max(max(abs(imageArray)));
imag = [imag, (imageArray')/1]; 
%if k == 5
% imag = [imag, (imageArray')/d];
%imm = [imm; imag];
%montage(imm, 'DisplayRange', [20 100])
% end
     %if k == 10
%         imag = [imag, (imageArray')/d];
%     end
%         if k == 15
%             imag = [imag, (imageArray')/d];
%         end
%             if k == 20
%                 imag = [imag, (imageArray')/d];
%             end
%imag = [imag, (imageArray')/d];

%imm = [imag(:, 1:96*5); imag(:, 96*5+1:96*10);  imag(:, 96*10+1:96*15);
 %      imag(:, 96*15+1:96*20)];
  %imshow(imageArray/d);  % Display image.
  %drawnow; % Force display to update immediately.
%   figure(1);
%     montage(imag, 'Size', [1, 1] , 'DisplayRange', [0 500])


%% added by Abderrzak Chahid 
  cd(rep0);
  img=im2double(imageArray'./(max(max((imageArray)))));
  figure(1); imshow(img);
  title(strcat(name_folder_images,'__',num2str(k)))
  xlabel(baseFileName)

  
    saveas(figure(1),strcat('./Extracted_',date,'/',name_folder_images,'/figure/',name_folder_images,'__',num2str(k),'.fig'))
    saveas(figure(1),strcat('./Extracted_',date,'/',name_folder_images,'/pdf_file/',name_folder_images,'__',num2str(k),'.pdf'))
    save(strcat('./Extracted_',date,'/',name_folder_images,'/mat_file/',name_folder_images,'__',num2str(k),'.mat'),'img');  
    cd(folder_name) 
    %%

end

secc = 448;
for j = 1: floor(length(jpegFiles)/5)
    tmp = imag(:,secc*5*(j-1)+1:secc*5*j);
    immm = [immm; tmp];
end
tmp1 = imag(:,secc*5*j+1:secc*5*j+ secc*mod(length(jpegFiles), 5));
diff = size(tmp, 2) - size(tmp1, 2);
nn = zeros(size(imageArray,2), diff);
ftmp = [tmp1, nn];
immm = [immm; ftmp];
%     figure;
%     montage(immm, 'Size', [1, 1] , 'DisplayRange', [0 500])
%     save(name_folder_images,'immm','imag')
%     
    
%% added by Abderrzak Chahid 
cd(rep0)
   img=im2double(immm./(max(max((immm)))));

   figure(1); imshow(img);
   saveas(figure(1),strcat('./Extracted_',date,'/',name_folder_images,'/figure/',name_folder_images,'.fig'))
   saveas(figure(1),strcat('./Extracted_',date,'/',name_folder_images,'/pdf_file/',name_folder_images,'.pdf'))
 save(strcat('./Extracted_',date,'/',name_folder_images,'/mat_file/',name_folder_images,'.mat'),'immm','img');
tes=1;
%     save(name_folder_images,'immm','imag');

 %%  
end
