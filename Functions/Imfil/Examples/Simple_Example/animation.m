% 

X=step_hist(2:end,1)
Y=step_hist(2:end,2)

% [X Y]=meshgrid(,step_hist(2:end,1));
Z =1:max(size(step_hist(2:end,1)));
% Z=meshgrid(Z0,Z0);

figure(3);
plot3(X, Z, Y)
view([90 0])
% hold on
% h_op = plot(X(end),Y(end),'o','MarkerFaceColor','green');
% hold on
% p = plot(X(1),Y(1), 'o','MarkerFaceColor','red');
% hold off
% % axis manual
% % for k = 2:length(X)
% %     p.XData = X(k);
% %     p.YData = Y(k);
% %     p.ZData = Z(k);
% %     drawnow
% % end
% 
xlabel('h')
ylabel('error')
zlabel('iteration')
% 
% figure(4);
% x = linspace(0,10,1000);
% y = sin(x);
% plot(x,y)
% hold on
% p = plot(x(1),y(1),'o','MarkerFaceColor','red');
% hold off
% axis manual
% for k = 2:length(x)
%     p.XData = x(k);
%     p.YData = y(k);
%     drawnow
% end