vp = 3e8;
f0 = 1e9;
N = 201;

f = 0 : (2*f0/N) : (2*f0) ;

betaL = @(length) (length)*2*pi.*(f/f0);

L1 = 0.2;
% for the not minimum, but next possible lengths of L2 & Lstub we change them
L2 = 0.091;     % L2 = 0.448
Lstub = 0.159;  % Lstub = 0.34

RL = 100;
CL = 2e-12;
C = 2.7e-12;
Z0 = 50;

XL = 1./(2*pi.*f*CL);
ZL = RL -1j.*XL;

% resistance before parallel capacitor
Z1 = Z0 .* ((ZL + 1j*Z0*tan(betaL(L1))) ./ (Z0 + 1j*ZL.*tan(betaL(L1))) );

Y1 = 1 ./ Z1;

% parallel capacitor
YC = 1j*2*pi.*f*C;

YA = Y1 + YC;
ZA = 1 ./ YA;

% resistance before stub
Zin1 = Z0 .* ((ZA + 1j*Z0*tan(betaL(L2))) ./ (Z0 + 1j*ZA.*tan(betaL(L2))) );
Yin1 = 1 ./ Zin1;

% stub
Zstub = Z0 ./ (1j*tan(betaL(Lstub)));
Ystub = 1 ./ Zstub;

Yin = Yin1 + Ystub;
Zin = 1 ./ Yin;

Gamma = abs((Zin - Z0)./(Zin + Z0));
Gammadb = 20*log10(Gamma);

figure;
subplot(2,1,1);
plot(f/1e9, Gamma);
xlabel('f (GHz)'); ylabel('|Γ|');
title('|Γ(f)| από 0 έως 2 GHz');
grid on;

subplot(2,1,2);
plot(f/1e9, Gammadb);
xlabel('f (GHz)'); ylabel('20 log_{10}|Γ| (dB)');
title('|Γ(f)| από 0 έως 2 GHz σε dB');
grid on;
