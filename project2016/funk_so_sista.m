function [R23x,  R23y,  RAoy,  RAox,  M2,  R43,  RBy,  RBx,  R64y,  R64x,  RBox,  RBoy,  RC] = funk_so_sista(theta2, theta4, theta5, AoA, BoB, ...
BC, AC, Element6Values,rx)
% The Function Fix
% The coefficeint matrix
m = 0.45;
k = 175;
diam = 10;  % 10 mm
mAoA = pi*diam^2/4*AoA;
mBoB = pi*diam^2/4*BoB;
mBC = pi*diam^2/4*BC;

accel = Element6Values;
for j = 1:length(AC)
    theta_str = theta4(j) - (pi/2);
    AB = 100 - AC(j);
    a = accel(j);
    Fk = k.*rx(j);
    A = [0, -1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
        -1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
        AoA*sin(theta2(j)), -AoA*cos(theta2(j)), 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 1, 0, 0, 0, -sin(theta_str), 0, 0, 0, 0, 0, 0, 0;
        1, 0, 0, 0, 0, -cos(theta_str), 0, 0, 0, 0, 0, 0, 0, ;
        0, 0, 0, 0, 0, sin(theta_str), -1, 0, -1, 0, 0, 0, 0;
        0, 0, 0, 0, 0, cos(theta_str), 0, -1, 0, 1, 0, 0, 0;
        0, 0, 0, 0, 0, -AB, 0, 0, BC*cos(pi - theta4(j)), -BC*sin(pi - theta4(j)), 0, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 0;
        0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0;
        0, 0, 0, 0, 0, 0, BoB*cos(theta5(j)), -BoB*sin(theta5(j)), 0, 0, 0, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, -1;
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0];

    B = [0;0;0;0;0;0;0;0;0;0;0;0;(Fk/1000 - m*a)];

% The unknown matrix. In the following order:
% R23x  R23y  RAoy  RAox  M2  R43  RBy  Rbx  R64y  R64x  RBox  RBoy  RC
    WHATS_GOOD(j,:) = linsolve(A,B);
end
R23x = WHATS_GOOD(:,1);
R23y = WHATS_GOOD(:,2);
RAoy = WHATS_GOOD(:,3);
RAox = WHATS_GOOD(:,4);
M2 = WHATS_GOOD(:,5);
R43 = WHATS_GOOD(:,6);
RBy = WHATS_GOOD(:,7);
RBx = WHATS_GOOD(:,8);
R64y = WHATS_GOOD(:,9);
R64x = WHATS_GOOD(:,10);
RBox = WHATS_GOOD(:,11);
RBoy = WHATS_GOOD(:,12);
RC = WHATS_GOOD(:,13);
