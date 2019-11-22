clear
close all
clc

%% Préliminaire 1:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = load("fcno04fz.mat");
signal = s.fcno04fz; %57344x1

N = 500;
m = 0;
sigma = 1;
var = sigma^2;
tps = 0:10/(N-1):10;


%Bruit blanc gaussien
BBG = m + var*randn(1,N);
figure
plot(tps, BBG);
title('BBG');


%fonction autocorr théorique:
Rss_th = 1/N * xcorr(BBG);
figure
plot(Rss_th);
title('autocorr théorique');


%spectre de puissance:
Sss = 1/N * abs(fftshift(fft(BBG))).^2;
figure
plot(Sss);
title('spectre de puissance théorique');


%fonction autocorr estimée:
[C_biased,LAGS1] =xcorr(BBG,'biased'); %estimateur biaisé
figure
plot(C_biased);
title('Sss avec estimateur biaisé');
[C_unbiased,LAGS2] =xcorr(BBG,'unbiased'); %estimateur non biaisé
figure
plot(C_unbiased);
title('Sss avec estimateur non biaisé');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




