% Graph 3, part d.
function [] = graph3(Element6Values, theta2)

AoA = 7; %mm, length of member 2
BoB = 20; %mm, length of member 5
BC = 100; %mm, length of member 4
AoBo = 45; %mm, length of member 1 (technically just the length between the two fixed points)
H = 102; %mm, height of system
omega2 = 1; %RPM, rotation of member 2 from motor
m = .45; %kg, mass of member 6
k = 175; %N/m, spring constant of spring
rho = 1070; %kg/m^3, density of the plastic we are using to make the parts from
Ry = H-AoBo; %distance between point Ao and the line member 6 slides on

theta2_deg = theta2*180/pi;
plot(theta2_deg, Element6Values(3,:),'linewidth',2)
xlabel('Crank Angle, 0^o - 360^o')
ylabel('Linear Velocity (m/s)')
title('x-Component of the Linear Velocity of Point C')
axis([0 360 -25 25])
grid on