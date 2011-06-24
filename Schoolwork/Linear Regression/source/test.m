%Author: Joel Kemp
%Machine Learning
%Homework 2 - Linear Regression

warning('off', 'MATLAB:nearlySingularMatrix');
trainFile = 'linear-regression.train.csv';
testFile = 'linear-regression.test.csv';

% %The regularization penalty 
 lambda = 0;
% %Experiment with 20 values for d with no regularization
% % ds = 1:2:40;
% % ds = 1:2:39;
% ds = 10:15; %Debug
ds = 13; %Overfitting degree
numD = numel(ds);
trainE = zeros(numD, 1);
testE = zeros(numD, 1);
for k = 1:numD
    [trainError testError] = LinearRegression(trainFile, testFile, ds(k), lambda);
    fprintf('%i & %f & %f \\\\ \n', ds(k), trainError, testError);
    trainE(k, 1) = trainError;
    testE(k, 1) = testError;
    
end
% %Plot the errors
% figure
% set(gcf, 'Name', 'Training vs Testing Errors w/ No Regularization');
% % plot(ds, trainE, 'b-', ds, testE, 'r-');
% plot(ds, sqrt(2*trainE), 'b-', ds, sqrt(2*testE), 'r-');
% legend('Training Error', 'Testing Error');
% xlabel('Degree');
% ylabel('Root Mean Squared Error');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regularization Experiment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lambdas = ones(1, 10);
% %The maximum number of different lambda values
% numLambdas = numel(lambdas);
% for j = 1:numLambdas
%    lambdas(1,j) = 0.1/(10^j); 
% end
lambdas = 0.00001:0.000001:0.0001;
% lambdas = 0.000055:0.000001:0.0001;
numLambdas = numel(lambdas);

% lambdas = 0.000005;
trainER = zeros(numLambdas, 1);
testER = zeros(numLambdas, 1);
%Overfitting degree
d = 13;
%For each lambda value from 1 to numIterations
for k = 1:numLambdas
    lambda = lambdas(k);
    %Compute the training and testing errors for the current lambda value.
    [trainError testError] = LinearRegression(trainFile, testFile, d, lambda);
    fprintf('%f & %f & %f \\\\ \n', lambda, trainError, testError);
    %Store the errors in the errors matrix
    trainER(k, 1) = trainError;
    testER(k, 1) = testError;
end

%We have the errors for no regularization and for regularization
%and we want to see the differences in the errors

% % Plot the errors
% figure
% set(gcf, 'Name', 'Training vs Testing Errors for Varying Lambda');
% % Plot Lambda vs. RMS No regularization
rmstraine = sqrt(2*trainError);
rmsteste = sqrt(testError);
loglog(lambdas, repmat(rmstraine, 1 , numLambdas), 'b-',...
    lambdas, repmat(rmsteste, 1, numLambdas), 'r-'); 
hold on;
% %Plot Lambda vs RMS w/ Regularization
loglog(lambdas, sqrt(2*trainER), 'b--',lambdas, sqrt(2*testER), 'r--');
% % plot(trainE, testE, 'b-', trainER, testER, 'r-');
legend('Training Error', 'Testing Error', 'Training Error / Reg', 'Testing Error w/ Reg');
xlabel('lambda');
ylabel('Errors');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data Plots - Place in LinearRegression.m and Uncomment to use the plots!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% set(gcf, 'Name', ['Degree ' num2str(d) ' Polynomial']);
% %Training Data vs Training Target Plot
% subplot(221);
% plot(trainData, trainTargets, 'b+');
% xlabel('Data');
% ylabel('Target');
% title('Training Data vs Training Target');
% 
% %Training Data vs. Evaluated Training Data
% subplot(222);
% plot(trainData, trainTargets, 'b+', trainData, trainY, 'go');
% legend('Training Data','Evaluated Training data');
% title('Training Data vs. Evaluated Training Data');
% xlabel('Data');
% ylabel('Target');
% 
% %Testing Data vs Testing Target Plot
% subplot(223);
% plot(testData, testTargets, 'b+');
% title('Testing Data vs Testing Target');
% xlabel('Data');
% ylabel('Target');
% 
% %Testing Data vs. Evaluated Testing Data
% subplot(224);
% plot(testData, testTargets, 'b+', testData, testY, 'go');
% legend('Test Data','Evaluated Test data');
% title('Testing Data vs. Evaluated Testing Data');
% xlabel('Data');
% ylabel('Target');