
u=double(Im);
i=-6;
for t = 0:0.1:0.9
   i=i+1;
   u_x =  u(:,[1 1:nx-1],:) - u;                       % finite difference approximation for u_x cioè questa è una derivata prima lungo x
   u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % finite difference approximation for u_xx cioè questa è una derivata seconda lungo x
   u_y =  u([1 1:ny-1],:,:) - u;                       % finite difference approximation for u_y cioè questa è una derivata prima lungo y
   u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % finite difference approximation for u_yy cioè questa è una derivata seconda lungo y
   u_xy = u_x([1 1:ny-1],:,:) - u_x;                   % finite difference approximation for u_xy cioè questa è una derivata seconda mista
   %u= u + (u_x.^2 .* u_xx + u_y.^2 .* u_yy + 2*u_x.*u_y.*u_xy);
   u= u + dt*k*(u_xx + u_yy);
   if i>0
       figure(3)
       %subplot(2,2,i),imshow(uint8(u_x))
       %subplot(2,2,i),imshow(uint8(u_y))
       %subplot(2,2,i),imshow(uint8(u_x.^2))
       %subplot(2,2,i),imshow(uint8(u_y.^2))
       %subplot(2,2,i),imshow(uint8(u_x + u_y))
       %subplot(2,2,i),imshow(uint8(u_x.^2 + u_y.^2))
       %subplot(2,2,i),imshow(uint8(u_x.^2 .* u_xx + u_y.^2 .* u_yy))
       %subplot(2,2,i),imshow(uint8(2*u_x.*u_y.*u_xy))
       subplot(2,2,i),imshow(uint8(u_x.^2 .* u_xx + u_y.^2 .* u_yy + 2*u_x.*u_y.*u_xy))
       title(sprintf('T=%d',t));
   end
   temp=u;
end

%---Serie di stampe atte a capire gli effetti delle varie operazioni
       figure()
       subplot(3,3,4),imshow(uint8(h*u_x))
       title("h*u_x");
       subplot(3,3,5),imshow(uint8(h*u_y))
       title("h*u_y");
       subplot(3,3,6),imshow(uint8(h*(u_x + u_y)))
       title("h*(u_x + u_y)");
       subplot(3,3,1),imshow(uint8(u_x))
       title("u_x");
       subplot(3,3,2),imshow(uint8(u_y))
       title("u_y");
       subplot(3,3,7),imshow(uint8(u_x.^2))
       title("u_x.^2");
       subplot(3,3,8),imshow(uint8(u_y.^2))
       title("u_y.^2");
       subplot(3,3,3),imshow(uint8(u_x + u_y))
       title("u_x + u_y");
       subplot(3,3,9),imshow(uint8(u_x.^2 + u_y.^2))
       title("u_x.^2 + u_y.^2");
       


