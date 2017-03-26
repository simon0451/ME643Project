function F=position_fs(x,a)
% Find the position values
AoA = 7; %mm
theta2 = a; %radians
Ry = 102 - 45; %mm
BoB = 20; %mm  r5
BC = 100; %mm  r4
AoBo = 45;  %mm

F = [AoA*cos(theta2) + x(1)*cos(x(2)) + x(4);
    AoA*sin(theta2) + x(1)*sin(x(2)) - Ry;
    BoB*cos(x(3)) + BC*cos(x(2)) + x(4);
    -AoBo + BoB*sin(x(3)) + BC*sin(x(2)) - Ry;];

end
