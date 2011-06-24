%Author: Joel Kemp
%File: GMMEMSegment.m
%Purpose: Performs segmentation on the passed datafile using 
%   Gaussian Mixture Models with Expectation Maximization
%Returns:
function GMMEMSegment(dataFile, m)

%Open the datafile
X = csvread(dataFile);
%Compute the total number of datapoints
N = numel(X(:,1));
%Maximum number of iterations before giving up.
maxIterations = 500;
%Holds the current iteration of the algorithm
iter = 1;

%Tolerance for change in log likelihood.
%If the difference of log likelihoods between iterations is smaller than
%this threshold, we consider the likelihood to have converged.
%Note: We store this as a 1x2 matrix since we are dealing with 2-d
%   datapoints. The Log likelihood for each iteration of the algorithm is
%   returned as a 1x2 matrix, so the test convergence should check both
%   columns for convergence.
threshold = repmat(1e-4, 1, 2);   %Randomly chosen

%Whether or not we have reached convergence
converged = false;
%Holds the log-likelihood for each iteration to test for convergence
llhs = zeros(maxIterations,2);

%Initialization of the model
[oldmeans, oldcovariances, oldmixtureCoeffs] = GMMEMInitialize(X, m);

%%%%%%%%%%%%%%%%%%%%%%%%
% Plots
%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% plot(X(:,1), X(:,2), 'ro');
% hold on;
% for k = 1:m
%     plot(oldmeans(k,1), oldmeans(k,2), 'bo'); 
%     error_ellipse(oldcovariances{k,:}, oldmeans(k,:));
% end

%Test for convergence of the log likelihood
while ~converged && iter < maxIterations
    %Expectation of Gaussians 
    scores = GMMEMExpectation(X, m, oldmeans, oldcovariances, oldmixtureCoeffs);

    %Maximization
    [newmeans, newcovariances, newmixtureCoeffs] = GMMEMMaximization(X, m, scores, oldmeans, oldcovariances, oldmixtureCoeffs);

    %Log Likelihood
    %Store this iteration's sumloglikelihood to test for convergence
    llhs(iter,:) = GMMEMLogLikelihood(X, m, newmeans, newcovariances, newmixtureCoeffs);

    %Check for convergence of the log likelihood
    %Note: When iter = 1, llhs(iter-1,:) produces an unusable index.
    if(iter ~= 1)
        newllhs = llhs(iter,:);
        oldllhs = llhs(iter-1,:);
        dllhs =  newllhs - oldllhs;
%         t = threshold .* abs(newllhs);
        %converged = max(abs(dllhs) < t);
        converged = max(abs(dllhs) < threshold);
%         converged = max(max(oldmeans == newmeans)) && max(max(oldcovariances == newcovariances)) && max(max(oldmixtureCoeffs == newmixtureCoeffs));
%         converged = max(converged);
    end
    %Incrememnt the number of iterations
    iter = iter + 1;
    
    %Forget about the old model values and try again
    oldmeans = newmeans;
    oldcovariances = newcovariances;
    oldmixtureCoeffs = newmixtureCoeffs;
end

%Prepare the output log likelihood
% llh = llhs(iter-1);
%Print the number of iterations to convergence
% fprintf('%i\n', iter-1);

% %Finish plotting the new parameters
% %Note: At this point, the "old" variables have the "new" variable values
% for k = 1:m
%     plot(oldmeans(k,1), oldmeans(k,2), 'go'); 
%     error_ellipse(oldcovariances{k,:}, oldmeans(k,:));
% end

%%%%%%%%%%%%%%%%%%%%%%%%
%Program Output
%%%%%%%%%%%%%%%%%%%%%%%%
%Number of clusters
% fprintf('Number of clusters: %i\n', m);
%Number of iterations for convergence
% fprintf('GMMEM converged in %i steps!\n', iter-1);
%Output the log likelihood (minus one due to the iteration being
%incremented before the convergence test.
fprintf('Log Likelihood: %f\n', llhs(iter-1));

%Output the centroid locations
for k = 1:m
    fprintf('Cluster %i Centroid: (%i,%i)\n', k, oldmeans(k,1),oldmeans(k,2));
end

%Output the covariance matrices
for k = 1:m
    fprintf('Cluster %i Covariance:\n', k);
    curCov = oldcovariances{k,1};
    fprintf('[%f %f]\n',curCov(1,:));
    fprintf('[%f %f]\n',curCov(2,:));
end