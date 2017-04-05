function [AC_dprime, alpha4, alpha5, rx_dprime] = accelerationMAT(AC, AC_t, theta2, theta4, theta5, w4, w5)
% Known values of the system
% AC_t is AC_prime
r4 = 100; % BC
r5 = 20;  % BoB
w2 = 1;
AoA = 7;
for i = 1:length(theta2)
    % AC_t = first derivative of AC
    % Coefficient Matrix
    A = [cos(theta4(i)), -AC(i)*sin(theta4(i)), 0, 1;
        sin(theta4(i)), AC(i)*cos(theta4(i)), 0, 0;
        0, -r4*sin(theta4(i)), -r5*sin(theta5(i)), -1;
        0, r4*cos(theta4(i)), r5*cos(theta5(i)), 0];
    % RHS Coefficient Matrix
    B = [AoA*w2^2*cos(theta2(i)) + 2*AC_t(i)*w4(i)*sin(theta4(i)) + AC(i)*w4(i)^2*(cos(theta4(i)));
        AoA*w2^2*sin(theta2(i)) - 2*AC_t(i)*w4(i)*cos(theta4(i)) + AC(i)*w4(i)^2*(sin(theta4(i)));
        w5(i)^2*r5*cos(theta5(i)) + w4(i)^2*r4*cos(theta4(i));
        w5(i)^2*r5*sin(theta5(i)) + w4(i)^2*r4*sin(theta4(i))];
    % Solution Matrix, x
    % x = AC_tt, a4, a5, Rx_tt
    x(i,:) = linsolve(A,B);
%     x(i,:) = A\B;
end
AC_dprime = x(:,1);
alpha4 = x(:,2);
alpha5 = x(:,3);
rx_dprime = x(:,4);
end