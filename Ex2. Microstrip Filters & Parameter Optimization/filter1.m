function S = Filter1(p)
    
    Z01 = p(1);
    Z0s1 = p(2);
    Z0s2 = p(3);

    f0 = 1e9;
    Z0 = 50;

    f = 0.01e9 : 0.01e9 : 2e9;
    N = size(f,2); 
    betaL = 2*pi*(1/8)*f/f0; 

    
    Zstub1 = Z0s1 ./ (1j.*tan(betaL));
    ZA = (Z0.*Zstub1) ./ (Z0 + Zstub1);

    ZlineB = Z01 .* ((ZA+1j*Z01.*tan(betaL)) ./ (Z01+1j*ZA.*tan(betaL)));
    Zstub2 = Z0s2 ./ (1j.*tan(betaL));
    ZB = (ZlineB.*Zstub2) ./ (ZlineB + Zstub2);

    ZlineC = Z01 .* ((ZB+1j*Z01.*tan(betaL)) ./ (Z01+1j*ZB.*tan(betaL)));
    Zstub3 = Z0s1 ./ (1j.*tan(betaL));
    Zin = (ZlineC.*Zstub3) ./ (ZlineC + Zstub3);


    S11 = (Zin - Z0) ./ (Zin + Z0);
    S11dB = 20*log10(S11);
    S11_pass = abs(S11(1:(N/2)));
    S11_cutoff = abs(S11((N/2+1:N)));
    
    S = sum(S11_pass)/(N/2) + (1 - sum(S11_cutoff)/(N/2));  

end 


function S = plot_Filter1(p)
    
    Z01 = p(1);
    Z0s1 = p(2);
    Z0s2 = p(3);

    f0 = 1e9;
    Z0 = 50;

    f = 0.01e9 : 0.01e9 : 2e9;
    N = size(f,2); 
    betaL = 2*pi*(1/8)*f/f0; 

    
    Zstub1 = Z0s1 ./ (1j.*tan(betaL));
    ZA = (Z0.*Zstub1) ./ (Z0 + Zstub1);

    ZlineB = Z01 .* ((ZA+1j*Z01.*tan(betaL)) ./ (Z01+1j*ZA.*tan(betaL)));
    Zstub2 = Z0s2 ./ (1j.*tan(betaL));
    ZB = (ZlineB.*Zstub2) ./ (ZlineB + Zstub2);

    ZlineC = Z01 .* ((ZB+1j*Z01.*tan(betaL)) ./ (Z01+1j*ZB.*tan(betaL)));
    Zstub3 = Z0s1 ./ (1j.*tan(betaL));
    Zin = (ZlineC.*Zstub3) ./ (ZlineC + Zstub3);


    S11 = (Zin - Z0) ./ (Zin + Z0);
    S11dB = 20*log10(S11);
    S11_pass = abs(S11(1:(N/2)));
    S11_cutoff = abs(S11((N/2+1:N)));
    
 %   S = sum(S11_pass)/(N/2);

    S11dB(S11dB < -50) = -50;

    plot(f/1e9, S11dB);
    xlabel('f (GHz)'); ylabel('20 log_{10}S11 (dB)');
    title('S11 από 0 έως 2 GHz σε dB');
    grid on;

end

plot_Filter1(solution.p);