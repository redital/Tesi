%Questo script serve per visualizzare visivamente cosa vuol dire calcolare
%le derivate di un'immagine, l'effetto dell'equazione del calore e come 
%cambiano le derivate man mano che l'immagine viene diffusa. 
%Alla fine vengono stampati tutti i risultati ma si può scegliere di
%visualizzare levoluzione specifica di un certo valore impostando i l
%vettore "visualizza" in cui indicare a quali iterazioni si è interessati.
%Il numero di una iterazione è t/dt.
%Il programma funziona anche con immagini a colori ma in genere per 
%semplicità di visualizzazione si preferisce convertire l'immagine in 
%bianco e nero, quindi per prima cosa %l'immagine viene filtrata per essere
%in bianco e nero.
%IMPORTANTE scegliere dt e k tali che dt*k<0.25!

close all
clear all
clc

Im=imread('Pictures\ami.png');       %Apro l'immmagine
Im=imresize(Im,0.1);
%Im=rgb2gray(Im);
dim=double(Im);
Im=uint8((dim(:,:,1)+dim(:,:,2)+dim(:,:,3))./3);%Trasformo in bianco e nero
[ny, nx, ~]=size(Im);

dt=0.1;                     %Passo temporale
tmax=0.9;                   %Tempo massimo 
                            %(tmax/dt è il numero di iterazioni)

k=1;                        %%Coefficiente di controllo della diffusione
h=10;                       %Coefficiente per far risaltare le stampe di 
                            %alcuni valori che sono solitamente bassi

u=double(Im);               %Copia dell'immagine originale su cui lavorare


i=0;
c=-1;
visualizza=[1,3,6,9];       %lista delle iterazione di cui si vuole vedere 
                            %i risultati (max 4)

for t = 0:dt:tmax
   c=c+1;
   u_x =  u(:,[1 1:nx-1],:) - u;                       % derivata prima lungo x
   u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % derivata seconda lungo x
   u_y =  u([1 1:ny-1],:,:) - u;                       % derivata prima lungo y
   u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % derivata seconda lungo y
   u_xy = u_x([1 1:ny-1],:,:) - u_x;                   % derivata seconda mista
   
   u= u + dt*k*(u_xx + u_yy);                          % equazione del calore
   
   if ismember(c,visualizza)        %scegliere solo una delle seguenti e lasciare commentate le altre
       i=i+1;
       figure(1)
       %subplot(2,2,i),imshow(uint8(u_x))
       %subplot(2,2,i),imshow(uint8(u_y))
       %subplot(2,2,i),imshow(uint8(u_x.^2))
       %subplot(2,2,i),imshow(uint8(u_y.^2))
       %subplot(2,2,i),imshow(uint8(u_x + u_y))
       %subplot(2,2,i),imshow(uint8(u_x.^2 + u_y.^2))
       %subplot(2,2,i),imshow(uint8(u_x.^2 .* u_xx + u_y.^2 .* u_yy))
       %subplot(2,2,i),imshow(uint8(2*u_x.*u_y.*u_xy))
       %subplot(2,2,i),imshow(uint8(u_x.^2 .* u_xx + u_y.^2 .* u_yy + 2*u_x.*u_y.*u_xy))
       subplot(2,2,i),imshow(uint8(u))
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
       


