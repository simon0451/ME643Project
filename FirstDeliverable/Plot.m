%% Plot Header

%this script will generate plots

%% A script to test 3D plotting

%making up some random variables
x = [-3:.3:3]; %some made up x array
y = [-3:.3:3]; %some made up y array

[xx,yy] = meshgrid(x,y);
% what this does is makes a column vector z into an nxn matrix so [1 2 3] becomes
% [1 2 3; 1 2 3; 1 2 3;]
% it does the same thing to the y values

%you need to make a meshgrid before plotting a surface plot - you cannot
%simply give it x,y,z coordinate points

zz=xx.^2-yy.^2; %the z term MUST relate the x terms to the y terms

figure
surf(xx,yy,zz)
title('Some Random Data')
xlabel('Xdata')
ylabel('Ydata')
zlabel('Zdata')

%% Deliverable h
%axial force

%things you need to supply for this deliverable to work:
% an array of member lengths
% an array of crank angles - this should be constant - zero to 2pi
% an array of axial force - this is determined by a relationship between x
% and y

%axes: member length (x), Crank angle (0 - 2pi) (y), axial force (z)

xh = [x2;x4;x5]; %this is a placeholder vector representing the length of the members 2, 4, and 5 (seperate plots)
yh = [theta2';theta4';theta5']; %this is a placeholder vector representing the 
zh = axialF;

for i=1:3
[xxh,yyh] = meshgrid(xh(i,:),yh(i,:)); %making the inputs into a grid so they can be plotted
zzh = meshgrid(zh(i,:)); %this is the relationship between [xx,yy] and zz - so some function of 
MAXaxial = max(zzh(i,:)); %we are interested in finding the maximum force value
MINaxial = min(zzh(i,:)); %we are also interested in finding the minimum force value

figure 

surf(xxh,yyh,zzh,'edgecolor','none')

title('Crank Angle and Member Length with respect to Axial Force')
xlabel('Member Length (m)')
ylabel('Crank Angle (rad.)')
zlabel('Axial Force (N)')
end
%% Deliverable i
%same thing as deliberable h, but this is with shear force instead of axial
%force.

%axes: member length (x), Crank angle (0 - 2pi) (y), shear force (z)

xi = [.1:.1:3]; %this is a placeholder vector representing the length of the members 2, 4, and 5 (seperate plots)
yi = [0:pi/100:2*pi]; %this is a placeholder vector representing the 

[xxi,yyi] = meshgrid(xi,yi); %making the inputs into a grid so they can be plotted

zzi = 0; %this is the relationship between [xx,yy] and zz - so some function of 
MAXshear = max(zzi); %we are interested in finding the maximum force value
MINshear = min(zzi); %we are also interested in finding the minimum force value

figure
surf(xxi,yyi,zzi)
title('Crank Angle and Member Length with respect to Shear Force')
xlabel('Member Length (m)')
ylabel('Crank Angle (rad.)')
zlabel('Shear Force (N)')
%% Deliberable j
% internal bending moment

%same thing as deliberable h, but this is with moment instead of axial
%force.

%axes: member length (x), Crank angle (0 - 2pi) (y), internal bending moment (z)

xj = [.1:.1:3]; %this is a placeholder vector representing the length of the members 2, 4, and 5 (seperate plots)
yj = [0:pi/100:2*pi]; %this is a placeholder vector representing the 

[xxj,yyj] = meshgrid(xj,yj); %making the inputs into a grid so they can be plotted

zzj = 0; %this is the relationship between [xx,yy] and zz - so some function of 
MAXmoment = max(zzj); %we are interested in finding the maximum force value
MINmoment = min(zzj); %we are also interested in finding the minimum force 

figure
surf(xxj,yyj,zzj)
title('Crank Angle and Member Length with respect to Internal Bending Moment')
xlabel('Member Length (m)')
ylabel('Crank Angle (rad.)')
zlabel('Bending Moment (N*m)')

