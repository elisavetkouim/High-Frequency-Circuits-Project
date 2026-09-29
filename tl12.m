Z01 = 101.6;
Z0s1 = 98.45;
Z0s2 = 43.6;

f0 = 1e9;
Z0 = 50;

f = 0.01e9 : 0.01e9 : 2e9;
betaL = 2*pi*(1/8)*f/f0; 

Zstub1 = Z0s1 ./ (1j.*tan(betaL));
ZA = (Z0.*Zstub1) ./ (Z0 + Zstub1);

ZlineB = Z01 .* ((ZA+1j*Z01.*tan(betaL)) ./ (Z01+1j*ZA.*tan(betaL)));
Zstub2 = Z0s2 ./ (1j.*tan(betaL));
ZB = (ZlineB.*Zstub2) ./ (ZlineB + Zstub2);

ZlineC = Z01 .* ((ZB+1j*Z01.*tan(betaL)) ./ (Z01+1j*ZB.*tan(betaL)));
Zstub3 = Z0s1 ./ (1j.*tan(betaL));
Zin = (ZlineC.*Zstub3) ./ (ZlineC + Zstub3);

Gammadb = 20*log10(abs((Zin - Z0)./(Zin + Z0)));
Gammadb(Gammadb < -50) = -50;

plot(f/1e9, Gammadb);
xlabel('f (GHz)'); ylabel('20 log_{10}|Γ| (dB)');
title('|Γ(f)| από 0 έως 2 GHz σε dB');
grid on;