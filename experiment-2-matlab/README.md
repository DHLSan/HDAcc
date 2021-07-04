**Experiment #2**

Experiment Summary:
In our second experiment, we examined the change in the accuracy rate by making changes to our data set.

Experiment:

we performed an experiment whose dataset was more suitable for our study. 
The dataset we used in this MATLAB experiment was recorded by reading 5 different hand gesture from 4 different channels.
Since these recordings were directly from hand gestures, it was necessary to filter the EMG signals in the experiment.
The genfilter.m function was used to perform the filtering processes. Then, after this process, we run the genheat.m 
function to create a heat map. Then we ran the getacc.m function and performed the experiment. 
This dataset was also .mat extension, we made this dataset with excel extension to make it suitable for our own code
The work done in this experiment was developed over the following article and github link.

Article: A. Moin, A. Zhou, A. Rahimi, S. Benatti, A. Menon, S. Tamakloe, J. Ting, N. Yamamoto, Y. Khan, F. Burghardt, 
L. Benini, A. Arias, and J. Rabaey, "An EMG Gesture Recognition System with Flexible High-Density Sensors and 
Brain-Inspired High-Dimensional Classifier," 2018 IEEE International Symposium on Circuits and Systems (ISCAS), Florence, Italy, 2018.

Github: https://github.com/a-moin/flexemg
