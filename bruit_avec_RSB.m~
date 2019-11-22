function sigf = bruit_avec_RSB(sig0, RSB) %RSB en dB

l = length(sig0);
N = 500;
% m = 0;
% var = 1;


%bruit = m + var*randn(1,N);

P0=norm(sig0,2)^2/N; %puissance du signal original

ec=P0/(10^(RSB/10));

bruit=0.2*sqrt(ec)*randn(N,1);

sigf = sig0 + bruit;

end

