'''
Author: Joel Kemp
Pattern Recognition 
Bayesian Classification Project
Prof. Haralick
Fall 2010
'''

from Probability import *
from DecisionRule import *

class Experiment():
    '''
    Purpose: Contains the code to run the experiment.
    '''

    @staticmethod
    def experimental_stat(num_experiments, ND, NC, Ppop, Cpriors, gain_matrix, Ntrain, Ntest):
        '''
        Purpose: Run the experiment on the supplied data!
        Returns: The expected gain from the training and test sets of data.
        Gains = [Gtrain, Gtest]
        '''
        
        Gains = []
        for e in range(num_experiments):
        
            #Debug: Print out the complete probability table
            print "Ppop: (NC x ND) =", NC, "x", ND
            for c in range(NC):
                print "c", c, Ppop[c]
                
            #Generate a training set from the generated probabilities
            Strain = Probability.gen_sample_from_prob(ND, NC, Ntrain, Ppop)
            #Compute the conditional probabilities based on the training data
            Ptrain = Probability.est_prob(ND, NC, Strain)
            print "P(d,c) Training Set:"
            for c in range(NC):
                print Ptrain[c]
                
            #Get the true class for each measurement
            true_classes = DecisionRule.GenerateTrueClasses(ND, NC, Ptrain)
            print "True Classes:", true_classes
            
            assigned_classes = DecisionRule.GetAssignedClasses(ND, NC, Ptrain)
            print "Assigned Classes:", assigned_classes
            
            #Decide the class for each measurement based on the conditional probabilities
            Htrain = DecisionRule.construct_dec_rule(gain_matrix, ND, NC, Ptrain, Cpriors, true_classes, assigned_classes)
            print "Decided Classes:", Htrain
            
            #Evaluate the decisions we made into a contingency table
            Ttrain = DecisionRule.eval_dec_rule(ND, NC, Ptrain, Htrain, Cpriors, true_classes, assigned_classes)
            print "Contingency Matrix:"
            for c in range(NC):
                print Ttrain[c]
                
            #Compute the expected gain from the decisions
            Gtrain = DecisionRule.expected_gain(NC, Ttrain, gain_matrix)
            
            #Generate the testing set from the joint probabilities
            Stest = Probability.gen_sample_from_prob(ND, NC, Ntest, Ppop)
            #Compute the conditional probabilities based on the test data
            Ptest = Probability.est_prob(ND, NC, Stest)
            #Evaluate the decision rule (generated from the training) on the test data
            Ttest = DecisionRule.eval_dec_rule(ND, NC, Ptest, Htrain, Cpriors, true_classes, assigned_classes)
            #Compute the expected gain of the decisions on the test data
            Gtest = DecisionRule.expected_gain(NC, Ttest, gain_matrix)
            
            Gains.append([Gtrain, Gtest])
        
        return Gains
        