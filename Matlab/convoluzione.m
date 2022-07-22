%Questa funzione serve ad operare una convoluzione bidimensionale nella
%fattispecie è stata scritta per ossere operata per il filtraggio di
%immagini. Essa prende in input un'immagine A e una maschera di
%convoluzione k. 
%Funziona solo per immagini in bianco e nero, per immagini a colori dare in
%input alla funzione i singoli canali per poi riunirli successivamente.

function B=convoluzione(A,k);

[r c] = size(A);                                %Memorizzo le dimensioni dell'immagine
[m n] = size(k);                                %Memorizzo le dimensioni della maschera
h = rot90(k, 2);

%Definisco una cornice per gestire gli effetti di bordo
center = floor((size(h)+1)/2);                  
left = center(2) - 1;
right = n - center(2);
top = center(1) - 1;
bottom = m - center(1);

%Preparo un "piano di lavoro"
Rep = zeros(r + top + bottom, c + left + right);
for x = 1 + top : r + top
    for y = 1 + left : c + left
        Rep(x,y) = A(x - top, y - left);
    end
end

%Opero la convoluzione
B = zeros(r , c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : m
            for j = 1 : n
                q = x - 1;
                w = y -1;
                B(x, y) = B(x, y) + (Rep(i + q, j + w) * h(i, j));
            end
        end
    end
end


