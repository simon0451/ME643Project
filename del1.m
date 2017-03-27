%% HEADER
%Machine Design project
%25 March 2017

%% Given information
theta2 = (0:pi/100:2*pi)'; %angle of the AoA bar (radians)
AoA = 7; %mm, length of member 2
BoB = 20; %mm, length of member 5
BC = 100; %mm, length of member 4
AoBo = 45; %mm, length of member 1 (technically just the length between the two fixed points)
H = 102; %mm, height of system
omega2 = 1; %RPM, rotation of member 2 from motor
m = .45; %kg, mass of member 6
k = 175; %N/m, spring constant of spring
rho = 1070; %kg/m^3, density of the plastic we are using to make the parts from
ry = H-AoBo; %distance between point Ao and the line member 6 slides on

%% Solving for Position, Velocity, and Acceleration
% POSITION
[AC, theta4, theta5, rx] = positionMAT(theta2);

figure;
plot(theta2,theta4,theta2,theta5)
axis([0 2*pi 0 2*pi])
legend('Theta4','Theta5')
xlabel('Theta2')
%%
% VELOCITY
[AC_prime, omega4, omega5, rx_prime] = velocityMAT(AC, theta2, theta4, theta5);
% check accuracy by plotting rx and its derivative
figure;
plot(theta2, rx,'b',theta2, rx_prime,'g')
grid on

% ACCELERATION
[AC_dprime, alpha4, alpha5, rx_dprime] = accelerationMAT(AC, AC_prime, theta2, theta4, theta5, omega4, omega5);
<<<<<<< HEAD
figure;
plot(theta2, rx_prime,'b', theta2, rx_dprime, 'g')
=======

plot(theta2, rx_prime,'b', theta2, rx_dprime, 'm')
>>>>>>> c83ef81b3ad3838571aec002d76da011770d23fb
grid on


%% Solving Equations of Motion

%theta2 = 0:(2*pi)/100:(2*pi); % a random range of thetas to test the function

%Element 2
Element2Values = Element2(theta2); %[rcm2ax rcm2ay vcm2ax vcm2ay acm2x acm2y]

%Element 3
Element3Values = Element3(theta2); %[rax ray vax vay aax aay]

%Element 4
%requires theta4, omega4, and alpha4 to run - code exists otherwise
Element4Values = Element4(theta2,theta4,omega4,alpha4); %[rcm4x rcm4y vcm4x vcm4y acm4x acm4y]

%Element 5
%requries thetaa5, omega5, and alpha5 to run - code exists otherwise
Element5Values = Element5(theta5,omega5,alpha5);

%Element 6
%requires theta5, theta4, omega5, omega4, alpha5, and alpha4 to run,
%otherwise ready to go
<<<<<<< HEAD
Element6Values = Element6(theta5,theta4,omega4,omega5,alpha4,alpha5);

figure;
plot(Element2Values(1,:),Element2Values(2,:));
hold on;
plot(Element3Values(1,:),Element3Values(2,:));
plot(Element4Values(1,:),Element4Values(2,:));
plot(Element5Values(1,:),Element5Values(2,:));
plot(Element6Values(1,:),Element6Values(2,:));
=======


plot(Element2Values(1,:), Element2Values(2,:) ,Element3Values(1,:),Element3Values(2,:))
>>>>>>> c83ef81b3ad3838571aec002d76da011770d23fb
title('Position (mm)')
xlabel('X Displacement (mm)')
ylabel('Y Displacement (mm)')
legend('Element 2','Element 3','Element 4','Element 5','Element 6');
ylim([-8 106]);
xlim([-70 44]);
