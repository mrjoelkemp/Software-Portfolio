'''
Author: Joel Kemp
Pattern Recognition 
Bayesian Classification Project
Prof. Haralick
Fall 2010
'''
import sys
import random
import math

from Experiment import *
import pylab
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d, Axes3D #<-- Note the capitalization! 
import matplotlib
from matplotlib import cm


def main(args):
    
    random.seed(100)
    #Number of measurements
    #ND_List = [10, 50, 100, 200, 500]
    ND_List = [10] #Testing purposes
    #Number of classes
    #NC_List = [2, 5, 10]
    NC_List = [2]           #Testing Purposes
    
    #Number of dominant measurements as an integer
    #Ndom_List = [0.8, 0.9, 0.95, 0.97, 0.99]
    Ndom_List = [0.99]
    #Dominant fraction
    #fd_List = [0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 0.99]
    fd_List = [0.99]
    
    #Training fraction
    FTrain_List = [2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 50, 100]
    #Test fraction
    FTest_List = [2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 50, 100]
    
    #Holds a collection of figures
    figure_List = []

    ############################################3
    #For each combination of ND, NC, do plots 1 and 2
    for ND in ND_List:
        #We need to reset the list since we're overwriting it later.
        #Ndom_List = [0.8, 0.9, 0.95, 0.97, 0.99]
        for NC in NC_List:
            #Nd is dependent on ND, so we compute it here
            #for i in range(len(Ndom_List)):
                #Ndom_List[i] = int(math.floor(Ndom_List[i] * ND))
            
            #Holds the generated expected gain for each experiment 
            expected_gain_matrix = []
            
            #Prepare the expected gain results matrix
            for i in range(len(fd_List)):
                expected_gain_matrix.append([])
                for j in range(len(Ndom_List)):
                    expected_gain_matrix[i].append(0)
                    
            #Number of training samples we need
            Ntrain = 10*NC*ND
            #Number of test samples
            Ntest = Ntrain    
            #The total number of times to run the experiment 
            NExperiments = 1
            for i in range(len(fd_List)):
                for j in range(len(Ndom_List)):
                    fd = fd_List[i]
                    #Remember, Nd = floor(some_fraction * ND)
                    Nd = int(math.floor(Ndom_List[j] * ND))
                    
                    #print "fd =", fd, "; Nd =", Ndom_List[j]
                    #Generate a joint probability table P(c, d)
                    Ppop = Probability.form_prob(ND, Nd, NC, fd)
                     
                    #Print Ppop
                    print "Ppop:"
                    for c in range(NC):
                        print "c", c, Ppop[c];
                        
                    #Compute the prior class probabilities from the generate joint probabilities.
                    Cpriors = DecisionRule.compute_class_priors(ND, NC, Ppop)
                    #Generate the gain matrix from the number of classes
                    gain_matrix = DecisionRule.GenerateGainMatrix(NC)
                    #Store the expected gain [Gain_training, Gain_testing]
                    expected_gain_matrix[i][j] = Experiment.experimental_stat(NExperiments, ND, NC, Ppop, Cpriors, gain_matrix, Ntrain, Ntest)
            
            #PLOT 1 - Testing Set Expected Gain
            #Once we have all the generated expected gains
            
            #Set up a matrix to hold all that data
            testing_expected_gain_matrix = np.array([])
            testing_expected_gain_matrix = np.resize(testing_expected_gain_matrix, (len(fd_List), len(Ndom_List)))
            
            #Grab only the testing set expected gain entries
            for i in range(len(fd_List)):
                for j in range(len(Ndom_List)):
                    egaintuple = expected_gain_matrix[i][j]
                    #Get the expected gain for only the testing set
                    test_egain = egaintuple[0][1]
                    testing_expected_gain_matrix[i][j] = np.array(test_egain)
                  
            
            #===================================================================
            # print "Testing Expected Gain Matrix: "
            # for i in range(len(fd_List)):
            #    print testing_expected_gain_matrix[i]
            #===================================================================
                
            #Pylab surface plot here
            fig = plt.figure()
            title = "Testing Set Expected Gain (ND = " + str(ND) + ", NC = " + str(NC) + ")"
            fig.text(.2, .95, title) 
            ax = Axes3D(fig)
            #X = np.arange(0, 1, 0.15)
            #Y = np.arange(0, 1, 0.15)
            Y = np.array(fd_List)
            X = np.array(Ndom_List)
            #Z = np.ravel(testing_expected_gain_matrix)
            #print "Z", Z
            X, Y = np.meshgrid(X, Y) 
            cset = ax.plot_wireframe(X, Y, testing_expected_gain_matrix)
            #cset = ax.plot_wireframe(X, Y, Z)
            ax.set_xlabel("Nd")
            ax.set_ylabel("fd")
            ax.set_zlabel("Expected Gain")
            
            #Plot 2
            #Set up a matrix to hold all that data
            plot2_expected_gain_matrix = np.array([])
            plot2_expected_gain_matrix = np.resize(plot2_expected_gain_matrix, (len(fd_List), len(Ndom_List)))
            
            #Grab only the testing set expected gain entries
            for i in range(len(fd_List)):
                for j in range(len(Ndom_List)):
                    egaintuple = expected_gain_matrix[i][j]
                    train_egain = egaintuple[0][0]
                    #Get the expected gain for only the testing set
                    test_egain = egaintuple[0][1]
                    plot2_expected_gain_matrix[i][j] = np.array(train_egain - test_egain)
            
            fig2 = plt.figure()
            title = "Training - Testing Set Expected Gain (ND = " + str(ND) + ", NC = " + str(NC) + ")"
            fig2.text(.2, .95, title) 
            ax = Axes3D(fig2)
            #X = np.arange(0, 1, 0.15)
            #Y = np.arange(0, 1, 0.15)
            Y = np.array(fd_List)
            X = np.array(Ndom_List)
            X, Y = np.meshgrid(X, Y) 
            cset2 = ax.plot_wireframe(X, Y, plot2_expected_gain_matrix)
     
            ax.set_xlabel("Nd")
            ax.set_ylabel("fd")
            ax.set_zlabel("(Training - Testing) Expected Gain")
            plt.show()
    
    
    '''
    ##########################################       
    #DO Plot 3
    ND_List = [10, 50, 100, 200, 500]
    NC_List = [2, 5, 10]
    fd_Nd_List = [[0.7, 0.8], [0.99, 0.99],[0.85, 0.9],[0.7, 0.99],[0.99, 0.8]]       
    for fdNd in fd_Nd_List:
        fd = fdNd[0]
        
        #Holds the generated expected gain for each experiment 
        expected_gain_matrix = []
        
        #Prepare the expected gain results matrix
        for i in range(len(ND_List)):
            expected_gain_matrix.append([])
            for j in range(len(NC_List)):
                expected_gain_matrix[i].append(0)
                
        for i in range(len(ND_List)):
        #We need to reset the list since we're overwriting it later.
            ND = ND_List[i]
            Nd = fdNd[1]
            Nd = int(math.floor(Nd * ND))
            for j in range(len(NC_List)):                
                NC = NC_List[j]
                #Number of training samples we need
                Ntrain = 10*NC*ND
                #Number of test samples
                Ntest = Ntrain    
                #The total number of times to run the experiment 
                NExperiments = 1
                    
                #Generate a joint probability table P(c, d)
                Ppop = Probability.form_prob(ND, Nd, NC, fd)
                #Compute the prior class probabilities from the generate joint probabilities.
                Cpriors = DecisionRule.compute_class_priors(ND, NC, Ppop)
                #Generate the gain matrix from the number of classes
                gain_matrix = DecisionRule.GenerateGainMatrix(NC)
                #Store the expected gain [Gain_training, Gain_testing]
                expected_gain_matrix[i][j] = Experiment.experimental_stat(NExperiments, ND, NC, Ppop, Cpriors, gain_matrix, Ntrain, Ntest)
   
        #Set up a matrix to hold all that data
        testing_expected_gain_matrix = np.array([])
        testing_expected_gain_matrix = np.resize(testing_expected_gain_matrix, (len(ND_List), len(NC_List)))
        
        #Grab only the testing set expected gain entries
        for i in range(len(ND_List)):
            for j in range(len(NC_List)):
                egaintuple = expected_gain_matrix[i][j]
                #Get the expected gain for only the testing set
                test_egain = egaintuple[0][1]
                testing_expected_gain_matrix[i][j] = np.array(test_egain)
        #Plot
        fig3 = plt.figure()
        title = "Testing Set Expected Gain (fd= " + str(fd) + ", Nd = " + str(fdNd[1]) + ")"
        fig3.text(.2, .95, title) 
        ax = Axes3D(fig3)
       
        Y = np.array(ND_List)
        X = np.array(NC_List)
        X, Y = np.meshgrid(X, Y) 
        cset2 = ax.plot_wireframe(X, Y, testing_expected_gain_matrix)
   
        ax.set_xlabel("NC")
        ax.set_ylabel("ND")
        ax.set_zlabel("Testing Expected Gain")
        plt.show()
    '''    
    '''
    #DO Plot 5: Analyze the n-class expected gain for varying measurements
    ND_List = [10, 50, 100, 200, 500]
    NC_List = [5]
    #fd_Nd_List = [[0.99, 0.99]]       
    fd_Nd_List = [[0.85, 0.99]]       
    #fd_Nd_List = [[0.99, 0.99]]       
    #fd_Nd_List = [[0.99, 0.99]]       
    for fdNd in fd_Nd_List:
        fd = fdNd[0]
        
        #Holds the generated expected gain for each experiment 
        expected_gain_matrix = []
        
        #Prepare the expected gain results matrix
        for i in range(len(ND_List)):
            expected_gain_matrix.append([])
            for j in range(len(NC_List)):
                expected_gain_matrix[i].append(0)
                
        for i in range(len(ND_List)):
        #We need to reset the list since we're overwriting it later.
            ND = ND_List[i]
            Nd = fdNd[1]
            Nd = int(math.floor(Nd * ND))
            for j in range(len(NC_List)):                
                NC = NC_List[j]
                #Number of training samples we need
                Ntrain = 10*NC*ND
                #Number of test samples
                Ntest = Ntrain    
                #The total number of times to run the experiment 
                NExperiments = 1
                    
                #Generate a joint probability table P(c, d)
                Ppop = Probability.form_prob(ND, Nd, NC, fd)
                #Compute the prior class probabilities from the generate joint probabilities.
                Cpriors = DecisionRule.compute_class_priors(ND, NC, Ppop)
                #Generate the gain matrix from the number of classes
                gain_matrix = DecisionRule.GenerateGainMatrix(NC)
                #Store the expected gain [Gain_training, Gain_testing]
                expected_gain_matrix[i][j] = Experiment.experimental_stat(NExperiments, ND, NC, Ppop, Cpriors, gain_matrix, Ntrain, Ntest)
    
        #Set up a matrix to hold all that data
        testing_expected_gain_matrix = np.array([])
        testing_expected_gain_matrix = np.resize(testing_expected_gain_matrix, (len(ND_List), len(NC_List)))
        
        #Grab only the testing set expected gain entries
        for i in range(len(ND_List)):
            for j in range(len(NC_List)):
                egaintuple = expected_gain_matrix[i][j]
                #Get the expected gain for only the testing set
                test_egain = egaintuple[0][1]
                testing_expected_gain_matrix[i][j] = np.array(test_egain)
        #Plot
        fig3 = plt.figure()
        title = "Testing Set Expected Gain (fd= " + str(fd) + ", Nd = " + str(fdNd[1]) + ")"
        fig3.text(.2, .95, title) 
        ax = Axes3D(fig3)
       
        Y = np.array(ND_List)
        X = np.array(NC_List)
        X, Y = np.meshgrid(X, Y) 
        cset2 = ax.plot_wireframe(X, Y, testing_expected_gain_matrix)
    
        ax.set_xlabel("NC")
        ax.set_ylabel("ND")
        ax.set_zlabel("Testing Expected Gain")
        plt.show()
    '''
# -- The following code executes upon command-line invocation
if __name__ == "__main__": main(sys.argv)