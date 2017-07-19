#! /bin/python

import numpy as np
from matplotlib import pyplot as plt
import matplotlib 
import os
import sys

def watplot(path):
    plotpath='plots_output'
    if not os.path.exists(plotpath):
        os.makedirs(plotpath)
    
    patch = str(path[7:10])
    fld = str(path[7:11])
    #patch = patch + '1'
    #print str(path[12:22]) + patch 
    
    fh = np.genfromtxt(path)
    x = fh[:,0]
    y = fh[:,1]

    #print "fld is", fld
    #print "Patch is", patch

    if fld == 'inv1':

        z = fh[:,2]

        plt.scatter(x,z)
        plt.xlabel('Inversion Coordinate 1')
        plt.ylabel('Bondlength difference')
        plt.savefig(plotpath+'/'+str(path[12:22])+patch+ '1')
        #plt.show()

        plt.scatter(y,z)
        plt.xlabel('Inversion Coordinate 2')
        plt.ylabel('Bondlength difference')
        plt.savefig(plotpath+'/'+str(path[12:22])+patch+ '2')
        #plt.show()
        
    elif fld == 'eigi': 
         
        fld = str(path[24:27])
        #print fld

        if fld=="tim":
            plt.plot(x,y, label="Time Series")
            plt.xlabel('Bins ')
            plt.ylabel('Probabilities')
            plt.title("timeseries")
            plt.legend() 
            plt.savefig(plotpath+'/'+str(path[14:27]))

        else:

            plt.plot(x,y)
            plt.xlabel('Bins ')
            plt.ylabel('Probabilities')
            plt.savefig(plotpath+'/'+str(path[14:23])+'inv')


    else:

        plt.scatter(x,y)
        plt.xlabel('Bondlength ')
        plt.ylabel('Cosine $\Theta$')
        plt.savefig(plotpath+'/'+str(path[12:22])+patch)
        #plt.show()

if __name__ == '__main__':
    watplot(sys.argv[1])
