    %**********************************************************************
    %                        SCSA_2D1D  Function                          *
    %**********************************************************************

 % Modified by:  Abderrazak Chahid  
 % aberrazak.chahid@gmail.com
 % Original Author : Professor Taous_Meriem Laleg . EMAN Group KAUST 
 % taousmeriem.laleg@kaust.edu.sa 
 
 %% Description
 % Script Applies the SCSA algorithm  on 2D image of size n 
 
 % Done: Aug,  2016
 
 
%% input parapeters
% img: original image  
% fe : sampling frequency 
% h  : SCSA parameter
% gm  : SCSA parameter
 
%% output parapeters
% h  : Optimized or used SCSA parameter
% V2   :  denoised  image
% Nh : Mean Number of Eigen values chosen

function [h, V2,Nh]=SCSA_2D1D(img,h,fe,gm)
global disp_msg
n = size(img,1);
  PSINNORY = zeros(n,n,n,'single');
  KAPPAY = zeros(n,n,'single');
  NY = zeros(n,1,'single');
  lamda = zeros(n,n,'single');
  psiy = zeros(n,n,'single');
  temp = zeros(n,1,'single');
  V1 = zeros(n,n,'single');
  V2 = zeros(n,n,'single');
%}

% IMPORTANT: do not run this code directly, run it from main.m to
% allocate data and read image

V = 0.5.*img;
n = size(V,1);
if disp_msg==1
    n
end
feh = 2*pi/n;
%gm1 = 4;
%L1 = (1/(4*pi))*gamma(gm1+1)/gamma(gm1+2); % la constante universelle
L = (1/(4*pi))/(gm+1); % la constante universelle
%L-L1
h2L = h^2/L;
D = delta(n,fe,feh);
D = -h*h*D;

% [p1,q1]=size(img);
% for i=1:p1
%     col=(i-1)*q1+1;
%     imm_t1(col:col+p1-1)=img(i,:);
% end
% 
% SNR_B=mean(imm_t1)/std(imm_t1);
%  SNR_B_dB=20*log10(SNR_B)
% 

if disp_msg==1
disp('Begin for columns, please wait ... :)')
end
%t = cputime;
ts = tic;

for i = 1:n
if disp_msg==1
fprintf('.');
end
    SCy = D-diag(V(:,i)); % Schr\"odinger operator
    
%         if (rank(SCy)==n)

            [psiy,lamda]=eig(SCy); % Eigenvalues & eigenfunction of Schr\"odinger operator
            % Negative eigenvalues
            temp = diag(lamda);
            temp1 = temp(temp<0);
            Ny = length(temp1);
            KAPPAY(i,1:Ny) = -temp1;

            % The associated $L^2$-normalized eigenfunctions.
            psiny = psiy(:,1:Ny).^2;
            Iy = simp(psiny,fe);
            II = diag(1./Iy);

            NY(i) = Ny;
            PSINNORY(i,:,1:Ny) = psiny*II;
%         else
% 
%                Nh=0;
%                return 
%          
%         end

end
% t1 = toc(ts)
% 
% ts = tic;
if disp_msg==1
fprintf('\n');
disp('Begin for Rows, please wait ... :)')
fprintf('\n .');
end

for i = 1:n
  if disp_msg==1  
    fprintf('.');
  end
    %Step = i
    % Raws
    SCx = D-diag(V(i,:)); % Schr\"odinger operator

%   if (rank(SCx)==n)

        [psix,lamda] = eig(SCx);% Eigenvalues & eigenfunction of Schr\"odinger operator

        % Negative eigenvalues
        temp = diag(lamda);
        kappax = -temp(temp<0);
        Nx = length(kappax);
 
        % The associated $L^2$-normalized eigenfunctions.
        psinx = psix(:,1:Nx).^2;
        Iy = simp(psinx,fe);
        II = diag(1./Iy);
        psinnorx = psinx*II;
        %
        for j = 1: n
            Kap = (repmat(kappax,1,NY(j)) + repmat(KAPPAY(j,1:NY(j)),Nx,1));
            if gm == 4
                Kap = Kap.*(Kap);Kap = Kap.*(Kap);
            elseif gm == 3
                Kap1 = Kap;
                Kap = Kap.*(Kap);Kap = Kap.*(Kap1);
            elseif gm == 2
                Kap = Kap.*(Kap);
            else
                Kap = Kap.^(gm);
            end
            PSINY = reshape(PSINNORY(j,i,1:NY(j)),NY(j),1);
            V1(i,j) = (h2L)*(psinnorx(j,1:Nx)*Kap*(PSINY));
        end
%         
%         else
% %             disp('The SCx matrix is not full rank')
%                Nh=0
%                return 
% end

NX(i) = Nx;
end

V2 = (V1.^(1/(gm+1)));
Nh=mean([NY' NX]);








    %**********************************************************************
    %*********              Numerical integration                 *********
    %**********************************************************************

    % Author: Taous Meriem Laleg [Modified]
    function y = simp(f,dx)
    %  This function returns the numerical integration of a function f
    %  using the Simpson method

    [n,~]=size(f);
    if n>1
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
    else
       y=f*dx; 
    end
    
    
    
    
% 
% 
%     %**********************************************************************
%     %*********              Numerical integration                 *********
%     %**********************************************************************
% 
%     % Author: Taous Meriem Laleg
%     function y = simp(f,dx)
%     %  This function returns the numerical integration of a function f
%     %  using the Simpson method
% 
%     [n,~]=size(f);
%     %I(1)=1/3*f(1)*dx;
%     I=1/3*(f(1,:)+f(2,:))*dx;
% 
%     for i=3:n
%         if(mod(i,2)==0)
%             I=I+(1/3*f(i,:)+1/3*f(i-1,:))*dx;
%         else
%             I=I+(1/3*f(i,:)+f(i-1,:))*dx;
%         end
%     end
%     y=I;
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
