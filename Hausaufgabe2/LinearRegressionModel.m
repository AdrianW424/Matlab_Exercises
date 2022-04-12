classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            for i=1:2:nargin
               if strcmp(varargin{i}, 'Data')
                     obj.trainingData = varargin{i+1};
               elseif strcmp(varargin{i}, 'Optimizer')
                    obj.optimizer = varargin{i+1};
               end
            end
            
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples; 
            
            % ========= YOUR CODE HERE =========
            x = obj.hypothesis();
            y = obj.trainingData.commandVar;            
            J = 1/(2*m) * sum((x(:,1)-y).^2);
            
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            hValue = X*obj.theta;
        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            costs = ones(numel(theta0_vals), numel(theta1_vals));
            for i1=1:numel(theta0_vals)
                for i2=1:numel(theta1_vals)
                    obj.setTheta(theta0_vals(i1), theta1_vals(i2));
                    costs(i2,i1) = obj.costFunction();
                end
            end            
            contour(theta0_vals, theta1_vals, costs);
            xlabel('\theta_0'); 
            ylabel('\theta_1');
            hold on;
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'xr', 'MarkerSize', 10, 'LineWidth', 2);
            hold off;
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            costs = ones(numel(theta1_vals), numel(theta0_vals));
            for i1=1:numel(theta0_vals)
                for i2=1:numel(theta1_vals)
                    obj.setTheta(theta0_vals(i1), theta1_vals(i2));
                    costs(i2,i1) = obj.costFunction();
                end
            end            
            surf(theta0_vals, theta1_vals, costs);
            xlabel('\theta_0'); 
            ylabel('\theta_1');
            
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
           % ========= YOUR CODE HERE =========
           model = obj.hypothesis();
           hold on;
           plot(obj.trainingData.feature, model(:,1), 'b-');
           legend('TrainingData', 'Linear Regression')
           hold off;
           
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end

