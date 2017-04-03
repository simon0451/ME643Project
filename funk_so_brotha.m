function [mag5_range, mag3_range, mag2_range, mag4_range, mag1_range, M2,...
    R23x,R23y,RAoy,RAox,R43,RBy,RBx,R64y,R64x,RBox,RBoy,RC]...
    = funk_so_brotha(theta2, theta4, theta5, AoA, BoB, ...
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
% % Use the function plot_vs_crank to plot the force comparision! GET EM'
% 
% plot_vs_crank(theta2, RAox, RAoy) % AoA
% if 
mag1 = sqrt(RAox.^2 + RAoy.^2);
mag1_range = get_that_out(mag1);
% plot(theta2, mag1,'o')
% hold on
% % plot_vs_crank(theta2, RBox, RBoy)   % Bo
mag2 = sqrt(RBox.^2 + RBoy.^2);
mag2_range = get_that_out(mag2);
% plot(theta2, mag2)
% % plot_vs_crank(theta2, RBx, RBy)     % B
mag3 = sqrt(RBx.^2 + RBy.^2);
mag3_range = get_that_out(mag3);
% plot(theta2, mag3,'d')
% % plot_vs_crank(theta2, R23x, R23y)   % A
mag4 = sqrt(R23x.^2 + R23y.^2);
mag4_range = get_that_out(mag4);
% plot(theta2, mag4)
% % plot_vs_crank(theta2, R64x, R64y)   % C
mag5 = sqrt(R64x.^2 + R64y.^2);
mag5_range = get_that_out(mag5);
% plot(theta2, mag5)
% legend('Location','best')


% Crank angle from 0-360 deg (0 to 2pi)
ca = linspace(0,2*pi,length(Element6Values));

plot(ca,mag1,'-',ca,mag4,'o',ca,mag3,'-',ca,mag2,'d',ca,mag5,'-')
xlabel('Crank Angle')
ylabel('Force (N)')
title('Magnitude of Reaction Forces in Joints')
set(gca,'xtick',[0 pi/2 pi 3*pi/2 2*pi])
set(gca,'xticklabel',{'0';'2/\pi';'\pi';'3\pi/2';'2\pi'})
xlim([0 2*pi])
legend('location','northwest','A_o','A',...
'B','B_o','C')