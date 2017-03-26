function [w4, w5, rx_prime, lac_prime] = velocityMAT = (AC, theta4, theta5,Rx)
% Known values of the system
r4 = 100; % BC
r5 = 20;  % BoB
ry =  57; % H - AoBo
theta2 = 0:(2*pi)/100:2*pi;
% Coefficient Matrix
A = [cos(theta4), -AC*sin(theta4), 0, -1;
    sin(theta4), AC*cos(theta4), 0, 0;
    0, -r4*sin(theta4), -r5*sin(theta5), -1
    0, r4*cos(theta4), r5*cos(theta5), 0];
% RHS Coefficient Matrix
B = [AoA*w2*sin(theta2);
    -AoA*w2*cos(theta2);
    0;
    0];
% Solution Matrix, x
% x = [AC', w4, w5, Rx']

x = A/B;