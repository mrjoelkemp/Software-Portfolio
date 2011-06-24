'''
Author: Joel Kemp
Pattern Recognition 
Bayesian Classification Project
Prof. Haralick
Fall 2010
'''
import random

class DecisionRule():
    '''
    Purpose: Contains all functions pertaining to a Bayesian decision rule.
    '''

    @staticmethod
    def construct_dec_rule(gain_matrix, num_measurements, num_classes, prob_table, class_priors, true_classes, assigned_classes):
        '''
        Purpose: Generate the decision for classes for each measurement.
        Returns: A list of classes for each measurement.
        Note: 
            This class really doesn't do anything useful. The assigned classes will always win
            because they have the higher probabilities (hence, the reason why they were assigned to begin with).
            
            This function should just return the assigned classes.
        '''           
        
        H = []  #Holds the output of the decision rule for each measurement
        for d in range(num_measurements):
            Ctrue = true_classes[d]
            Cassign = assigned_classes[d]
            #The probability of the true class given d  P(cT, D)
            PCTrueD = prob_table[Ctrue][d]
            #The probability of the assigned class given d  P(cA, D)
            PCAssignedD = prob_table[Cassign][d]
            #The economic gain of the choices  e[cT, cA]
            eCTrueCAssign = gain_matrix[Ctrue][Cassign]
            #Compute the probability of choosing the true class
            PCTrue = PCTrueD * eCTrueCAssign
            #Decide the class with the larger probability
            #If the true class yields a higher probability
            if PCTrue > PCAssignedD:
                #This measurement belongs to the true class
                H.append(Ctrue)
            else:
                #This measurement belongs to the assigned class 
                H.append(Cassign)
        return H
    
    @staticmethod
    def eval_dec_rule(num_measurements, num_classes, prob_table, decision_list, class_priors, true_classes, assigned_classes):
        '''
        Purpose: Evaluate the decision rule by generating the contingency matrix.
        Returns: The contingency table (NC x NC)
        '''
        contingency_matrix = []
        #Prepare the contingency matrix
        for c in range(num_classes):
            contingency_matrix.append([])
            for c2 in range(num_classes):
                contingency_matrix[c].append(0)
       
        #=======================================================================
        # #Get the true class for each measurement       
        # true_classes = DecisionRule.GenerateTrueClasses(num_measurements, num_classes, prob_table)
        # #Get the assigned class for each measurement
        # assigned_classes = DecisionRule.GetAssignedClasses(num_measurements, num_classes, prob_table)
        #=======================================================================
       
        #For each measurement where the decision was for the assigned class
        #sum up the P(cTrue, d) and place it in the T[cTrue, cAssign] entry in the contingency table.
        #The sum of the probability of the P(Ctrue, d)
        
        #For all measurments
        for d in range(num_measurements):
            #Get the assigned class for measurement d
            hD = decision_list[d]
            
            #For each class
            for c in range(num_classes):
                #Get the P(c, d)
                p = prob_table[c][d]
                #Populate the contingency matrix
                '''
                Note: If the current class == assigned class
                        The P(c, d) should go in contingency[assigned][assigned]
                      Otherwise:
                        The P(c, d) should go in contingency[current][assigned]
                    However, this can be accomplished by simply doing the latter. 
                '''
                contingency_matrix[c][hD] += p
                #Check if the assigned class is the current class
                '''
                if c == hD:
                    contingency_matrix[c][c] += p
                #Otherwise, if the chosen class was not the current class
                elif c != hD:
                    contingency_matrix[c][hD] += p
                
            #Get the true class for d
            cTrue = true_classes[d]
            #Get the assigned class for d
            cAssigned = assigned_classes[d]
            #Get the P(cTrue, d)
            pCTrueGivenD = prob_table[cTrue][d]
            #pCAssignedGivenD = prob_table[cAssigned][d]
            #If the measurement's decided class was the assigned class
            if hD == cAssigned:
                #Add P(cTrue,d)
                contingency_matrix[cTrue][cAssigned] += pCTrueGivenD
                #contingency_matrix[cTrue][cAssigned] += pCAssignedGivenD
        '''
            
        return contingency_matrix
        
    @staticmethod
    def expected_gain(num_classes, contingency_table, gain_matrix):
        '''
        Purpose: Computes the expected gain of the contingency matrix.
        Returns: The Expected Gain number.
        '''
        gain = 0
        
        #Compute the expected gain
        for cTrue in range(num_classes):
            for cAssign in range(num_classes):
                tctca = contingency_table[cTrue][cAssign]
                ectca = gain_matrix[cTrue][cAssign]
                #Sum the products
                gain += tctca * ectca
    
        print"Expected Gain:", gain
        return gain
    
    @staticmethod
    def compute_class_priors(num_measurements, num_classes, prob_table_est):
        '''
        Purpose: Compute the prior class probabilities
        Returns: A list of prior class probabilities (NC x 1)
        '''
        Q = []
        for c in range(num_classes):
            Q.append(0)
            for d in range(num_measurements):
                Q[c] += prob_table_est[c][d] 
    
        print "Class Priors", Q
        return Q
    
    @staticmethod
    def GenerateGainMatrix(num_classes):
        '''
        Purpose: Generates the identity gain matrix
        Returns: The Gain Matrix
        '''
        gain_matrix = []
        for c in range(num_classes):
            gain_matrix.append([])
            for c2 in range(num_classes):
                gain_matrix[c].append(0)
        
        #Make the diagonal 1 for each item
        for c in range(num_classes):
            gain_matrix[c][c] = 1
        
        return gain_matrix
    
    @staticmethod
    def GenerateTrueClasses(num_measurements, num_classes, prob_table):
        '''
        Purpose: Uses the bayes formula to find the true class for each measurement.
        Returns: A list containing a true class index for each measurement
        Notes:
            We already have P(c, d) from our probability table, but this function
            attempts to generate the true class for the measurement using Bayes formula.
        '''
        
        #Assign a random class as the true class.
        trueClasses = []
        for d in range(num_measurements):
            #Generate a random number between 0 and the number of classes - 1
            rnum = random.randint(0, num_classes - 1)
            trueClasses.append(rnum)
            
        #=======================================================================
        # #Get the class probabilities given the measurements
        # PCGivenD = DecisionRule.GetProbabilityClassGivenMeasurement(num_measurements, num_classes, prob_table, class_priors)
        #    
        # #Find the true class of each measurement
        # max_prob = 0
        # max_prob_index = 0
        # trueClasses = []
        # for d in range(num_measurements):
        #    for c in range(num_classes):
        #        #Get the current conditional probability
        #        cur_class_prob = PCGivenD[c][d]
        #        #Find the largest conditional class probability given measurement
        #        if cur_class_prob > max_prob:
        #            max_prob = cur_class_prob
        #            max_prob_index = c
        #         
        #    #Assign that class as the true class
        #    trueClasses.append(max_prob_index)
        # 
        # #Print generated probabilities
        # print "Bayesian Generated P(c, d)"
        # for c in range(num_classes):
        #    print "c", c, PCGivenD[c]
        #=======================================================================
        
        
        return trueClasses
    
    @staticmethod
    def GetProbabilityClassGivenMeasurement(num_measurements, num_classes, prob_table, class_priors):
        '''
        Purpose: Generate the Probability of a class given a measurement.
        Returns: A list of class probabilities for each measurement
        '''

        #Prepare the matrix
        PCGivenD = []
        for c in range(num_classes):
            PCGivenD.append([])
            for d in range(num_measurements):
                PCGivenD[c].append([])
    
        pListND = []
        #Generate the probability of the measurements P(d)
        for d in range(num_measurements):
            PD = 0
            for c in range(num_classes):
                #Get P(c)
                PC = class_priors[c]
                #Get conditional probability from the table
                pDGivenC = prob_table[c][d]
                #Compute P(d)
                PD += pDGivenC * PC
            pListND.append(PD)
                
        #Compute the conditional probability of the class given the measurement
        for d in range(num_measurements):
            for c in range(num_classes):
                #Get P(c)
                PC = class_priors[c]
                #Get P(d)
                PD = pListND[d]
                #Get P(d, c) from the probability table
                PDGivenC = prob_table[c][d]
                #Compute P(c, d)
                pcd = (PDGivenC * PC) / PD 
                PCGivenD[c][d] = pcd
        return PCGivenD
    
    @staticmethod 
    def GetAssignedClasses(num_measurements, num_classes, prob_table): 
        '''
        Purpose: Compute the assigned class for each measurement based
            on the probabilities of each class given the measurement. P(cJ, d)
        '''
        assignedClasses = []
        #For all the measurements
        for d in range(num_measurements):
            max_prob = 0        #The largest class probability
            max_prob_index = 0  #The index of the class
            #Find the class with the largest probability for the measurement
            for c in range(num_classes):
                cur_class_prob = prob_table[c][d]
                if  cur_class_prob > max_prob:
                    max_prob = cur_class_prob
                    max_prob_index = c
                    
            #Add the class index to the true class list.
            assignedClasses.append(max_prob_index)
    
        return assignedClasses