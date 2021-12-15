close all
clear all
clc

img=ones(255);                          %creo l'immagine
    for i=80:160
        img(140:180,i)=255;
    end
    
%img=imread('parrot.jpeg');             %Apro l'immmagine
%img=rgb2gray(img);                     %La trasformo in bianco e nero


im=uint8(img);
im = imnoise(im,'salt & pepper',0.02);  %Aggiungo del rumore

figure('Name','Original picture');      %Stampa dell'immagine rumorosa
imshow(im);

num_iter=70;                            %numero di iterazioni
delta_t=0.1;                            %costante d'integrazione
kappa=6;                                %coefficiente di controllo del gradiente

sigma=5;                                %varianza della funzione gaussiana

% conversione in double per il calcolo.
im = double(im);

% Condizioni iniziali della PDE.
diff_im = im;


% Maschera di convoluzione
hN = [0 1 0; 0 -1 0; 0 0 0];
hS = [0 0 0; 0 -1 0; 0 1 0];
hE = [0 0 0; 0 -1 1; 0 0 0];
hW = [0 0 0; 1 -1 0; 0 0 0];


for t = 1:num_iter
   
    % Calcolo alle differenze finite nelle 4 direzioni
    nablaN = convoluzione(diff_im,hN);
    nablaS = convoluzione(diff_im,hS);   
    nablaW = convoluzione(diff_im,hW);
    nablaE = convoluzione(diff_im,hE);
    % Condizioni di sistema isolato
    %nablaN(1,:) = 0;
    %nablaS(end,:) = 0;
    %nablaW(:,1) = 0;
    %nablaE(:,end) = 0;
    
    diff_blur = imgaussfilt(diff_im,sigma);
    nablaN_blur = convoluzione(diff_blur,hN);
    nablaS_blur = convoluzione(diff_blur,hS);   
    nablaW_blur = convoluzione(diff_blur,hW);
    nablaE_blur = convoluzione(diff_blur,hE);
    % Condizioni di sistema isolato
    %nablaN_blur(1,:) = 0;
    %nablaS_blur(end,:) = 0;
    %nablaW_blur(:,1) = 0;
    %nablaE_blur(:,end) = 0;

    cN = exp(-(nablaN_blur/kappa).^2);
    cS = exp(-(nablaS_blur/kappa).^2);
    cW = exp(-(nablaW_blur/kappa).^2);
    cE = exp(-(nablaE_blur/kappa).^2);



        
    % Soluzione discreta della PDE.
    diff_im = diff_im + delta_t*(cN.*nablaN + cS.*nablaS + cW.*nablaW + cE.*nablaE );
           
    % Stampa di controllo
    fprintf('\rIteration %d\n',t);
end
% Stampa dei risultati
figure('Name','Perona Malik');
imshow(uint8(diff_im));
