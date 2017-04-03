function [] = calc_plot_forces_2(RAox, RAoy)

% Givens
theta2 = (0:pi/100:2*pi); %angle of the AoA bar (radians)
AoA = 7; %mm, length of member 2
BoB = 20; %mm, length of member 5
BC = 100; %mm, length of member 4
AoBo = 45; %mm, length of member 1 (technically just the length between the two fixed points)
H = 102; %mm, height of system
omega2 = 1; %RPM, rotation of member 2 from motor
m6 = .45; %kg, mass of member 6
k = 175; %N/m, spring constant of spring
k_mm = .175; %N/mm, spring constant
rho = 1070; %kg/m^3, density of the plastic we are using to make the parts from
Ry = H-AoBo; %distance between point Ao and the line member 6 slides on

% Meshgrid of Theta and X
x2 = linspace(0,AoA,length(RAox)); % position 'x' along beam
[X2,THETA2] = meshgrid(x2,theta2);
% Find Uniaxial Force in terms of length and Theta, shouldnt depend on
% length
for i = 1:length(theta2)
    for j = 1:length(x2)
        F_uniaxial(i,j) = -RAox(i)*cos(theta2(i)) - RAoy(i)*cos((pi/2)-theta2(i));
    end
end
surf(THETA2,X2,F_uniaxial)
end
