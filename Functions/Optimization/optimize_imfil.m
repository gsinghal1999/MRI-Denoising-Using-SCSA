% cost_fun='cost_function_MSE'
% plot_cost=<0|1>

function [x_op_vect_op,fv_op,Iter ]=optimize_imfil(cost_fun,init_x0,budget,bounds,plot_cost,img_imfil,noisy_img_imfil)
global img_G noisy_img_G iter_counter 

iter_counter=0;
img_G=img_imfil;
noisy_img_G=noisy_img_imfil;
fv_op=inf;Iter=0;

for x_init=1: size(init_x0,2)

                % Call imfil.
                disp('Running SCSA denoising optimization, Please wait!  ')
                x0=init_x0(:,x_init)  
                [x,histout]=imfil(x0,cost_fun,budget,bounds); 
                
                %%  ##Plot optimization trajectrory 
                Iterat =histout(end,1);fv_op_n=histout(end,2);
               [h, gm, fs]= assign_x_vect(x);
                if fv_op_n<fv_op
                fv_op= fv_op_n;x_op_vect_op=[h gm fs];
                end
    Iter=Iter+1            
end
Iter=floor(Iterat/Iter);
