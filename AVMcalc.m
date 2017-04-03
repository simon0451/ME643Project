function [axialF,shearF,moment,x2,x4,x5] = AVMcalc(F_RC,F_RB,F_RBo,F_RA,F_RAo,M2,...
    a6x,rx,theta2,theta4,theta5,AC)

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

x2 = linspace(1,AoA,length(F_RAo)); % position 'x' along beam

for i=1:length(x2)
    if x2(i) < AoA/2
        A2(i) = F_RAo(i); % Axial force from Ao to middle of beam
    end
    if x2(i) > AoA/2
        A2(i) = F_RA(i); % Axial force from mid to pin A (end) of beam
    end
end

for i=1:length(x2)
    if x2(i) < AoA/2
        V2(i) = F_RAo(i)*sin(theta2(i)+pi/2); % Shear force from Ao to middle of beam
    end
    if x2(i) > AoA/2
        V2(i) = F_RA(i)*sin(theta2(i)+pi/2); % Shear force from mid to pin A (end) of beam
    end
end

for i=1:length(x2)
    if x2(i) < AoA/2
         Mom2(i) = F_RAo(i)*sin(theta2(i)+pi/2)*x2(i)+M2(i); % Moment from Ao to middle of beam
    end
     if x2(i) > AoA/2
         Mom2(i) = F_RA(i)*sin(theta2(i)+pi/2)*(AoA-x2(i)); % Moment from mid to pin A (end) of beam
     end
end

%% Part 4

x4 = linspace(1,BC,length(F_RBo)); % position 'x' along beam

for i=1:length(x4)
    if x4(i) < (BC-AC(i))
        A4(i) = F_RB(i); % Axial force
    end
    if (x4(i) > (BC-AC(i)) && x4(i) < ((BC-AC(i))+AC(i))/2)
        A4(i) = F_RB(i)+F_RA(i); % Axial force
    end
    if x4(i) > (BC-AC(i))
        A4(i) = F_RC(i); % Axial force
    end
end

for i=1:length(x4)
    if x4(i) < (BC-AC(i))
        V4(i) = F_RB(i)*sin(theta4(i)+pi/2); % Shear force
    end
    
    if (x4(i) > (BC-AC(i)) && x4(i) < ((BC-AC(i))+AC(i))/2)
        V4(i) = -F_RB(i)*sin(theta4(i)+pi/2) ...
        -F_RA(i)*sin(theta4(i)+pi/2); % Shear force
    end
    
    if x4(i) > (BC-AC(i))
        V4(i) = -F_RC(i)*sin(theta4(i)+pi/2); % Shear force 
    end
end

for i=1:length(x2)
    if x4(i) < (BC-AC(i))
        Mom4(i) = F_RB(i)*sin(theta4(i)+pi/2)*x4(i); % Moment
    end
    if (x4(i) > (BC-AC(i)) && x4(i) < ((BC-AC(i))+AC(i))/2)
        Mom4(i) = F_RB(i)*sin(theta4(i)+pi/2)*x4(i) ...
        +F_RA(i)*sin(theta4(i)+pi/2)*(x4(i)-(BC-AC(i))); % Moment
    end
    if x4(i) > (BC-AC(i))
        Mom4(i) = F_RC(i)*sin(theta4(i)+pi/2)*((BC-AC(i))+AC(i)-x4(i)); % Moment 
    end
end

%% Part 5

x5 = linspace(1,BoB,length(F_RBo)); % position 'x' along beam

for i=1:length(x5)
    if x5(i) < BoB/2
        A5(i) = F_RBo(i); % Axial force
    end
    if x5(i) > BoB/2
        A5(i) = F_RB(i); % Axial force
    end
end

for i=1:length(x5)
    if x5(i) < BoB/2
        V5(i) = F_RBo(i)*sin(theta5(i)+pi/2); % Shear force
    end
    if x5(i) > BoB/2
        V5(i) = F_RB(i)*sin(theta5(i)+pi/2); % Shear force 
    end
end

for i=1:length(x2)
    if x5(i) < BoB/2
        Mom5(i) = F_RBo(i)*sin(theta5(i)+pi/2)*x5(i); % Moment
    end
     if x5(i) > BoB/2
        Mom5(i) = F_RB(i)*sin(theta5(i)+pi/2)*(AoA-x5(i)); % Moment 
     end
end
%% Place Values in one matrix

axialF = [A2;A4;A5];
shearF = [V2;V4;V5];
moment = [Mom2;Mom4;Mom5];    
end



