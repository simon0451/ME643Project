function [output] = Element5(theta5,omega5,alpha5)
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

% theta5 = 0; %? find theta5 in terms of things we know
% omega5 = 0; %? find omega5 in terms of something that we know
% alpha5 = 0; %?, find alpha5 in terms of something that we already know

rbobx = .5.*BoB*cos(theta5);
rboby = .5.*BoB.*sin(theta5);

vbobx = -.5.*BoB.*sin(theta5).*omega5;
vboby = .5.*BoB.*cos(theta5).*omega5;

abobx = .5.*BoB.*(-alpha5.*sin(theta5)-(omega5.^2).*(cos(theta5)));
aboby = .5.*BoB.*(alpha5.*cos(theta5)-(omega5.^2).*(sin(theta5)));

output = [rbobx rboby vbobx vboby abobx aboby];
output = output';

end