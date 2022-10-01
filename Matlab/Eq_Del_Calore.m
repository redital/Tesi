%Questo script applica l'equazione del calore ad un'immagine data. 
%All'imagine viene dato del rumore per vedere gli effetti sull'immagine 
%rumorosa.
%Vengono visualizzate immagine originale e immagine filtrata per un
%essere confrontate.
%IMPORTANTE scegliere dt e k tali che dt*k<0.25!

clc
close all
clear all

Im=imread('Pictures\ami.png');                   %Apro l'immmagine
Im=imresize(Im,0.3);                    %Scalamento dell'immagine nel caso
                                        %lo si ritenesse opportuno
%Im=rgb2gray(Im);                        %La trasformo in bianco e nero
dim=double(Im);
Im=uint8((dim(:,:,1)+dim(:,:,2)+dim(:,:,3))./3);
Im=imnoise(Im,'salt & pepper',0.02);    %Aggiungo del rumore

%---Definisco le costanti e le condizioni iniziali

[ny, nx, ~]=size(Im);       %Dimensioni dell'immagine
dt=0.1;                     %Passo temporale
tmax=2;                     %Tempo massimo 
k=2;                        %Coefficiente di controllo della diffusione

%---Mostro l'immagine originale
figure('Name',"immagine originale");
imshow(uint8(Im))

%---Metodo eq del calore
u=double(Im);               %Copia dell'immagine originale su cui lavorare
for t = 0:dt:tmax
   u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % finite difference approximation for u_xx cioè questa è una derivata seconda lungo x
   u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % finite difference approximation for u_yy cioè questa è una derivata seconda lungo y
   u= u + k*dt*(u_xx+u_yy);
   temp=u;
end
figure('Name','equazione del calore');       %Stampa dell'immagine rumorosa
imshow(uint8(u));
