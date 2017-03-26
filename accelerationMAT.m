function [alpha4, alpha5, rx_dprime, lac_dprime] = accelerationMAT = (w4, w5)
% Known values of the system
r4 = 100; % BC
r5 = 20;  % BoB
ry =  57; % H - AoBo
theta2 = 0:(2*pi)/100:2*pi;
% AC_t = first derivative of AC
% Coefficient Matrix
A = [cos(theta4), -AC*sin(theta4), 0, -1;
    sin(theta4), AC*cos(theta2), 0, 0;
    0, -r4*sin(theta4), -r5*sin(theta5), -1;
    0 -r4*sin(theta4), -r5*sin(theta5), 0];
% RHS Coefficient Matrix
B = [AoA*w2^2*cos(theta2) + 2*AC_t*w4*sin(theta4) + AC*w4*(cos(theta4));
    AoA*w2^2*sin(theta2) - 2*AC_t*w4*cos(theta4) + AC*w4^2*(sin(theta4));
    w5^2*r5*cos(theta5) + w4^2*r4*cos(theta4);
    w5^2*r5*sin(theta5) + w4^2*r4*sin(theta4)];
% Solution Matrix, x
% x = AC_tt, a4, a5, Rx_tt
x = A/B;