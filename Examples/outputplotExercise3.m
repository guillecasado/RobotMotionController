%Plot output
figure 
plot(xdyd(:,1),xdyd(:,2),'r')
title('(xd,yd) vs. (y1d,y2d)')
hold on
plot(y1dy2d(:,1),y1dy2d(:,2),'b')
legend('(xd,yd)','(y1d,y2d)')

figure 
plot(y1dy2d(:,1),y1dy2d(:,2),'r')
title('Desired (y1d,y2d) vs. Executed (y1m,y2m)')
hold on
plot(y1my2m(:,1),y1my2m(:,2),'b')
legend('(y1d,y2d)','(y1m,y2m)')

figure 
plot(xdyd(:,1),xdyd(:,2),'r')
title('Desired (xd,yd) vs. Executed (x,y)')
hold on
plot(xyt(:,1),xyt(:,2),'b')
legend('(xd,yd)','(x,y)')

figure 
plot(err)
title('Error')
legend('x','y','theta')
