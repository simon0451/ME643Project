function [axialF,shearF,moment,x2,x4,x5] = AVMcalc(F_RC,F_RB,F_RBo,F_RA,F_RAo,M2,...
    a6x,rx,theta2,theta4,theta5,AC,...
    R23x,R23y,RAoy,RAox,R43,RBy,RBx,R64y,R64x,RBox,RBoy,RC)

% Calculates shear force, axial force, and bending moment for all parts

% Givens
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

%% Part 2

% xh = [x2;x4;x5]; %this is a placeholder vector representing the length of the members 2, 4, and 5 (seperate plots)
% yh = [theta2';theta4';theta5']; %this is a placeholder vector representing the 
%[xxh,yyh] = meshgrid(xh(i,:),yh(i,:));

x2 = linspace(0,AoA,length(F_RAo)); % position 'x' along beam
[X2,THETA2] = meshgrid(x2,theta2);

for i=1:length(x2)
    for j=1:length(theta2)
        A2(j,i) = -R23x(j)*cos(theta2(j)+pi/2) - R23y(j)*cos(pi/2-theta2(j)+pi/2); % Axial force from mid to pin A (end) of beam
    end
end
A2_max = max(max(A2));
A2_min = min(min(A2))
figure
surf(X2,THETA2.*180./pi,A2,'edgecolor','none')
title('Axial Force Member 2')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Axial Force (N)')
axis([0 8 0 360 -10 30])
for i=1:length(x2)
    for j=1:length(theta2)
        V2(i,j) = -R23x(i)*sin(theta2(i)) - R23y(i)*sin(pi/2-theta2(i)); % Axial force from mid to pin A (end) of beam
    end
end
V2_max = max(max(V2));
V2_min = min(min(V2))
figure
surf(X2,THETA2.*180./pi,V2,'edgecolor','none')
title('Shear Force Member 2')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Shear Force (N)')
axis([0 8 0 360 -30 10])

for i=1:length(x2)
    for j=1:length(theta2)
        Mom2(j,i) = -(-R23x(j)*sin(theta2(j)) + R23y(j)*sin(pi/2-theta2(j)))*x2(i)+M2(j); % Axial force from mid to pin A (end) of beam
 
    end
end
Mom2_max = max(max(Mom2));
Mom2_min = min(min(Mom2))

figure
surf(X2,THETA2.*180./pi,Mom2,'edgecolor','none')
title('Bending Moment of Member 2')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Bending Moment (N-mm)')
axis([0 8 0 360 -150 150])

%% Part 4

x4 = linspace(0,BC,length(F_RBo)); % position 'x' along beam
[X4,THETA4] = meshgrid(x4,theta4);

for i=1:length(x4)
    for j=1:length(theta4)
        A4(j,i) = -R64y(j)*cos(theta4(j)-pi/2) - R64x(j)*cos(pi-theta4(j)); % Axial force from mid to pin A (end) of beam
    end
end
A4_max = max(max(A4));
A4_min = min(min(A4))

figure
surf(X4,THETA2.*180./pi,A4,'edgecolor','none')
title('Axial Force Member 4')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Axial Force (N)')
axis([0 100 0 360 -10 2])

for i=1:length(x4)
    for j=1:length(theta4) 
       if x4(i) > (BC-AC(i))
           
            V4(j,i) = -RBx(j)*sin(pi-theta4(j))+RBy(j)*sin(theta4(j)-pi/2)+R43(j); % Shear force
       end
    
       if x4(i) < (BC-AC(i))
           V4(j,i) = -RBx(j)*sin(pi-theta4(j))+RBy(j)*sin(theta4(j)-pi/2); % Shear force
       end
    end
end
V4_max = max(max(V4));
V4_min = min(min(V4))

figure
surf(X4,THETA2.*180./pi,V4,'edgecolor','none')
title('Shear Force Member 4')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Shear Force (N)')
axis([0 100 0 360 -30 10])

for i=1:length(x2)
    for j=1:length(theta4) 
        
       if x4(i) < (BC-AC(i))
           Mom4(j,i) = (-RBx(j)*sin(pi-theta4(j))+RBy(j)*sin(theta4(j)-pi/2))*x4(i);
       end        
        
       if x4(i) >= (BC-AC(i))
            Mom4(j,i) = (-RBx(j)*sin(pi-theta4(j))+RBy(j)*sin(theta4(j)-pi/2))...
                *x4(i)+R43(j)*(x4(i)-(BC-AC(i)));
       end

    end
end
Mom4_max = max(max(Mom4));
Mom4_min = min(min(Mom4))

figure
surf(X4,THETA2.*180./pi,Mom4,'edgecolor','none')
title('Bending Moment Member 4')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Bending Moment (N-mm)')
axis([0 100 0 360 -2000 500])

%% Part 5

x5 = linspace(1,BoB,length(F_RBo)); % position 'x' along beam
[X5,THETA5] = meshgrid(x5,theta5);

for i=1:length(x5)
    for j=1:length(theta5)
        A5(j,i) = RBy(j)*cos(pi/2-theta5(j))+RBx(j)*cos(theta5(j)); % Axial force from mid to pin A (end) of beam
    end
end
A5_max = max(max(A5));
A5_min = min(min(A5))

figure
surf(X5,THETA2.*180./pi,A5,'edgecolor','none')
title('Axial Force Member 5')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Axial Force (N)')
axis([0 20 0 360 -25 5])

for i=1:length(x5)
    for j=1:length(theta5)
        V5(j,i) = 0; %RBy(j)*sin(pi/2-theta5(j))+RBx(j)*sin(theta5(j)); % Axial force from mid to pin A (end) of beam
    end
end
V5_max = max(max(V5));
V5_min = min(min(V5))

figure
surf(X5,THETA2.*180./pi,V5,'edgecolor','none')
title('Shear Force Member 5')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Shear Force (N)')
axis([0 20 0 360 -20 5])

for i=1:length(x5)
    for j=1:length(theta5)
        Mom5(j,i) = 0; %(RBy(j)*sin(pi/2-theta5(j))+RBx(j)*sin(pi/2+theta5(j)))*x5(i); % Axial force from mid to pin A (end) of beam
    end
end
Mom5_max = max(max(Mom5));
Mom5_min = min(min(Mom5))

figure
surf(X5,THETA2.*180./pi,Mom5,'edgecolor','none')
title('Bending Moment Member 5')
xlabel('Length (mm)')
ylabel('Crank Angle (Deg)')
zlabel('Bending Moment (N-mm)')
axis([0 20 0 360 -400 100])

%% Place Values in one matrix

axialF = [A2;A4;A5];
shearF = [V2;V4;V5];
moment = [Mom2;Mom4;Mom5];


end



