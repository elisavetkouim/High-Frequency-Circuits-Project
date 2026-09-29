I = 1;
f = 1e9;
vp = 3e8;
eta0 = 120*pi;

k = 2*pi*f/vp;
lambda = vp/f;
L = lambda/2;
r = 10000; %far field
d = 3*lambda/4;

theta = linspace(0.001, pi, 180);
phi = linspace(0, 2*pi, 360);
[Theta, Phi] = meshgrid(theta, phi);

E0 = 1j*60*I*( exp(-1j*k*r) /r).* ( cos(cos(Theta)*pi/2) ./ sin(Theta) );

A = 0;
for i = 0:7
    A = A + exp(1j*k*i*d.*sin(Theta).*cos(Phi));
end

E = E0 .* A;

Pr = (abs(E).^2) / (2*eta0);

dtheta = theta(2)-theta(1);
dphi = phi(2)-phi(1);
Wr = 0;
for m = 1:360
    for n = 1:180
        Wr = Wr + Pr(m,n)*(r^2)*sin(theta(n))*dtheta*dphi;
    end
end

Prmax = max(Pr(:));

D = (4*pi*r^2)*Prmax / Wr;