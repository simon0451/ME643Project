function F=eSolve(x)
%Equation solver - solves systems of non-linear equations

theta2 = 0; %angle of the AoA bar (radians)
AoA = 7; %mm, length of member 2
BoB = 20; %mm, length of member 5
BC = 100; %mm, length of member 4
AoBo = 45; %mm, length of member 1 (technically just the length between the two fixed points)
H = 102; %mm, height of system
omega = 1; %RPM, rotation of member 2 from motor
m = .45; %kg, mass of member 6
k = 175; %N/m, spring constant of spring
rho = 1070; %kg/m^3, density of the plastic we are using to make the parts from
Ry = H-AoBo; %distance between point Ao and the line member 6 slides on

F = [AoA*cos(theta2)+x(1)*cos(x(2))-x(4);
    AoA*sin(theta2)+x(1)*sin(x(2))-Ry;
    BoB*cos(x(3))+BC*cos(x(2))-x(4);
    AoBo+BoB*sin(x(3))+BC*sin(x(2))-Ry;];
end