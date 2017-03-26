%% HEADER
%Machine Design project
%25 March 2017

%% Given information
theta2 = 0; %angle of the AoA bar (radians)
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

%% Solving Equations of Motion

theta2 = 0:(2*pi)/100:(2*pi); % a random range of thetas to test the function

%Element 2
Element2Values = Element2(theta2); %[rcm2ax rcm2ay vcm2ax vcm2ay acm2x acm2y]

%Element 3
Element3Values = Element3(theta2); %[rax ray vax vay aax aay]

%Element 4
%requires theta4, omega4, and alpha4 to run - code exists otherwise

%Element 5
%requries thetaa5, omega5, and alpha5 to run - code exists otherwise

%Element 6
%requires theta5, theta4, omega5, omega4, alpha5, and alpha4 to run,
%otherwise ready to go


plot(Element2Values(:,1),Element2Values(:,2),Element3Values(:,1),Element3Values(:,2))
title('Position (mm)')
xlabel('X Displacement (mm)')
ylabel('Y Displacement (mm)')



