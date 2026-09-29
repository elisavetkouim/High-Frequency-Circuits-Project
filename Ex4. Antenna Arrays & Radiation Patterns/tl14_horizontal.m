I = 1;
f = 1e9;
vp = 3e8;

k = 2*pi*f/vp;
lambda = vp/f;
L = lambda/2;
r = 10000;   %farfield

d = lambda/4;

phi = pi/2;
theta1 = linspace(0, pi, 180);

E0 = 1j*60*I*(exp(-1j*k*r)/r) .* (cos(cos(theta)*pi/2) ./ sin(theta));

A1 = 0;

for i = 0:7
    A1 = A1 + exp(1j*k*i*d.*sin(theta1)*cos(phi));
end

E1 = E0 .* A1;

phi = 3*pi/2;
theta2 = linspace(-pi, 0, 180);

E0 = 1j*60*I*( exp(−1j*k*r) /r) .* ( cos(cos(theta2)*pi/2) ./ sin(theta2) );
A2 = 0;
for i = 0:7
A2 = A2 + exp(1j*k*i*d.*sin(theta2)*cos(phi));
end
E2 = E0 .* A2;
polarplot(theta1, abs(E1));
hold on;
polarplot(theta2, abs(E2));
title('Κατακόρυφο␣διάγραμμα␣ακτινοβολίας␣για␣dλ=/4');
hold off;
