addpath(genpath('BCT folder goes here'))
addpath(genpath('ETC code'))

%% Calculate ISD

% Place your noGSR BOLD data here
BOLD_data_noGSR = randn(2000,450);
% Place your GSR BOLD data here
BOLD_data_GSR = randn(2000,450); 

% create noGSR FC matrix
FC_noGSR = corr(BOLD_data_noGSR);       
% create GSR FC matrix here
FC_GSR = corr(BOLD_data_GSR);           

ISD = ISD_calculation(FC_noGSR,FC_GSR);

%% Calculate metastability

% Your BOLD timeseries goes here
BOLD_data_noGSR = randn(2000,450);
window_size = 100;

% Calculate metastability
metastability = metastability_calculation(BOLD_data_noGSR,window_size);

%% Calculate pattern complexity

% Your BOLD timeseries goes here
BOLD_data_noGSR = randn(2000,450);
window_size = 100;

pattern_complexity = pattern_complexity_calculation(BOLD_data_noGSR,window_size);
