function sigma_R = metastability_calculation(BOLD_data,window_size)

% Preallocate the phase and order parameter matrix
phases = nan(height(BOLD_data),450);
order_param = nan(height(BOLD_data),1);

% Loop over each ROI
for roi = 1:width(BOLD_data)
    time_series = BOLD_data(:,roi);
    analytic_signal = hilbert(time_series);
    phases(:,roi) = angle(analytic_signal);
end

% Calculate the mean of the unit vectors
for t = 1:height(BOLD_data)
    order_param(t) = abs(mean(exp(1i * phases(t,:))));
end

% Calculate metastability using moving standard deviation
sigma_R = movstd(order_param,window_size);

end

