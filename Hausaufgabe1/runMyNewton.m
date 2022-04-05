[xZero, abortFlag, iters] = myNewton('function', @myPoly, 'livePlot', 'on');

disp(['Zero at: x0 = ',num2str(xZero)]);
disp(['Reason for the calculation abort: ', abortFlag]);
disp(['Number of iterations: ',num2str(iters)]);