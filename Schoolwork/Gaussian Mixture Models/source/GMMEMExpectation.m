%Author: Joel Kemp
%File: GMMEMExpectation.m
%Purpose: Computes the cluster assignment scores for each point in the data
%   matrix. 
%Preconditions: 
%   Means is an mx2 matrix of centroids
%   Covariances is an mx1 cell matrix of 2x2 covariance matrices
%   mixtureCoeffs is an mx1 matrix of floats    
%Returns: An NxM matrix consisting of assignment scores where each column 
%   represents the cluster and the rows represent the data points in X.
function scores = GMMEMExpectation(X, m, means, covariances, mixtureCoeffs)

N = numel(X(:,1));
%For each point, we hold the assigment score for each cluster
scores = zeros(N, m);

%For each point in X
for j = 1:N
    %Cache the point
    p = X(j,:);
    
    %Compute the assignment score across the entire set of clusters
    %Sum of the mixtureCoeffs * normpdf(p, mu, sigma) for each cluster.
    sumy = 0;
    %For each cluster
    for k = 1:m
        try
            %Compute the normal distribution of the cluster's stats
            y = mvnpdf(p, means(k,:), covariances{k,:});
        catch err
            covariances{k,:} = covariances{k,:} + 0.0000001;
            %Compute the norm distribution of p with the cluster stats
            y = mvnpdf(p, means(k,:), covariances{k,:});
        end
%         y = normpdf(p, means(k,:), covariances{k,1});
        %Multiply by the generated mixture coefficient
        sumy = sumy + (mixtureCoeffs(k,1) * y);
    end
    
    %Compute the cluster assignment scores for the current point
    for k = 1:m
        %Compute the normal distribution for the current point with the
        %current cluster's stats
        try
        y = mvnpdf(p, means(k,:), covariances{k,:});
%         y = normpdf(p, means(k,:), covariances{k,1});
        catch err
           covariances{k,:} = covariances{k,:} + 0.0000001;
           %Compute the norm distribution of p with the cluster stats
           y = mvnpdf(p, means(k,:), covariances{k,:}); 
        end
        %Multiply distribution value by the mixture coefficient.
        ym = mixtureCoeffs(k,1) * y;
        %Compute the total cluster's assignment score for the current point 
        scores(j, k) = ym / sumy; 
    end
end
