global tab_optz
%% # Set Optimization Parameters[Bounds and Initial guesses]:
budget=1000;                                                     % the bounds, budget, and initial iterate.                                                                  % Number of initial guesses by variable
Li_h2=0;Ui_h2=4;                                                   % The upper and lower bounds of <h2>          
Li_Ns=4;Ui_Ns=64;%floor(200/Ni);                            % The upper and lower bounds of <Ns>       
Li_Np=1;Ui_Np=6;                                                      % The upper and lower bounds of <Np>       
                                                                                     % <ref_diff>=1  or the difference  between the reference and the scsa reconctructed signal                                                                                 
%% #####################################################################################

%% Initialize the global variable
h_init=linspace(Li_h, Ui_h ,Nb_x0);
gm_init=linspace(Li_gm, Ui_gm ,Nb_x0);
fs_init=floor(linspace(Li_fs, Ui_fs ,Nb_x0));
h2_init=linspace(Li_h2, Ui_h2 ,Nb_x0);
Ns_init=floor(linspace(Li_Ns, Ui_Ns ,Nb_x0));
Np_init=floor(linspace(Li_Np, Ui_Np ,Nb_x0));

if (algo_type_d==7 | algo_type_d==8)  
     adapt_scsa=1;
end
if adapt_scsa==0 & dim_x >3   
     dim_x=3;
end
if adapt_scsa==0 
 init_x00=[h_init;gm_init;fs_init];
bounds00=[Li_h, Ui_h;  Li_gm, Ui_gm; Li_fs, Ui_fs];

else
    
init_x00=[h_init; h2_init; gm_init; Ns_init; Np_init; fs_init];
bounds00=[Li_h, Ui_h; Li_h2, Ui_h2; Li_gm, Ui_gm ;Li_Ns, Ui_Ns; Li_Np, Ui_Np; Li_fs, Ui_fs];
end

%% ##generate the initial guess
init_x0=init_x00(1:dim_x,:);
bounds=bounds00(1:dim_x,:);

  
