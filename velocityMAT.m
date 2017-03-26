function [AC_prime, omega4, omega5, rx_prime] = velocityMAT(AC, theta2, theta4, theta5)
% Known values of the system
r4 = 100; % BC
r5 = 20;  % BoB
w2 = 1; % omega2
AoA = 7; %mm, length of member 2
%x = zeros(2,2);
for i = 1:length(theta2)
    % Coefficient Matrix
    A = [cos(theta4(i)), -AC(i)*sin(theta4(i)), 0, 1;
        sin(theta4(i)), AC(i)*cos(theta4(i)), 0, 0;
        0, -r4*sin(theta4(i)), -r5*sin(theta5(i)), 1;
        0, r4*cos(theta4(i)), r5*cos(theta5(i)), 0];
    % RHS Coefficient Matrix
    B = [AoA*w2*sin(theta2(i));
        -AoA*w2*cos(theta2(i));
        0;
        0];
    % Solution Matrix, x
    % x = [AC', w4, w5, Rx']
    x(i,:) = linsolve(A,B);
end
AC_prime = x(:,1);
omega4 = x(:,2);
omega5 = x(:,3);
rx_prime = x(:,4);
end

