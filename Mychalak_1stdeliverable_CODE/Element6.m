function [output] = Element6(rx, rx_prime, rx_dprime)
% The original inputs were:
% (theta5,theta4,omega4,omega5,alpha4,alpha5)
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

% theta5 = 0; %?, find theta5
% theta4 = 0; %?, find theta4
% omega4 = 0; %?, find omega4
% omega5 = 0; %?, find omega5
% alpha4 = 0; %?, find alpha4
% alpha5 = 0; %?, find alpha5

% ----------------------------------------------------------- %
% ------------------------ READ ME! ------------------------- %
% ----------------------------------------------------------- %

% Rather than have all this stuff, which I (reed) had originally come up
% with, I have replaced it. The replacement is using the information from
% the RX, rx_prime and rx_dprime vectors. 

% rcx = BoB.*cos(theta5)+BC.*cos(theta4);
% rcy = BoB.*sin(theta5)+BC.*sin(theta4);
% 
% vcx = -BoB.*sin(theta5).*omega5-BC.*omega4.*sin(theta4);
% vcy = BoB.*cos(theta5).*omega5+BC.*omega4.*cos(theta4);
% 
% acx = -BoB.*(alpha5.*sin(theta5)-(omega5.^2).*cos(theta5))-BC.*(alpha4.*sin(theta4)+(omega4.^2).*cos(theta4));
% acy = BoB.*(alpha5.*cos(theta5)-(omega5.^2).*sin(theta5))-BC.*(alpha4.*cos(theta4)-(omega4.^2).*sin(theta4));

rcx = rx;

vcx = rx_prime;

acx = rx_dprime;

output = [rcx (H - AoBo)*ones(201,1) vcx zeros(201,1) acx zeros(201,1)];
% Original: rcx rcy vcx vcy acx acy
output = output';

end