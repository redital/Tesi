clc
close all
clear all


Im=imread('parrot.jpeg');   %Apro l'immmagine
Im=rgb2gray(Im);            %La trasformo in bianco e nero
Im = imnoise(Im,'gaussian');%Aggiungo del rumore

%---Definisco le costanti e le condizioni iniziali

[ny, nx, ~]=size(Im)        %Dimensioni dell'immagine
dt=0.25;                    %Passo temporale
u=double(Im);               %Copia dell'immagine originale su cui lavorare
%POI BOH C'è UNA R e alpha
k=0.5;

%---Mostro l'immagine originale
imshow(uint8(Im))
title("immagine originale"); 

%---Mostro come il laplaciano di u evidenzi inizialmente i bordi dell'immagine
%figure()
h=10;                       %Definisco un parametro che userò per enfatizzare i bordi in fase di stampa 
u=double(Im);
i=0;
for t = 0:0.1:0.5c
   i=i+1;
   u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % finite difference approximation for u_xx cioè questa è una derivata seconda lungo x
   u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % finite difference approximation for u_yy cioè questa è una derivata seconda lungo y
   if i>0
       figure(2)
       subplot(2,3,i), imshow(uint8(h*(u_xx + u_yy)))
       title(sprintf('T=%d',t)); 
   end
   u= u + k*dt*(u_xx+u_yy);
   %figure(3)
   %subplot(2,2,i),imshow(uint8(u))
   %title(sprintf('T=%d',t)); 
   temp=u;
end

%---Metodo eq del calore
u=double(Im);
for t = 0:dt:1
   u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % finite difference approximation for u_xx cioè questa è una derivata seconda lungo x
   u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % finite difference approximation for u_yy cioè questa è una derivata seconda lungo y
   u= u + k*dt*(u_xx+u_yy);
   temp=u;
end

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
       


%---Metodo "mio"
u=double(Im);
for t = 0:dt:1
   u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % finite difference approximation for u_xx cioè questa è una derivata seconda lungo x
   u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % finite difference approximation for u_yy cioè questa è una derivata seconda lungo y
   u= u + k*dt*(u_xx+u_yy);
   temp=u;
end

u=double(Im);
for t = 0:0.1:0.9
   u_x =  u(:,[1 1:nx-1],:) - u;                       % finite difference approximation for u_x cioè questa è una derivata prima lungo x
   u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % finite difference approximation for u_xx cioè questa è una derivata seconda lungo x
   u_y =  u([1 1:ny-1],:,:) - u;                       % finite difference approximation for u_y cioè questa è una derivata prima lungo y
   u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % finite difference approximation for u_yy cioè questa è una derivata seconda lungo y
   u_xy = u_x([1 1:ny-1],:,:) - u_x;                   % finite difference approximation for u_xy cioè questa è una derivata seconda mista
   
   
   
   a_11=2*u_x.^2.*(1./(2*(sqrt(1+abs(u_xx+u_yy).^2)).^3)) + 1./(sqrt(1+abs(u_xx+u_yy).^2));
   a_12=2*u_x.*u_y.*(1./(2*(sqrt(1+abs(u_xx+u_yy).^2)).^3));
   a_22=2*u_y.^2.*(1./(2*(sqrt(1+abs(u_xx+u_yy).^2)).^3)) + 1./(sqrt(1+abs(u_xx+u_yy).^2));
   
   %s= a_11.*u_xx + 2*a_12.*u_xy + a_22.*u_yy;
   %u=u+s;

   s=u_x.^2 .* u_xx + u_y.^2 .* u_yy + 2*u_x.*u_y.*u_xy;
   %if t>0.5
   %    u= u + dt*k*(s);
   %else
   %    u= u + dt*k*(u_xx + u_yy);
   %end
   figure()
   subplot (1,2,1), imshow(uint8(s))
   title(sprintf('T=%d',t));
   subplot (1,2,2), imshow(uint8(u))
   

   
   temp=u;
end