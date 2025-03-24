This folder consists of the relevant files used to generate the 2 datasets in this project, TrainingData and UnknownScenariosData. 


TrainingData is used to test out the various segmentation models and identify the best candidate for this project. 
It is also used to train the inductive-based transfer learning model which uses the best candidate segmentation model, hyperparmeter tuned to achieve better results.


UnknownScenariosData is a variant of TrainingData that introduces more interferences, a wider range of parameters values and more types of fadings too. 
This dataset is then used to test the inductive model, trains and evaluates the hybrid model (which introduces elements of transductive transfer learning to the inductive model).


The file "helperSpecSenseTrainingData" is substituted with "helperSpecSenseTrainingData_additional_params" to generate the "UnknownScenariosData" dataset.


These files were inspired by MathWorks' "Spectrum Sensing with Deep Learning to Identify 5G and LTE Signals" project which was fully done in MATLAB: https://www.mathworks.com/help/comm/ug/spectrum-sensing-with-deep-learning-to-identify-5g-and-lte-signals.html
