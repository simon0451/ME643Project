% This will beat sydneys slow preformance and I (reed) will plot graph 4
% faster
function [] = graph4(Element2Values,Element4Values, ...
    Element5Values,Element6Values, theta2)

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

% Element 2
a2_mag = sqrt(Element2Values(5,:).^2 + Element2Values(6,:).^2);
plot(theta2.*180./pi, a2_mag,'r')
hold on

% Element 4
a4_mag = sqrt(Element4Values(5,:).^2 + Element4Values(6,:).^2);
plot(theta2.*180./pi, a4_mag,'d')

% Element 5
a5_mag = sqrt(Element5Values(5,:).^2 + Element5Values(6,:).^2);
plot(theta2.*180./pi, a5_mag,'--')

% Element 6
a6_mag = sqrt(Element6Values(5,:).^2);
plot(theta2.*180./pi, a6_mag,'m:')
axis([0 360 0 10])
legend('location','best','Member 2 (A_oA)','Member 4 (BC)','Member 5 (B_oB)', ...
    'Member 6 (C)')
