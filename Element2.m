function [output] = Element2(theta2)
%this function outputs position (r), velocity (v), acceleration(a)
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

rcm2ax = .5.*AoA.*cos(theta2);
rcm2ay = .5.*AoA.*sin(theta2);

vcm2ax = -.5.*sin(theta2)*omega2;
vcm2ay = .5.*cos(theta2)*omega2;

acm2x = -.5.*AoA.*(omega2.^2).*cos(theta2);
acm2y = -.5.*AoA.*(omega2.^2).*sin(theta2);

output = [rcm2ax; rcm2ay; vcm2ax; vcm2ay; acm2x; acm2y;];
output = output';



end