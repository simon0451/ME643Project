%% A script to test 3D plotting

%making up some random variables
% x = [-3:.3:3]; %some made up x array
% y = [-3:.3:3]; %some made up y array

% [xx,yy] = meshgrid(x,y);
% what this does is makes a column vector z into an nxn matrix so [1 2 3] becomes
% [1 2 3; 1 2 3; 1 2 3;]
% it does the same thing to the y values

%you need to make a meshgrid before plotting a surface plot - you cannot
%simply give it x,y,z coordinate points

% zz=xx.^2-yy.^2; %the z term MUST relate the x terms to the y terms

% figure
% surf(xx,yy,zz)

%% Deliverable h
%axial force

%things you need to supply for this deliverable to work:
% an array of member lengths
% an array of crank angles - this should be constant - zero to 2pi
% an array of axial force - this is determined by a relationship between x
% and y

%axes: member length (x), Crank angle (0 - 2pi) (y), axial force (z)

x = [.1:.1:3]; %this is a placeholder vector representing the length of the members 2, 4, and 5 (seperate plots)
y = [0:pi/100:2*pi]; %this is a placeholder vector representing the 

[xxh,yyh] = meshgrid(x,y); %making the inputs into a grid so they can be plotted

zz = 0; %this is the relationship between [xx,yy] and zz - so some function of 
MAXaxial = max(zz); %we are interested in finding the maximum force value
MINaxial = min(zz); %we are also interested in finding the minimum force value

%% Deliverable i
%same thing as deliberable h, but this is with shear force instead of axial
%force.

%axes: member length (x), Crank angle (0 - 2pi) (y), shear force (z)

x = [.1:.1:3]; %this is a placeholder vector representing the length of the members 2, 4, and 5 (seperate plots)
y = [0:pi/100:2*pi]; %this is a placeholder vector representing the 

[xxi,yyi] = meshgrid(x,y); %making the inputs into a grid so they can be plotted

zz = 0; %this is the relationship between [xx,yy] and zz - so some function of 
MAXshear = max(zz); %we are interested in finding the maximum force value
MINshear = min(zz); %we are also interested in finding the minimum force value

%% Deliberable j
% internal bending moment

%same thing as deliberable h, but this is with moment instead of axial
%force.

%axes: member length (x), Crank angle (0 - 2pi) (y), internal bending moment (z)

x = [.1:.1:3]; %this is a placeholder vector representing the length of the members 2, 4, and 5 (seperate plots)
y = [0:pi/100:2*pi]; %this is a placeholder vector representing the 

[xxj,yyj] = meshgrid(x,y); %making the inputs into a grid so they can be plotted

zz = 0; %this is the relationship between [xx,yy] and zz - so some function of 
MAXmoment = max(zz); %we are interested in finding the maximum force value
MINmoment = min(zz); %we are also interested in finding the minimum force 



