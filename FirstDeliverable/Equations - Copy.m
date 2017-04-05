x0 = [550,10.6,1,100]; %the initial guess for each of the answers
oldoptions = optimoptions('fsolve');
options = optimoptions(oldoptions,'MaxFunctionEvaluations',20000,'MaxIterations',20000);
[x,fval] = fsolve(@eSolve,x0,options);
%x is the x values, fval is the evaluated answer