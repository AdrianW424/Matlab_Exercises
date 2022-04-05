function derivative = numDiff(func, x, Method)
% numDiff - Calculates numerical derivative of a function
%
% Syntax:  derivative = numDiff(func, x, Method)
%
% Inputs:
%    func - Function whose derivative is to be calculated
%    x - Point at which the discharge is to take place
%    Method - Method with which the derivation is to take place
%
% Outputs:
%    derivative - Derived function at position x
%
% Example: 
%    Line 1 of example
%    Line 2 of example
%    Line 3 of example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: myPoly
%
% MATLAB Version: MATLAB R2022a
%
% Author: Adrian Waldera
% DHBW Stuttgart
% email: adrianwaldera@gmx.de
% April 2022; Last revision: 05-April-2022

    if Method == "Vorwärtsdifferentiation"
        h = 10^(-8);
        derivative = (func(x + h) - func(x))/h;
    elseif Method == "Rückwärtsdifferentiation"
        h = 10^(-8);
        derivative = (func(x) - func(x - h))/h;
    elseif Method == "Zentraldifferentiation"
        h = 10^(-6);
        derivative = (func(x + h) - func(x - h))/(2*h);
    end
end