global tab_optz
% Li_Ns=4;Ui_Ns=64;%floor(200/Ni);                                      % The upper and lower bounds of <Ns>       
% Li_Np=1;Ui_Np=6;                                                      % The upper and lower bounds of <Np>       
% Li_h2=0;Ui_h2=4;                                                      % The upper and lower bounds of <h2>       
%                                                                                   % <ref_diff>=1  or the difference  between the reference and the scsa reconctructed signal                                                                                 
%% #####################################################################################

%% Initialize the global variable
h_range=h_G;gm_range=gm_G;fs_range=fs_G;
if dim_x>=1
h_range=unique(linspace(Li_h, Ui_h ,Nb_h));
end
if dim_x>=2
gm_range=unique(linspace(Li_gm, Ui_gm ,Nb_gm));
end
if dim_x>=3
fs_range=unique(floor(linspace(Li_fs, Ui_fs ,Nb_fs)));
end

