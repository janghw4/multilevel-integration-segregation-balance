addpath(genpath('BCT folder goes here'))

% Place your noGSR BOLD data here
BOLD_data_noGSR = randn(2000,450);
% Place your GSR BOLD data here
BOLD_data_GSR = randn(2000,450); 

% create noGSR FC matrix
FC_noGSR = corr(BOLD_data_noGSR);       
% create GSR FC matrix here
FC_GSR = corr(BOLD_data_GSR);           

ISD = ISD_calculation(FC_noGSR,FC_GSR);