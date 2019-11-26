function sigf = bruit_avec_RSB(sig0, RSB) %RSB en dB

    l = length(sig0);
    bruit=randn(1, l);
    % m = 0;
    % var = 1;
    %bruit = m + var*randn(1,N);

    % Calcul des puissances:
    
    P0=0;
    Pb = 0;
    for i=1:l
        P0=P0+(sig0(i))^2;
        Pb=Pb+(bruit(i))^2;
    end
    P0=P0/l; %pas en dB
    Pb=Pb/l;
    
    % Ajout du bruit:
    
    var = (P0/Pb)*10^(-RSB/10);
    bruitf = sqrt(var)*bruit;
    sigf = sig0 + bruitf;

end

