%Questo script applica il metodo Peron-Malik ad un'immagine data. 
%All'imagine viene dato del rumore per vedere gli effetti sull'immagine 
%rumorosa.
%Vengono visualizzate immagine originale e immagine filtrata per un
%essere confrontate.
%Il programma funziona con immagini iin bianco e nero, per cui occorre per
%prima cosa trasformarla in bianco e nero
%IMPORTANTE scegliere dt e sigma tali che  dt<0.25 e dt*k<0.25!

close all
clear all
clc

im=imread('Pictures\ami.png');                    %Apro l'immmagine
im=imresize(im,0.2);                     %Scalamento dell'immagine nel caso
                                         %lo si ritenesse opportuno
%im=rgb2gray(im);                         %La trasformo in bianco e nero
dim=double(im);
im=uint8((dim(:,:,1)+dim(:,:,2)+dim(:,:,3))./3);


%im=uint8(img);
im = imnoise(im,'salt & pepper',0.02);   %Aggiungo del rumore

figure('Name','Original picture');       %Stampa dell'immagine rumorosa
imshow(im);

num_iter=20;                             %numero di iterazioni
delta_t=0.1;                             %costante d'integrazione
kappa=60;                                %coefficiente di controllo del gradiente

sigma=1;                                 %costante di controllo diffusione uniforme

% conversione in double per il calcolo.
im = double(im);

% Condizioni iniziali della PDE.
diff_im = im;


% Maschera di convoluzione
hN = [0 1 0; 0 -1 0; 0 0 0];
hS = [0 0 0; 0 -1 0; 0 1 0];
hE = [0 0 0; 0 -1 1; 0 0 0];
hW = [0 0 0; 1 -1 0; 0 0 0];

f = waitbar(0,"Processando l'immagine",'Name','Filtro Perona-Malik');
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
    
    diff_blur = f_eq_del_calore(diff_im,delta_t,num_iter,sigma);
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
    %fprintf('\rIteration %d\n',t);
    waitbar(t/num_iter,f,"Processando l'immagine");
end
% Stampa dei risultati
close(f)
figure('Name','Perona Malik');
imshow(uint8(diff_im));
