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

figure
surf(X2,THETA2,A2,'edgecolor','none')
title('Axial Force Part 2')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')
zlabel('Axial Force (N)')

for i=1:length(x2)
    for j=1:length(theta2)
        V2(i,j) = -R23x(i)*sin(theta2(i)) - R23y(i)*sin(pi/2-theta2(i)); % Axial force from mid to pin A (end) of beam
    end
end

figure
surf(X2,THETA2,V2,'edgecolor','none')
title('Shear Force Part 2')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')
zlabel('Shear Force (N)')

for i=1:length(x2)
    for j=1:length(theta2)
        Mom2(i,j) = -(-R23x(j)*sin(theta2(j)) - R23y(j)*sin(pi/2-theta2(j)))*x2(i)+M2(i); % Axial force from mid to pin A (end) of beam
    end
end

figure
surf(X2,THETA2,Mom2,'edgecolor','none')
title('Bending Moment of Part 2')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')
zlabel('Bending Moment (N*mm)')

%% Part 4

x4 = linspace(0,BC,length(F_RBo)); % position 'x' along beam
[X4,THETA4] = meshgrid(x4,theta4);

for i=1:length(x4)
    for j=1:length(theta4)
        A4(j,i) = -R64y(j)*cos(theta4(j)-pi/2) - R64x(j)*cos(pi-theta4(j)); % Axial force from mid to pin A (end) of beam
    end
end

figure
surf(X4,THETA2,A4,'edgecolor','none')
title('Axial Force Part 4')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')

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

figure
surf(X4,THETA2,V4,'edgecolor','none')
title('Shear Force Part 4')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')
zlabel('Shear Force (N)')

for i=1:length(x2)
    for j=1:length(theta4) 
        
       if x4(i) < (BC-AC(i))
           Mom4(j,i) = (-RBx(j)*sin(pi-theta4(j))+RBy(j)*sin(theta4(j)-pi/2))*x4(i); % Shear force
       end        
        
       if x4(i) >= (BC-AC(i))
            Mom4(j,i) = (-RBx(j)*sin(pi-theta4(j))+RBy(j)*sin(theta4(j)-pi/2))...
                *x4(i)+R43(j)*(x4(i)-(BC-AC(i))); % Shear force
       end

    end
end

figure
surf(X4,THETA2,Mom4,'edgecolor','none')
title('Bending Moment Part 4')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')
zlabel('Bending Moment (N*mm)')

%% Part 5

x5 = linspace(1,BoB,length(F_RBo)); % position 'x' along beam
[X5,THETA5] = meshgrid(x4,theta4);

for i=1:length(x5)
    for j=1:length(theta5)
        A5(j,i) = RBy(j)*cos(pi/2-theta5(j))+RBx(j)*cos(theta5(j)); % Axial force from mid to pin A (end) of beam
    end
end

figure
surf(X5,THETA2,A5,'edgecolor','none')
title('Axial Force Part 5')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')
zlabel('Axial Force (N)')

for i=1:length(x5)
    for j=1:length(theta5)
        V5(j,i) = RBy(j)*sin(pi/2-theta5(j))+RBx(j)*sin(theta5(j)); % Axial force from mid to pin A (end) of beam
    end
end

figure
surf(X5,THETA2,V5,'edgecolor','none')
title('Shear Force Part 5')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')
zlabel('Shear Force (N)')

for i=1:length(x5)
    for j=1:length(theta5)
        Mom5(j,i) = (RBy(j)*sin(pi/2-theta5(j))+RBx(j)*sin(theta5(j)))*x5(i); % Axial force from mid to pin A (end) of beam
    end
end

figure
surf(X5,THETA2,Mom5,'edgecolor','none')
title('Bending Moment Part 5')
xlabel('Length (mm)')
ylabel('Crank Angel (rad)')
zlabel('Bending Moment (N*mm)')

%% Place Values in one matrix

axialF = [A2;A4;A5];
shearF = [V2;V4;V5];
moment = [Mom2;Mom4;Mom5];    
end



