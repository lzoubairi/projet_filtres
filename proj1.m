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
axet = 0:10/(N-1):10;
axef = -1/2:1/N:1/2-1/N;


%Bruit blanc gaussien

BBG = m + var*randn(1,N);
figure
plot(axet, BBG);
title('BBG');


%fonction autocorr théorique:

Rss_th = 1/N * xcorr(BBG);
figure
plot(Rss_th);
title('autocorr théorique');


%spectre de puissance:

Sss = 1/N * abs(fftshift(fft(BBG))).^2;
figure
plot(axef, Sss);
title('spectre de puissance théorique');


%fonction autocorr estimée:

[C_biased,~] =xcorr(BBG,'biased'); %estimateur biaisé
figure
plot(C_biased);
title('Rss avec estimateur biaisé');
[C_unbiased,~] =xcorr(BBG,'unbiased'); %estimateur non biaisé
figure
plot(C_unbiased);
title('Rss avec estimateur non biaisé');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

figure;
plot(tab_moy);
title('Daniell');

% Periodogramme de Welch:

nsegment = 50;
x = BBG;

segmentsize = ceil(length(x) / nsegment);
sumdsp= zeros(N,1);
for k=0:1:nsegment-1
   tmpfft = fftshift(fft(x([ k*segmentsize+1:(k+1)*segmentsize]),N));
   sumdsp = sumdsp + abs(tmpfft).^2;
end
avgDSP = sumdsp/ nsegment;

% figure
% plot(avgDSP);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Corrélogramme:
library(corrplot)
corrplot(BBG)