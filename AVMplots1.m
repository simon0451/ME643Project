function [MAXaxial,MINaxial] = AVMplots1(x2,x4,x5,zh,theta2,theta4,theta5)

%% Deliverable h,i,j
%axial force

%things you need to supply for this deliverable to work:
% an array of member lengths
% an array of crank angles - this should be constant - zero to 2pi
% an array of axial force - this is determined by a relationship between x
% and y

%axes: member length (x), Crank angle (0 - 2pi) (y), axial force (z)

xh = [x2;x4;x5]; %this is a placeholder vector representing the length of the members 2, 4, and 5 (seperate plots)
yh = [theta2';theta4';theta5']; %this is a placeholder vector representing the 
%zh = axialF;

for i=1:3
[xxh,yyh] = meshgrid(xh(i,:),yh(i,:)); %making the inputs into a grid so they can be plotted
zzh = meshgrid(zh(i,:)); %this is the relationship between [xx,yy] and zz - so some function of 
MAXaxial(i) = max(zzh(i,:)); %we are interested in finding the maximum force value
MINaxial(i) = min(zzh(i,:)); %we are also interested in finding the minimum force value
partnum = [sprintf('Part 2');sprintf('Part 4');sprintf('Part 5')];

figure 
surf(xxh,yyh,zzh,'edgecolor','none')
title([partnum(i,:),' Crank Angle and Member Length with respect to Axial Force'])
xlabel('Member Length (mm)')
ylabel('Crank Angle (rad.)')
zlabel('Axial Force (N)')
end

end