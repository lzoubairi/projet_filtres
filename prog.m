clear
close all
clc

%% Signal :

s = load("fcno04fz.mat");
signal = s.fcno04fz; %57344x1
signal = signal';
Nech = length(signal);
fech = 8e3;
RSB = 20;
d = 3e-3; %duree d'une trame 

%% Bruitage avec un RSB donné:

[Sb, var ] = bruit_avec_RSB(signal, RSB);

%% Découpage et traitement par trames et reconstitution: 

Sd = reconstitution(Sb, d, var);

%% Figures: 

figure,

subplot(2,1,1);
plot(signal);
title('Représentation temporelle de s');

subplot(2,1,2);
spectrogram(signal);
title('Spectrogramme de s');

%Affichage signal bruité + spectrogramme:

figure,

subplot(2,1,1);
plot(Sb);
title('Représentation temporelle de s bruité');

subplot(2,1,2);
spectrogram(Sb);
title('Spectrogramme de s bruité');

%Affichage signal bruité + spectrogramme:

figure,

subplot(2,1,1);
plot(Sd);
title('Représentation temporelle de s débruité');

subplot(2,1,2);
spectrogram(Sd);
title('Spectrogramme de s débruité');

sound(s)
