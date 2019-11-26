clear
close all
clc

%% Préliminaire 1:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = load("fcno04fz.mat");
signal = s.fcno04fz; %57344x1
signal = signal';
% figure;
% plot(signal);
% title('signal de parole');

N = 500;
m = 0;
l = length(signal);
sigma = 1;
var = sigma^2;
axet = 0:10/(l-1):10;
axef = -1/2:1/N:1/2-1/N;


%Bruit blanc gaussien

BBG = m + var*randn(1,N);
% figure
% plot(axet, BBG);
% title('BBG');


%fonction autocorr théorique:

Rss_th = 1/N * xcorr(BBG);
% figure
% plot(Rss_th);
% title('autocorr théorique');


%spectre de puissance:

Sss = 1/N * abs(fftshift(fft(BBG))).^2;
% figure
% plot(axef, Sss);
% title('spectre de puissance théorique');


%fonction autocorr estimée:

% [C_biased,~] =xcorr(BBG,'biased'); %estimateur biaisé
% figure
% plot(C_biased);
% title('Rss avec estimateur biaisé');
% [C_unbiased,~] =xcorr(BBG,'unbiased'); %estimateur non biaisé
% figure
% plot(C_unbiased);
% title('Rss avec estimateur non biaisé');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Fonction MATLAB Pwelch:


% figure;
% plot(pwelch(BBG));
% title('pwelch');


%Periodogramme de Daniell:

pas = 5;
l = length(Sss);

tab_moy = zeros(l);

for i=pas+1:l-pas
    sum = 0;
    for j=i-pas:i+pas
        sum = sum + Sss(j);
    end
    tab_moy(i) = sum/(2*pas + 1);
end

% figure;
% plot(axef, tab_moy);
% title('Daniell spectrogram');


% Periodogramme de Welch (marche pas):

nsegment = 50; %nombre de décompositions du signal
x = BBG;

segmentsize = ceil(length(x) / nsegment);
sumdsp= zeros(N,1);
for k=0:1:nsegment-1
   tmpfft = fftshift(fft(x([ k*segmentsize+1:(k+1)*segmentsize]),N));
   sumdsp = sumdsp + abs(tmpfft).^2;
end
avgDSP = sumdsp/ nsegment;

% figure
% plot(axef, avgDSP);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Préliminaire 2 :

RSB1 = 5;
RSB2 = 10;
RSB3 = 15;

sigf1 = bruit_avec_RSB(signal, RSB1);
sigf2 = bruit_avec_RSB(signal, RSB2);
sigf3 = bruit_avec_RSB(signal, RSB3);

%Affichage + spectrogramme du signal original:

figure,

subplot(2,1,1);
plot(axet,signal);
title('Représentation temporelle de s');

subplot(2,1,2);
spectrogram(signal);
title('Spectrogramme de s');

%Affichage signal bruité + spectrogramme:

figure,

subplot(2,1,1);
plot(axet,sigf1);
title('Représentation temporelle de s bruité');

subplot(2,1,2);
spectrogram(sigf1);
title('Spectrogramme de s bruité');



%Corrélogramme:
% library(corrplot)
% corrplot(BBG)