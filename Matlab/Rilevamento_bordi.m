%Funzione creata per lo studio del rilevamento dei bordi. Supporta alcune
%immagini semplici che possono essere generate da matlab, oppure si può
%caricare un'immagine presente nella stessa cartella dello script
%passandone il nome o il percorso.
%Vengono stampati i risultati in due figure riportanti derivate parziali,
%gradiente e laplaciano.

function [] = Rilevamento_bordi(nome,gray)

%Apro l'immmagine

if strcmp(nome, 'sfumatura lungo x.png')
    img=ones(255);
    for i=1:255
        img(:,i)=i;
    end
    Im=uint8(img);
elseif strcmp(nome, 'sfumatura diagonale.png')
    img=zeros(255);
    for i=1:255
        img=img+diag(diag(i*ones(255-i+1)),i-1);
    end
    Im=uint8(img);
elseif strcmp(nome, 'phantom.png')
    img=256*phantom();
    Im=uint8(img);
elseif strcmp(nome, 'rettangolo.png')
    img=ones(255);
    for i=80:160
        img(140:180,i)=255;
    end
    Im=uint8(img);
    Im = imnoise(Im,'salt & pepper',0.02)
elseif strcmp(nome, 'rettangolo sfumato.png')
    img=ones(255);
    for i=80:160
        img(140:180,i)=255;
    end
    Im=uint8(img);
    Im = imnoise(Im,'salt & pepper',0.02)
    Im = uint8(f_eq_del_calore(double(Im),0.1,20,2))

else
    Im=imread(nome);
    if gray
        Im=rgb2gray(Im);
    end
end



[ny, nx, ~]=size(Im)        %Dimensioni dell'immagine
u=double(Im);               %Copia dell'immagine originale su cui lavorare

h=8;                        %Definisco un parametro che userò per enfatizzare i bordi in fase di stampa 

%---Calcolo tutte le derivate
u_x =  u(:,[1 1:nx-1],:) - u;                       % derivata prima lungo x
u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  % derivata seconda lungo x
u_y =  u([1 1:ny-1],:,:) - u;                       % derivata prima lungo y
u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  % derivata seconda lungo y
u_xy = u_x([1 1:ny-1],:,:) - u_x;                   % derivata seconda mista
   
%Stampo i risultati
figure()
subplot(2,3,2),text(0.3,0,nome,"FontSize",20); axis off
subplot(2,3,4), imshow(Im)
title("Immagine originale")
subplot(2,3,5), imshow(uint8(h*abs(u_x)))
title("h*u_x")
subplot(2,3,6), imshow(uint8(h*abs(u_y)))
title("h*u_y")

figure()
subplot(2,3,2),text(0.3,0,nome,"FontSize",20); axis off
subplot(2,3,4), imshow(Im)
title("Immagine originale")
subplot(2,3,5), imshow(uint8(h*(abs(u_x) + abs(u_y))))
title("h*(u_x + u_y)")
subplot(2,3,6), imshow(uint8(h*(abs(u_xx) + abs(u_yy))))
title("h*(u_{xx} + u_{yy})")

end
