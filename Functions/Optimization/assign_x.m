% algo_type_d=1 ;       %type of the SCSA Algorithm :  1) SCSA1D                2) SCSA1D_matrix            3) SCSA2D1D  
                                                                                      % 4) SCSA2D2D            5) SCSA2D2D_sparse       6) SCSA1D_Nh
                                                                                      % 7) SCSA2D1D-PCBh  8) SCSA2D1D-PSGHh

function [h, gm, fs, h2, Ns, Np,Ni]=assign_x(x)

global algo_type_d  h_G gm_G  fs_G  h2_G  Ns_G  Np_G  Ni_G dim_x   
h=h_G; gm=gm_G;  fs=fs_G;  h2=h2_G;  Ns=Ns_G;  Np=Np_G; Ni=Ni_G;

if algo_type_d ==7 | algo_type_d==8

                     %% Adaptive SCSA                       
                                        switch dim_x
                                        case 1
                                            h=x(1);
                                        case 2
                                            h=x(1); h2=x(2);
                                        case 3
                                          h=x(1); h2=x(2);gm=0.5*floor(x(3));
                                        case 4
                                            h=x(1); h2=x(2);gm=0.5*floor(x(3)); Ns=floor(x(4)); 
                                        case 5
                                             h=x(1); h2=x(2);gm=0.5*floor(x(3)); Ns=floor(x(4)); Np=floor(x(5)); 
                                        case 6
                                             h=x(1); h2=x(2);gm=0.5*floor(x(3)); Ns=floor(x(4)); Np=floor(x(5)); fs=floor(x(6));

                                        otherwise
                                            disp('Error the <dim_x> value  is not defined ')
                                        end
                                        
else
            switch dim_x
            case 1
                h=x(1);
            case 2
                h=x(1); gm=0.5*floor(x(2));
            case 3
              h=x(1); gm=0.5*floor(x(2)); fs=x(3);
            otherwise
                disp('Error the <dim_x> value  is not defined ')
        end
        
    
end

if fs==0
    fs=1;
end

end