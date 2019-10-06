function [h, gm, fs]=assign_x_vect(x)

gm=4;fs=1;
dim_x=max(size(x));
switch dim_x
case 1
h=x(1);
case 2
h=x(1); gm=x(2);%0.5*floor(x(2));
case 3
h=x(1); gm=x(2);fs=x(3);%0.5*floor(x(2)); 
otherwise
disp('Error the <dim_x> value  is not defined ')
end

    
if fs==0
    fs=1;
end

