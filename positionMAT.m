function [AC, theta4, theta5, rx] = positionMAT(theta2)
% Find the position of theta4, theta5, rx and la(AC)

x0 = [50,1.5,.9,1];
oldoptions = optimoptions('fsolve');
options = optimoptions(oldoptions, 'MaxFunctionEvaluations',1000,'MaxIterations',1000);

x2 = arrayfun(@(a)fsolve(@(x)position_fs(x,a),x0,options),theta2, 'UniformOutput', false);
% extract information from cells
%x = zeros(10,4);
for i = 1:length(theta2)
    x(i,:) = x2{i};
end

AC = x(:,1);
theta4 = x(:,2);
theta5 = x(:,3);
rx = x(:,4);

end