function [signal_final] = reconstitution(signal, duree,var)

    %% Parametres :
    
    Nech=length(signal);
    fech=8000;
    N_ech_trame=duree*fech;
    d=50/100*N_ech_trame;
    Nb_trame=Nech/d-1;

    %% Décomposition du signal en trames :
    
    duree_t = 3e-3;
    fech = 8e3; % 8KHz
    Nech_t = duree_t*fech; %Nombre d'échantillons dans une trame
    rec = 0.5; %taux de recouvrement
    Nb_t = Nech_t/rec*Nech_t-1; %Nombre total de trames

    % Initialisation matrice des trames:

    trames = zeros(Nb_t, Nech_t); %Matrice avec trame/ligne et 24ech/trame

    % Remplissage matrice des trames:

    fenetre = hanning(Nech_t)'; % Fenetrage par fenetre de Hanning

    for i=1:Nb_t      %Pour chaque trame
        trames(i,:)=signal(((i-1)*Nech_t/2)+1:((i-1)*Nech_t/2)+Nech_t); %ligne i = trame n°i
        trames(i,:)=trames(i,:).*fenetre; %puis on fenetre 
    end


    %% Traitement par trame :
    
    mat_finale = traitement_trame(trames,var,Nech_t);

    %% Reconstitution du signal :
    
    s_fen = zeros(1,Nech); %signal fenetré
    ajout = zeros(1,Nech); %ce par quoi le fenetrage multiplie les échantillons
    
    for i=0:Nb_t-1
        
    % addition des signaux s(k)supperposes, cad pris au meme instant
    
        s_fen((i/2)*Nech_t+1:(i/2+1)*Nech_t) = s_fen((i/2)*Nech_t+1:(i/2+1)*Nech_t)+mat_finale(i+1,:);
        ajout((i/2)*Nech_t+1:(i/2+1)*Nech_t) = ajout((i/2)*Nech_t+1:(i/2+1)*Nech_t)+fenetre;
    end
    
    signal_final = s_fen./ajout;
end

