%Questa funzione fa le stesse cose dello script "Eq_Del_Calore.m", è stata
%scritta per una più semplice implementazione in script più complessi.

function [u] = eq_del_calore(Im,dt,t,k)
%---Definisco le costanti e le condizioni iniziali
    [ny, nx, ~]=size(Im);       %Dimensioni dell'immagine

%---Metodo eq del calore
    u=double(Im);
    for t = 0:t
        u_xx = u(:,[2:nx nx],:) - 2*u + u(:,[1 1:nx-1],:);  %derivata seconda lungo x
        u_yy = u([2:ny ny],:,:) - 2*u + u([1 1:ny-1],:,:);  %derivata seconda lungo y
        u= u + k*dt*(u_xx+u_yy);
        temp=u;
    end

end