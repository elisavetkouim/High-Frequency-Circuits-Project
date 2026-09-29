I = 1;
f = 1e9; 
vp = 3e8; 
k = 2*pi*f/vp;
lambda = vp/f;
r = 10000; % far field
hx = sqrt(2)*lambda/4;
hy = 5*sqrt(2)*lambda/4;

theta = linspace(0, pi, 180);
phi = linspace(0, pi/2, 360);
[THETA, PHI] = meshgrid(theta, phi);


E0 = 1j*60*I*( exp(-1j*k*r) /r) .* ( cos(cos(THETA)*pi/2) ./ sin(THETA) );

A = exp(1j*k*(hx.*cos(PHI)+hy.*sin(PHI)).*sin(THETA))-exp(1j*k*(-hx.*cos(PHI)+hy.*sin(PHI)).*sin(THETA))+exp(1j*k*(-hx.*cos(PHI)-hy.*sin(PHI)).*sin(THETA))-exp(1j*k*(hx.*cos(PHI)-hy.*sin(PHI)).*sin(THETA));




E = E0 .* A;


X = abs(E) .* sin(THETA) .* cos(PHI);
Y = abs(E) .* sin(THETA) .* sin(PHI);
Z = abs(E) .* cos(THETA);

figure;
surf(X, Y, Z, abs(E), 'FaceColor', 'interp', 'EdgeColor', 'none');
colormap('jet');
colorbar;
title('3D radiation pattern d=3λ/4');
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;
view(45,30);
lighting gouraud;
camlight('headlight');