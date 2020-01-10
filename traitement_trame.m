function [mat_finale] = traitement_trame(trames,var,Nech_t)

    %% Paramètres: 
    
    [Nb_t N]=size(trames);
    L = round(2/3*N);
    M = N+1-L;
    fech = 8000;
    duree = 3e-3;
    Nech_t = duree*fech;

    %% Traitement de la trame :
    
    for i=1:Nb_t
    
        trame = trames(i,:);
        H = hankel(trame(1:L),trame(L:N)); %Matrice de Hankel
        [U,sigma,V] = svd(H); %Décomposition en valeurs singulières
        % sigma matrice des valeurs singulieres 

        seuil=var/L;
        [a b]=size(sigma);
        
        j = 1;
        while j<=b && sigma(j,j)>=seuil
            j = j+1;
        end
        Nb_vs = j-1; %nombre des valeurs singulières dominantes
        
        sigma_dom = sigma(1:Nb_vs,1:Nb_vs); %Matrice sigma(1,K)
        
        Us = U(:,1:Nb_vs); % adaptation de la taille de U 
        Vs = V(:,1:Nb_vs); % adaptation de la taille de V 
        
        Hs = Us*sigma_dom*Vs'; 
        
        % estimation de Hs

        Hs = fliplr(Hs); %Flip left to right (pour prendre anti diagonale)
        
        for k = -(L-1):M-1
            S(k+L) = mean(diag(Hs,k)); %on fait la moyenne de chaque ech sur l'antidiagonale
        end
        
        mat_finale(i,:) = fliplr(S); %reflip
    end
end

