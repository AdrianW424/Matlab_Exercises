function [xZero, abortFlag, iters] = myNewton(varargin)
% myNewton - calculates zeros using the newton raphson method
%
% Syntax:  [xZero, abortFlag, iters] = myNewton(varargin)
%
% Inputs:
%    varargin - Contains arguments that are passed by the user when calling the function
%
% Outputs:
%    xZero - Zero of the function
%    abortFlag - Reason for terminating the calculation of the zero
%    iters - Number of iterations to calculate the zero point
%
% Example: 
%    Line 1 of example
%    Line 2 of example
%    Line 3 of example
%
% Other m-files required: myPoly.m, dmyPoly.m, numDiff.m
% Subfunctions: myPoly, dmyPoly, numDiff
% MAT-files required: none
%
% See also: myPoly, dmyPoly, numDiff
%
% MATLAB Version: MATLAB R2022a
%
% Author: Adrian Waldera
% DHBW Stuttgart
% email: adrianwaldera@gmx.de
% April 2022; Last revision: 05-April-2022

for i = 1:nargin
    if strcmp(varargin{i},'function')
        func = varargin{i+1};
    elseif strcmp(varargin{i},'derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i},'startValue')
        x0 = varargin{i+1};
    elseif strcmp(varargin{i},'maxIter')
        maxIter = varargin{i+1};
    elseif strcmp(varargin{i},'feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i},'xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i},'livePlot')
        livePlot = varargin{i+1};   
    end
end

if ~exist('func','var')
    error('No valid function');
end
    
if ~exist('x0','var')
    x0 = 5;
    disp(['Using default startvalue: x0 = ',num2str(x0)]);
end

if ~exist('dfunc','var')
    answer = questdlg("Welche Methode der numerischen Differentiation soll verwendet werden?", "Differentiation-Auswahl", "Vorwärtsdifferentiation", "Rückwärtsdifferentiation", "Zentraldifferentiation", "Vorwärtsdifferentiation");
end

if ~exist('maxIter','var')
    maxIter = 50;
    disp(['Using default maximum iterations: maxIter = ',num2str(maxIter)]);
end

if ~exist('feps','var')
    feps = 1e-6;
    disp(['Using default Feps: feps = ',num2str(feps)]);
end

if ~exist('xeps','var')
    xeps = 1e-6;
    disp(['Using default Xeps: xeps = ',num2str(xeps)]);
end

if ~exist('livePlot','var')
    livePlot = 'off';
    disp(['Using default live Plot: livePlot = ','off']);
end

if strcmp(livePlot,'on')
   h = figure('Name','Newton visualization');
   ax1 = subplot(2,1,1);
   plot(ax1,0,x0,'bo');
   ylabel('xValue');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
   ax2 = subplot(2,1,2);
   semilogy(ax2,0,func(x0),'rx');
   xlabel('Number of iterations')
   ylabel('Function value');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
end
xOld = x0;
abortFlag = 'maxIter';
for i = 1:maxIter
    f = func(xOld);
    if abs(f) < feps
        abortFlag = 'feps';
        break;
    end

    if exist('dfunc','var')
        df = dfunc(xOld);
    else
        df = numDiff(func, xOld, answer);
    end

    if df == 0
        abortFlag = 'df = 0';
        break;
    end
    xNew = xOld - f/df; 
    if abs(xNew-xOld) < xeps
        abortFlag = 'xeps';
        break;
    end
    xOld = xNew;
    if strcmp(livePlot,'on')
       plot(ax1,i,xNew,'bo');
       semilogy(ax2,i,func(xNew),'rx');
       pause(0.05);
    end
end
iters = i;
xZero = xNew;
end