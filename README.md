# MSC_ActInf
This repository contains the crux of my research project with regards to my MSc in neuroimaging at King's College London (2019) .


  Here is the abstract from my submitted dissertation:

    Context: Current deep convolution neural networks treat vision as a static sequential readout
    of pixel information. Active inference defines an agent’s selection of policies (set of actions)
    as belief based. In sampling the environment, these beliefs are generatively update in order
    to minimize surprise.
    
    Objectives: We hypothesize human vision to be based upon the active inference framework
    as we actively seek out salient visual features. Therefore, we infer human vision to be a topdown
    process based on our current beliefs about the environment.
    
    Methods: A visual eye-tracking study was performed on healthy participants to analyse gaze
    scan paths in trying to identify a scene. The scenes contained partially obstructed handwritten
    digits from the MNIST database. To further test our hypothesis, we are developing a Markov
    Decision Process (MDP) computational model based on the active inference framework. The
    MNIST database was selected as this platform is a benchmark for computer vision algorithm
    testing. Behavioural data analysis was performed using a novel method we developed, taking
    inspiration from fMRI data analysis, whereby scan paths were converted to volumetric NIfTI
    format for SPM analysis.
    
    Results: In all tasks, participants showed better performance in trial duration and less scene
    exploration when prior beliefs created an expected scene identity.
    
    Conclusions: Our results support our hypothesis that human vision is a predictive top-down
    process, based on our prior beliefs, as per active inference. Results from our MDP model show
    how an agent learns to look for salient features for scene identification but is still in
    development.
    
   
   
Here, I share my entire work on this project: 

- The experimental paradigm I built for data collection (github.com/jonathanmonney/MSC_ActInf/tree/master/01-Paradigm)
- The data analysis methods (github.com/jonathanmonney/MSC_ActInf/tree/master/02-Data_Analysis)
- The submitted thesis (github.com/jonathanmonney/MSC_ActInf/blob/master/JM_thesis_N.pdf)



For any comments or questions, please contact me at jonathanmonney.jm@gmail.com.
