%Author: Joel Kemp
%Purpose: Evaluates the linear regression model defined by the
%   weights vector using each fit-data point and target.
%Preconditions:
%   1. Y is a nonempty Nx1 numeric vector consisting of the data
%   points fit to a generated regression polynomial.
%   2. targets is a nonempty Nx1 numeric vector
%   4. |weights| > 0
%   5. lambda >= 0
%Returns: A scalar value representing the sum squared error of 
%   the passed weight vector on the fit-data and target vectors.
function E = evaluateRegressionModel(Y, targets, weights, lambda)
%Compute the squared differences of the targets to evaluated data points.
s = (targets - Y).^2;

%Compute the squared error term
E = sum(s) / 2;

%Remove w0 from the regularizer
weights(1) = [];

%Compute the regularization term
normsq = norm(weights).^2;
lambdaTerm = lambda/2;
R = lambdaTerm * normsq;

%Compute the error with L2-regularization
E = E + R;