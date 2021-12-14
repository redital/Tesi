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
k=0.5;

%---Mostro l'immagine originale
imshow(uint8(Im))
title("immagine originale"); 

%---Metodo eq del calore
u=double(Im);
for t = 0:dt:1
   u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % finite difference approximation for u_xx cioè questa è una derivata seconda lungo x
   u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % finite difference approximation for u_yy cioè questa è una derivata seconda lungo y
   u= u + k*dt*(u_xx+u_yy);
   temp=u;
end

