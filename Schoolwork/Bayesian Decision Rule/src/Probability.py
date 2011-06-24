'''
Author: Joel Kemp
Pattern Recognition 
Bayesian Classification Project
Prof. Haralick
Fall 2010
'''

import random
class Probability():
    '''
    Purpose: This class contains all methods used to construct a probability table determined by
    the number of classes and measurements in a system.
    '''
    @staticmethod
    def form_prob(num_measurements, num_dominant_class_measurement, num_classes, dominant_fraction):
        '''
        Purpose: Computes the conditional probabilities of all measurements given classes.
        Returns: A list of conditional probabilities of size NC x ND 
        '''
        #random.seed(100)
        randVarsND = []             #List of random variables for all measurements
        randVarsNC = []             #List of random variables for classes for each measurement
        sumRandomVarsND = 0         #Sum of random numbers for measurements
        sumListRandomVarsNC = []    #List of the Sums of random variables for classes for each measurement
        pListND = []                #Probabilities for each measurement
        PCkGivenD = []              #Conditional probabilities for "dominant" class given measurement
        PCjGivenD = []              #Conditional probabilities for all classes given measurement
        
        #Generate the random variables for all measurements  <r1, r2, ..., rND>
        randVarsND = Probability.GenerateRandomVariables(num_measurements)
        sumRandomVarsND = Probability.GetSumRandomVariables(randVarsND)
        #Generate the probability of every measurement {P(d0), P(d1), ..., P(dND)}
        pListND = Probability.GenerateProbabilitiesOfMeasurements(num_measurements, randVarsND, sumRandomVarsND)
        
        #Generate class probabilities for each dominant measurement
        #For every dominant measurement    Ddom = {d0, d1, ..., dDOM}
        for d in range(num_dominant_class_measurement):
            #Compute random variables for the classes     <r0, r1, ..., rNC>
            randVarsNC.append(Probability.GenerateRandomVariables(num_classes))
            sumListRandomVarsNC.append(Probability.GetSumRandomVariables(randVarsNC[d]))
        
        #For each dominant measurement, find the special class cK.
        kList = Probability.GetSpecialClassKOfMeasurements(num_dominant_class_measurement, randVarsNC, num_classes)
        #Compute the conditional probabilities P(cK, d)        
        PCkGivenD = Probability.GenerateClassKProbabilitiesOfMeasurements(num_dominant_class_measurement, pListND, kList, dominant_fraction, randVarsNC)
            
        #Compute the conditional probability for each class given each dominant measurement (num_class x num_dom) P(cj, d)
        #Note: PCjGivenD does not include P(cK, d) for the special class K.
        PCjGivenD = Probability.GenerateClassProbabilitiesOfMeasurements(num_dominant_class_measurement, pListND, kList, PCkGivenD, num_classes, randVarsNC, sumListRandomVarsNC)
                
        #Generate random class variables for all non-dominant measurements. 
        #Also compute the sums of each set of variables for each non-dominant measurement.
        num_non_dominant_class_measurement = num_measurements - num_dominant_class_measurement
        sumListRandomVarsNCNonD = []
        randVars_NCNonDom = []
                   
        for d in range(num_non_dominant_class_measurement):
            #Compute the random variables for the classes
            randVars_NCNonDom.append(Probability.GenerateRandomVariables(num_classes))
            #TODO: Test THis!!!!
            #randVars_NCNonDom.append(Probability.GenerateRandomVariablesClasses(num_classes))
            sumListRandomVarsNCNonD.append(Probability.GetSumRandomVariables(randVars_NCNonDom[d]))
    
        pListNonDom = []
        #Isolate the probabilities for those non-dominant measurements
        for nd in range(num_dominant_class_measurement, num_measurements):
            pListNonDom.append(pListND[nd])
        #Compute conditional probabilities for non-dominant measurements given a class.
        PDGivenCk = Probability.GenerateMeasurementProbabilitiesofClasses(num_non_dominant_class_measurement, num_classes, pListNonDom, randVars_NCNonDom, sumListRandomVarsNCNonD)
        
        #Create a complete probability table from both PCjGivenD and PDGivenCk (NC x ND)
        pComplete = []
        #Create the matrix dimensions (NC x ND)
        for c in range(num_classes):
            pComplete.append([])
            for d in range(num_measurements):
                pComplete[c].append([])
                
        #Place the dominant probabilities P(cJ, D)
        for d in range(num_dominant_class_measurement):
            for c in range(num_classes):
                pComplete[c][d] = PCjGivenD[c][d]
        
        #Place the dominant probabilities for special class K P(cK, d)
        for d in range(num_dominant_class_measurement):
            #Find the special class K for the measurement
            K = kList[d]
            pComplete[K][d] = PCkGivenD[d]
            
        #Place the non-dominant probabilities 
        for d in range(num_dominant_class_measurement, num_measurements):
            for c in range(num_classes):
                #PDGivenCk only contains indices 0 to NonDom, so offset the index
                pComplete[c][d] = PDGivenCk[c][d - num_dominant_class_measurement]
        
        return pComplete

    @staticmethod
    def gen_sample_from_prob(num_measurements, num_classes, num_sample, prob_table):
        '''
        Purpose: Generates a sample from the datapoints in the probability table.
        Returns: A sample generated from the probability table as a list of (class, measurement) pairs
        '''
        
        #The total number of entries in our table
        #Why do we need this?
        #Z = num_measurements * num_classes
        
        #The set of samples as (c, d) pairs
        S = []
        
        #For as many samples as we need,
        for i in range(num_sample):
            #Randomly generate a number between 0 and num_classes
            randC = random.randint(0, num_classes-1)    #Off by one
            #Randomly generate a number from 0 to num_measurements
            randD = random.randint(0, num_measurements-1)
            #Make the pair that will correspond to some entry in our prob_table
            sample = [randC, randD]
            S.append(sample)
        
        return S    
    
    @staticmethod
    def est_prob(num_measurements, num_classes, samples):
        '''
        Purpose: Using the training data, try to compute conditional probabilities.
        Returns: A matrix for that contains conditional probabilities for each measurement
            given a class. (NC x ND)
        '''
        
        #We need the count of each sample
        count = []
        #Prepare the matrix
        for c in range(num_classes):
            count.append([])
            for d in range(num_measurements):
                count[c].append(0)
        
        #Go through all the samples
        for s in samples:
            s_class = s[0]
            s_d = s[1]
            #Increment the count of the sample in the count matrix
            count[s_class][s_d] += 1
    
        #Compute the conditional probabilities P(d,c)
        PDGivenC = []
        #Prepare the matrix
        for c in range(num_classes):
            PDGivenC.append([])
            for d in range(num_measurements):
                PDGivenC[c].append(0)
        
        num_samples = len(samples)
        for c in range(num_classes):
            for d in range(num_measurements):
                #Get the number of occurrences for the class measurement pair
                numOcc = count[c][d]
                #Compute the P(d, c)
                PDGivenC[c][d] = float(numOcc) / num_samples
        
        return PDGivenC   
    
     
    @staticmethod
    def GenerateRandomVariables(num_variables):
        '''
        Purpose: Generates uniformly random variables for each requested variable. 
        Returns: A list of random variables of size num_variables
        '''
        randomVars = []
        sum = 0;
        #Generate the random variables for all measurements  <r1, r2, ..., rND>
        for i in range(num_variables):
            #Generate a random number between 0 and 1
            randNum = random.uniform(0,1) #Round the numbers to three decimal places
            #Add that random number to the list
            randomVars.append(randNum)
            #print "r" , i , ": ", randNum                       #DEBUG
            #Add the random number to the sum of random numbers
            sum += randNum;
        
        #Normalize the random numbers to sum to 1
        #Sum up the random numbers and divide each number by the sum
        for i in range(num_variables):
            randomVars[i] = randomVars[i] / sum;
        
        return randomVars
    
    @staticmethod
    def GetSumRandomVariables(random_vars):
        '''
        Purpose: Sum the random variables in the passed list.
        Returns: The sum of the random variables.
        '''
        sum = 0
        for rv in random_vars:
            sum += rv
        return sum
    
    @staticmethod
    def GenerateProbabilitiesOfMeasurements(num_measurements, random_vars, randomSum):
        '''
        Purpose: Generates the probability of each measurement by way of the
            passed in random variables.
        Returns: A list of the probabilities for each measurement.
        '''
        pList = []
        #Generate the probability of every measurement pList = {P(d0), P(d1), ..., P(dND)}
        for i in range(num_measurements):
            #Compute the probability of the measurement  P(di) where 0 <= i <= ND
            rvar = random_vars[i]
            p = rvar / randomSum
            pList.append(p)       
            #print "P(d,", i, ") = ", pList[i]  
        return pList
        
    @staticmethod
    def GetSpecialClassKOfMeasurements(num_measurements, random_vars_classes, num_classes):    
        '''
        Purpose: Determine the number K of the class that satisfies the equation 
            (k-1)/NumClasses <= r0 <= k/NumClasses
            for each measurement in the num_measurements.
        Returns: A list of integers corresponding to the special class for each measurement.
        '''
        
        kList = []   #List of special class index k for each dominant measurement
        
        #For every measurement
        for d in range(num_measurements):
            #Generate a random int between 0 and num_classes - 1 (we use this number as the index)
            rnum = random.randint(0, num_classes - 1)
            #Class K for the current measurement is that random number.
            kList.append(rnum)
        print "KList:", kList
        #=======================================================================
        # for d in range(num_measurements):    
        #    #Find k that satisfies (k-1)/NumClasses <= r0 <= k/NumClasses
        #    r0 = random_vars_classes[d][0]   #The first random number for the current measurement
        # 
        #    '''
        #    Find the kth class. If k = 2, then the special class is the second class, not the class at index 2!
        #    Notes:
        #    Loop starts from 1 since we're looking at k-1 
        #    Loop ends at the num_classes (+1 to account for range) since we know r0 < 1
        #        and since num_classes/num_classes = 1, it makes no sense for us
        #        to iterate beyond num_classes because 1 is not < r0
        #    '''
        #    for j in range(1, num_classes + 1):
        #        left = (j-1) / num_classes
        #        right = j / num_classes
        #        #If this k satisfies our equation
        #        if(left <= r0 and r0 <= right):
        #            #Remember the special class number! This is not the index! 
        #            #The klist index corresponds to the dominant measurement index
        #            kList.append(j)
        #            break
        #=======================================================================
        return kList
        
    @staticmethod
    def GenerateClassKProbabilitiesOfMeasurements(num_measurements, pListND, kList, dominant_fraction, random_vars_classes):
        '''
        Purpose: Generate class probabilities for each measurement passed in.
        NOTES: For each measurement, we want a different probability distributions for the classes. 
            Hence, why we generate new random variables for each class for every measurement.
        Returns: A list of Conditional Probabilities P (cK, d) for d in ND.
        '''
        print "Special Class K Probabilities"
        pCKGivenD = []
        for d in range(num_measurements):
            #Compute the conditional probability of the special class k given the measurement d     P(ck, d)
            PD = pListND[d]    #Cache the probability of the current measurement d
            
            #Get the special class index for the current measurement 
            PDk = kList[d]
            #To get the list index for that class, we need to subtract 1 from k
            #kIndex = PDk - 1
            #Get the random variable for the special class of the current measurement
            rK = random_vars_classes[d][PDk]
            pcd = (0.9 + (0.1*rK)) * (dominant_fraction * PD)
            #Compute the conditional probability for that special class given d    P(ck, d)
            pCKGivenD.append(pcd)
            print "P(c", PDk, ",", "d", d, ") = ", pCKGivenD[d]
        return pCKGivenD

    @staticmethod
    def GenerateClassProbabilitiesOfMeasurements(num_measurements, pListND, kList, PCkGivenD, num_classes, random_vars_classes, sum_random_vars_classes):
        '''
        Purpose: Compute the conditional probability for each class given 
            each dominant measurement  P(cj, d)
        Returns: A (num_class x num_dom) matrix containing the P(cj, d) 
        '''
        PCjGivenD = []
        #Create the probability matrix first (NC x NDom)
        for c in range(num_classes):
            PCjGivenD.append([])
            for d in range(num_measurements):
                PCjGivenD[c].append([])
        
        #For each dominant measurement d
        for d in range(num_measurements): 
            #Get special index K for the current measurement
            PDk = kList[d]
            #For each class
            for c in range(num_classes):
                #Exclude computing conditional probabilities for cK
                if c != PDk:
                    #Get the conditional probability P(cK, d)
                    PcKD = PCkGivenD[d]
                    #Get the probability of the measurement P(d)
                    PD = pListND[d]
                    #Get the sum of random class variables for this measurement 
                    R = sum_random_vars_classes[d] 
                    #Get the random variable for this class with this measurement
                    rJ = random_vars_classes[d][c]
                    #Compute P(cj, d)
                    PCjGivenD[c][d] = (PD - PcKD) * (rJ / R)
        
        print "P(cJ, d)"
        for c in range(num_classes):
            print "c", c, PCjGivenD[c]
        
        return PCjGivenD
    
    @staticmethod
    def GenerateMeasurementProbabilitiesofClasses(num_measurements, num_classes, pListND, random_vars_classes, sum_random_vars):
        '''
        Purpose: Compute the conditional probabilities for each measurement given a class. 
        Returns: A list of the conditional probabilities of size (NC x ND).
        '''
        PDGivenCk = []
        #Prepare the matrix  (num_classes x num_measurements)
        for c in range(num_classes):
            PDGivenCk.append([])
            for d in range(num_measurements):
                PDGivenCk[c].append([])
        
        #For every measurement
        for d in range(num_measurements):
            for c in range(num_classes):
                #Get the probability of the current measurement P(d)
                PD = pListND[d]
                #Get the random variable for the current class of the current measurement rK 
                rK = random_vars_classes[d][c]
                #Get the current sum of the random class variables for the current measurement 
                R = sum_random_vars[d]
                #Compute the conditional probability of the measurement D given class C. P(d, cK)
                PDGivenCk[c][d] = PD * (rK / R)
        
        print "P(d, cK)"
        for c in range(num_classes):
            print "c", c, PDGivenCk[c]
        return PDGivenCk