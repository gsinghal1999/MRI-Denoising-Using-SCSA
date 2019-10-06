function show_value_matrix(paramtr_matrix,figr,title_str)

[n m]=size(paramtr_matrix);
if n+m>2
    figure(figr)
    
    imagesc(paramtr_matrix);
    colorbar;
    title(title_str)
    for ii = 1:n
        for jj = 1:m
            text(jj,ii,num2str(paramtr_matrix(ii,jj)), 'FontSize', 18);
        end
    end
end

