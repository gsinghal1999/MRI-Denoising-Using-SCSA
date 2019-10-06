% algo_type_d=1 ;       %type of the SCSA Algorithm :  1) SCSA1D                2) SCSA1D_matrix            3) SCSA2D1D  
                                                                                      % 4) SCSA2D2D            5) SCSA2D2D_sparse       6) SCSA1D_Nh
                                                                                      % 7) SCSA2D1D-PCBh  8) SCSA2D1D-PSGHh
%% this function build the apropriate name for figures after en optimization

function name_op=assign_name_op()
global h gm fs h2 Ns Np dim_x 
if  dim_x== 7 |  dim_x== 8
         name_op=strcat('_hc_op_',num2str(h),'_gm_op_',num2str(gm),'_fs_op_',num2str(fs),'_hb_op_',num2str(h2),'_Ns_op_',num2str(Ns),'_Np_op_',num2str(Np));
else
       name_op=strcat('_hop_',num2str(h),'_gm_op_',num2str(gm),'_fs_op_',num2str(fs));
end

if dim_x > 8
        disp('Error the <name_op> cannot be assigned because <dim_x> value  is not defined ')
end

end