ry = 102 - 45;
rbo = 45;
r4 = 100;
r2 = 7;

theta2 = 0:(2*pi)/100:2*pi;

A1 = r2*cos(theta2);
A2 = r2*sin(theta2);

theta4 = pi/2:(280/360*pi - pi/2)/100:280*pi/360;

top = tan(theta4).*(ry - rbo - r4.*sin(theta4));
bottom = A1.*tan(theta4) + ry - A2;

theta5 = atan(top./bottom);

figure;
surf([theta2;theta4;theta5]);
xlabel('Theta2');
ylabel('Theta4');
zlabel('Theta5');

rx = ry./(tan(theta2) + tan(theta4));
figure;
surf([theta2;theta4;rx]);
xlabel('Theta2');
ylabel('Theta4');
zlabel('Rx');