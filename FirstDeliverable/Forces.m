% Force Magnitude at all pins

theta2 = (0:pi/100:2*pi)'; %angle of the AoA bar (radians)
AoA = 7; %mm, length of member 2
BoB = 20; %mm, length of member 5
BC = 100; %mm, length of member 4
AoBo = 45; %mm, length of member 1 (technically just the length between the two fixed points)
H = 102; %mm, height of system
omega2 = 1; %RPM, rotation of member 2 from motor
m6 = .45; %kg, mass of member 6
k = 175; %N/m, spring constant of spring
length_spring = 5; %mm, length of spring
rho = 1070; %kg/m^3, density of the plastic we are using to make the parts from
Ry = H-AoBo; %distance between point Ao and the line member 6 slides on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required functions to solve forces
Element2Values = Element2(theta2); %[rcm2ax rcm2ay vcm2ax vcm2ay acm2x acm2y]
[AC, theta4, theta5, rx] = positionMAT(theta2);
[AC_prime, omega4, omega5, rx_prime] = velocityMAT(AC, theta2, theta4, theta5);
[AC_dprime, alpha4, alpha5, rx_dprime] = accelerationMAT(AC, AC_prime, theta2, theta4, theta5, omega4, omega5);
Element6Values = Element6(rx, rx_prime, rx_dprime);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unknowns = 13;
col = unknowns;
n = length(Element2Values(6,:));
A = zeros (n,col);
b = zeros (col);

a6x = Element6Values(5,:);

for i = 1:length(Element2Values(1,:)) % Arbitrary length

% Element 2
R_Aox = 1; % Coeeficient Values
R_23x = -1;
R_Aoy = 1;
R_23y = -1;
M2 = 1;

A2x = [R_Aox,R_23x]; % A Matrix of Ax = b
A2y = [R_Aoy,R_23y];
A2m = [M2, AoA*sin(theta2(i))*R_23x,...
    AoA*cos(theta2(i))*R_23y]; % A Matrix of Ax = b for moment

b2x = 0; % B array of Ax = b
b2y = 0;
b2m = 0;

% Element 3
F_23x = 1;
R_43x = -1;
F_23y = 1;
R_43y = -1;

A3x = [F_23x,R_43x];
A3y = [F_23y,R_43y];

b3x = 0;
b3y = 0;

% Element 4 
F_43x = 1;
F_43y = 1;
R_64x = 1;
R_64y = -1;
R_bx = -1;
R_by = 1;

A4x = [F_43x, R_64x, R_bx];
A4y = [F_43y, R_64y, R_by];
A4m =   [(BC-AC(i))*sin(pi-theta4(i))*F_43x,...
        (BC-AC(i))*cos(pi-theta4(i))*F_43y,...
        BC*sin(pi-theta4(i))*(R_64x),...
        BC*cos(pi-theta4(i))*(R_64y)];

b4x = 0;
b4y = 0;
b4m = 0;

% Element 5
R_box = -1;
F_bx = 1;
R_boy = 1;
F_by = -1;

A5x = [R_box, F_bx];
A5y = [R_boy, F_by];
A5m = [-BoB*sin(theta5(i))*F_by, BoB*cos(theta5(i))*F_bx];

b5x = 0;
b5y = 0;
b5m = 0;

% Element 6
F_64x = -1;
F_k = 1;
F_64y = 1;
R_c = -1;

A6x = [F_k, F_64x];
A6y = [F_64y, R_c];

b6x = m6*a6x(i);
b6y = 0;

% Solve for Ax = b using A\b = x
A = [A2x, A2y, A2m, A3x, A3y, A4x, A4y, A4m,...
    A5x, A5y, A5m, A6x, A6y];

b = [b2x, b2y, b2m, b3x, b3y, b4x, b4y, b4m,...
    b5x, b5y, b5m, b6x, b6y];

x = linsolve(A,b);

end
