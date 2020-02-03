% ANALYSIS OF DATA FROM MNIST SCANNING


%   Removes previously stored variables
clear all;
%   Loads the recorded coordinates datasets
load(uigetfile);
image_directory = uigetdir('.','Select Image Directory');

%   Create a variable for each condition
randscan = coordinates;
%age = coordinates{2};
%wealth = coordinates{3};

%   Select the painting scanned & resize it
%       UI selection
cd(image_directory);
%       stores image as variable from path generated above
mnist = imread(mnist);
%       resizes image stored in variable above
mnist = imresize(mnist, [400 400]);  

%   Plot all data points on the selected painting using 'pointplot' function
pointplot(randscan, mnist);
%pointplot(age, painting);
%pointplot(wealth, painting);
