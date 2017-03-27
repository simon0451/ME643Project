function [output] = Element4(theta2,theta4,omega4,alpha4)
%this funciton outputs position (r), velocity (v), acceleration(a)
%givens:
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

% theta4 = 0; %???????? find theta4 in terms of something we know
% omega4 = 0; %????????? find omega4 in terms of something we know
% alpha4 = 0; %?? find alpha4 in terms of something we know

rcm4x = AoA.*cos(theta2)+.5.*BC.*cos(theta4);
rcm4y = AoA.*sin(theta2)+.5.*BC.*sin(theta4);

vcm4x = -AoA.*omega2.*sin(theta2)-.5.*BC.*sin(theta4).*omega4;
vcm4y = AoA.*omega2.*cos(theta2)+.5.*BC.*cos(theta4).*omega4;

acm4x = -AoA.*(omega2.^2).*cos(theta2)-.5.*BC.*(alpha4.*cos(theta4)+(omega4.^2).*cos(theta4));
acm4y = -AoA.*(omega2.^2).*sin(theta2)+.5.*BC.*(alpha4.*sin(theta4)-(omega4.^2).*sin(theta4));

output = [rcm4x rcm4y vcm4x vcm4y acm4x acm4y];
output = output';


end