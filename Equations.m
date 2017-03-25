x0 = [50,1.6,1,10]; %the initial guess for each of the answers
oldoptions = optimoptions('fsolve');
options = optimoptions(oldoptions,'MaxFunctionEvaluations',20000,'MaxIterations',20000);
[x,fval] = fsolve(@eSolve,x0,options);