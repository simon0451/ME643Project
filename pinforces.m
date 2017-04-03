function [R_C, R_B, R_Bo, R_A, R_Ao, M2] = pinforces(a6x,rx,theta2,theta4,theta5,AC)

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
k_mm = .175; %N/mm, spring constant
rho = 1070; %kg/m^3, density of the plastic we are using to make the parts from
Ry = H-AoBo; %distance between point Ao and the line member 6 slides on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required functions to solve forces
% Element2Values = Element2(theta2); %[rcm2ax rcm2ay vcm2ax vcm2ay acm2x acm2y]
% [AC, theta4, theta5, rx] = positionMAT(theta2);
% [AC_prime, omega4, omega5, rx_prime] = velocityMAT(AC, theta2, theta4, theta5);
% [AC_dprime, alpha4, alpha5, rx_dprime] = accelerationMAT(AC, AC_prime, theta2, theta4, theta5, omega4, omega5);
% Element6Values = Element6(rx, rx_prime, rx_dprime);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unknowns = 13;
equations = 13;
col = unknowns;
rows = equations;

A = zeros (rows,col);
b = zeros (col);

%a6x = Element6Values(5,:);

for i = 1:length(a6x) % Arbitrary length

% Element 2
R_Aox = 1; % Coeeficient Values
R_23x = -1;
R_Aoy = 1;
R_23y = -1;
M2 = 1;

A2x = [R_Aox,R_23x]; % (A) Matrix of (A)x = b
A2y = [R_Aoy,R_23y];
A2m = [M2, AoA*sin(theta2(i))*R_23x,...
    AoA*cos(theta2(i))*R_23y]; % (A) Matrix of (A)x = b for moment

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

%b6x(i) = -m6*a6x(i)+F_k1(i);
b6y = 0;

% A1 = [R_Aox,0,0,0,0,0,0,0,0,0,0,0,0];
% A2 = [0,R_Aoy,0,0,0,0,0,0,0,0,0,0,0];
% A3 = [0,0,M2,0,0,0,0,0,0,0,0,0,0];
% A4 = [0,0,0,F_23x,0,0,0,0,0,0,0,0,0];
% A5 = [0,0,0,0,F_23y,0,0,0,0,0,0,0,0];
% A6 = [0,0,0,0,0,R_64x,0,0,0,0,0,0,0];
% A7 = [0,0,0,0,0,0,R_bx,0,0,0,0,0,0];
% A8 = [0,0,0,0,0,0,0,R_64y,0,0,0,0,0];
% A9 = [0,0,0,0,0,0,0,0,R_by,0,0,0,0];
% A10 = [0,0,0,0,0,0,0,0,0,R_box,0,0,0];
% A11 = [0,0,0,0,0,0,0,0,0,0,R_boy,0,0];
% A12 = [0,0,0,0,0,0,0,0,0,0,0,F_64x,0];
% A13 = [0,0,0,0,0,0,0,0,0,0,0,0,F_64y];

% Solve for Ax = b using A\b = x
% A = [A2x, A2y, A2m, A3x, A3y, A4x, A4y, A4m,...
%     A5x, A5y, A5m, A6x, A6y];
% A = [A1; A2; A3; A4; A5; A6; A7; A8;...
%      A9; A10; A11; A12; A13];
% 
% b = [b2x; b2y; b2m; b3x; b3y; b4x; b4y; b4m;...
%     b5x; b5y; b5m; b6x; b6y];
% 
% x(i,:) = linsolve(A,b);

F_k1(i) = rx(i)*k_mm;

F_64x(i) = -m6*a6x(i)+F_k1(i);

F_64(i) = F_64x(i)/cos(theta4(i));

R_C(i) = -F_64(i)*sin(theta4(i));

F_43(i) = BC*R_C(i)/(BC-AC(i));

R_B(i) = F_43(i)-R_C(i);

R_Bo(i) = -R_B(i);

F_23(i) = F_43(i);

R_A(i) = F_23(i);

R_Ao(i) = -R_A(i);

M2(i) = -AoA*sin(theta2(i))*R_A(i)*sin(theta2(i))...
    +AoA*cos(theta2(i))*R_A(i)*cos(theta2(i));

end

% Crank angle from 0-360 deg (0 to 2pi)
ca = linspace(0,2*pi,length(a6x));

plot(ca,R_Ao,'-',ca,R_A,'-',ca,R_B,'-',ca,R_Bo,'-',ca,R_C,'-')
xlabel('Crank Angle')
ylabel('Force (N)')
title('Reaction Forces in Joints')
set(gca,'xtick',[0 pi/2 pi 3*pi/2 2*pi])
set(gca,'xticklabel',{'0';'2/\pi';'\pi';'3\pi/2';'2\pi'})
xlim([0 2*pi])
legend('location','northwest','F_{R_{Ao}}','F_{R_A}',...
'F_{R_B}','F_{R_{Bo}}','F_{R_C}')



end


