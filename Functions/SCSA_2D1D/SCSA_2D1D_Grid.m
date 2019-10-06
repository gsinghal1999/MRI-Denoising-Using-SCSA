%%
    %**********************************************************************
    %                        SCSA_2D1D_Grid  Function                          *
    %**********************************************************************

 % Author:  Abderrazak Chahid  
 % aberrazak.chahid@gmail.com

 % Adviser  : Professor Taous_Meriem Laleg . EMAN Group KAUST 
 % taousmeriem.laleg@kaust.edu.sa 
 
 %% Description
 % Script Applies  adaptive h-parameter of the SCSA algorithm on a 2D image of size n 
 

 % Done: Nov,  2016
 
 
%% input parapeters
% img: original image  
% fe : sampling frequency 
% h  : SCSA parameter
% gm  : SCSA parameter
 
%% output parapeters
% h  : Optimized or used SCSA parameter
% img_denoised :  denoised  Image
% Nh : mean of Eigen values chosen to reconstruct te image


function [h, img_denoised,Nh]=SCSA_2D1D_Grid(Ns, img, h, fe, gm )
N=max(size(img));
nb_Ns=N/Ns;
            for index=0:nb_Ns*nb_Ns-1
                    
                    J=mod(index,nb_Ns);
                    I= floor(index/nb_Ns);
                    I_min=I*Ns+1
                    
                    J_min=J*Ns+1;

                    
                    if ((J~=0 && J~=nb_Ns-1 )&& (I~=0 &&I~=nb_Ns-1) )
  
                        h=h;
                    else
                         h=h;
                    end
                        
                    sub_img=img(I_min:I_min+Ns-1,J_min:J_min+Ns-1 );
                    [h,sub_img_denoised,Nh]=SCSA_2D1D(sub_img,h,fe,gm);
                    img_denoised(I_min:I_min+Ns-1,J_min:J_min+Ns-1 )=sub_img_denoised;
% %                 
            end




%% Needed Functions Simp abd Delta

    %**********************************************************************
    %*********              Numerical integration                 *********
    %**********************************************************************

    % Author: Taous Meriem Laleg
    function y = simp(f,dx)
    %  This function returns the numerical integration of a function f
    %  using the Simpson method

    [n,~]=size(f);
    %I(1)=1/3*f(1)*dx;
    I=1/3*(f(1,:)+f(2,:))*dx;

    for i=3:n
        if(mod(i,2)==0)
            I=I+(1/3*f(i,:)+1/3*f(i-1,:))*dx;
        else
            I=I+(1/3*f(i,:)+f(i-1,:))*dx;
        end
    end
    y=I;
%{
    function y = simp1(f,dx);
    %  This function returns the numerical integration of a function f
    %  using the Simpson method

    n=length(f);
    %I(1)=1/3*f(1)*dx;
    I=1/3*(f(1)+f(2))*dx;

    for i=3:n
        if(mod(i,2)==0)
            I=I+(1/3*f(i)+1/3*f(i-1))*dx;
        else
            I=I+(1/3*f(i)+f(i-1))*dx;
        end
    end
    y=I;
    
    function y = simp_s(f,dx);
    %  This function returns the numerical integration of a function f
    %  using the Simpson method

    n=length(f);
    I(1)=1/3*f(1)*dx;
    I(2)=1/3*(f(1)+f(2))*dx;

    for i=3:n
        if(mod(i,2)==0)
            I(i)=I(i-1)+(1/3*f(i)+1/3*f(i-1))*dx;
        else
            I(i)=I(i-1)+(1/3*f(i)+f(i-1))*dx;
        end
    end
    y=I(n);
%}



%Author: Zineb Kaisserli

function [Dx]=delta(n,fex,feh)
    ex = kron([(n-1):-1:1],ones(n,1,'single'));
    if mod(n,2)==0
        dx = -pi^2/(3*feh^2)-(1/6)*ones(n,1,'single');
        test_bx = -(-1).^ex*(0.5)./(sin(ex*feh*0.5).^2);
        test_tx =  -(-1).^(-ex)*(0.5)./(sin((-ex)*feh*0.5).^2);
    else
        dx = -pi^2/(3*feh^2)-(1/12)*ones(n,1,'single');
        test_bx = -0.5*((-1).^ex).*cot(ex*feh*0.5)./(sin(ex*feh*0.5));
        test_tx = -0.5*((-1).^(-ex)).*cot((-ex)*feh*0.5)./(sin((-ex)*feh*0.5));
    end
    Ex = spdiags([test_bx dx test_tx],[-(n-1):0 (n-1):-1:1],n,n);
    Ex = full(Ex);
    
    Dx=(feh/fex)^2*Ex;
 

