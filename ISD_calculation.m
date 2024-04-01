function [ISD,integration,segregation,ML_efficiency,ML_clustering] = ISD_calculation(FC_noGSR, FC_GSR)

% calculate multilevel efficiency and clustering at different thresholds
ML_efficiency = nan(1,100);
ML_clustering = nan(1,100);
for threshold = 1:100
    [~,ML_efficiency(threshold)] = charpath(distance_bin(FC_noGSR>threshold/100));
    ML_clustering(threshold) = mean(clustering_coef_bu(FC_GSR>threshold/100));
end

% calculate integration and segregation
integration = mean(ML_efficiency);
segregation = mean(ML_clustering);

% Calculate ISD (integration-segregation difference)
ISD = integration - segregation;

end

