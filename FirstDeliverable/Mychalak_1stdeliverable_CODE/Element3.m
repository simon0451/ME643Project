function [output] = Element3(theta2)
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

rax = AoA.*cos(theta2);
ray = AoA.*sin(theta2);

vax = -1.*(AoA.*sin(theta2).*omega2);
vay = AoA.*cos(theta2).*omega2;

aax = -1.*(AoA.*(omega2.^2).*cos(theta2));
aay = -1*(AoA.*(omega2.^2).*sin(theta2));


output = [rax ray vax vay aax aay];
output = output';
end