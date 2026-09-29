f0 = 5e9;
f = 0.1 : (2*f0/201) : (2*f0);
Z0=100;

Zin = zeros(size(f));
Pin = zeros(size(f));
P2 = zeros(size(f));
P3 = zeros(size(f));
P4 = zeros(size(f));
V22 = zeros(size(f));
V33 = zeros(size(f));
V44 = zeros(size(f));

for k = 1:length(f)
    betaL = 0.25*2*pi*f(k)/f0;
    
    A = [

        1, 0, 0, 0, 0, 0, -Z0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 1, 0, 0, 0, 0, 0, 0, 0, -Z0, 0, 0, 0, 0, 0;
        0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -Z0, 0, 0;
    
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, -1, 0, 0, 0;
        0, 0, 0, 0, 0, 0, 1, -1, 1, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 1;
        0, 0, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    
        -1, cos(betaL), 0, 0, 0, 0, 0, 0, 0, 0, 1j*Z0*sin(betaL), 0, 0, 0, 0;
        0, 1j*sin(betaL)/Z0, 0, 0, 0, 0, 0, 0, -1, 0, cos(betaL), 0, 0, 0, 0;
    
        0, cos(betaL), -1, 0, 0, 0, 0, 0, 0, 0, 0, 1j*Z0*sin(betaL)/sqrt(2), 0, 0, 0;
        0, 1j*sqrt(2)*sin(betaL)/Z0, 0, 0, 0, 0, 0, 0, 0, 0, 0, cos(betaL), 0, 0, -1;
    
        cos(betaL), 0, 0, 0, 0, 0, 0, 1j*Z0*sin(betaL)/sqrt(2), 0, 0, 0, 0, 0, 0, 0;
        1j*sqrt(2)*sin(betaL)/Z0, 0, 0, 0, -1, 0, 0, cos(betaL), 0, 0, 0, 0, 0, 0, 0;
    
        0, 0, cos(betaL), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1j*Z0, 0;
        0, 0, 1j*sin(betaL)/Z0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, cos(betaL), 0;    
    
    ];
    
    b = [
    
        0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 0; 1; 0;
    ];
    
    x = A \ b;
    
    V1 = 1;
    I1 = x(4);
    V2 = x(1);
    I2 = x(7);
    V3 = x(2);
    I3 = x(10);
    V4 = x(3);
    I4 = x(13);

    Zin(k) = V1 / I1;
    Pin(k) = 0.5*real(V1*conj(I1));
    P2(k) = 0.5*real(V2*conj(I2));
    P3(k) = 0.5*real(V3*conj(I3));
    P4(k) = 0.5*real(V4*conj(I4));
    V22(k) = V2;
    V33(k) = V3;
    V44(k) = V4;

    I11(k) = I1;
end

GammadB = 20*log10(abs((Zin - Z0)./(Zin + Z0)));
GammadB(GammadB < -70) = -70;

figure;
plot(f/1e9, GammadB);
xlabel('f (GHz)'); ylabel('|Γ| (dB)');
grid on;

figure;
plot(f/1e9, Pin); hold on;
plot(f/1e9, P2);
plot(f/1e9, P3);
plot(f/1e9, P4);
xlabel('f (GHz)'); ylabel('ισχύς σε κάθε θύρα');
grid on;
hold off;
legend ('Pin', 'P2', 'P3', 'P4');

figure;
subplot(1,2,1);
plot(f/1e9, abs(V22)); hold on;
plot(f/1e9, abs(V33));
plot(f/1e9, abs(V44));
xlabel('f (GHz)'); ylabel('μέτρο τάσης σε κάθε έξοδο');
grid on;
hold off;
legend('V2','V3','V4');

subplot(1,2,2);
plot(f/1e9, angle(V22)); hold on;
plot(f/1e9, angle(V33));
plot(f/1e9, angle(V44));
xlabel('f (GHz)'); ylabel('φάση τάσης σε κάθε έξοδο');
grid on;
hold off;
legend('V2','V3','V4');