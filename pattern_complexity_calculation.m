function C_patt = pattern_complexity(BOLD_data,window_size)

% Vary k from 3 to 100
k_list = 3:100;
k_num = numel(k_list);
replicates = 1;

% Preallocate sequence index matrix
idx = nan(height(BOLD_data),k_num);

for k = 1:k_num
    K = k_list(k);
    [~,centroid] = kmeans(BOLD_data,K,'distance','correlation','Replicates',replicates);
    distances = pdist2(BOLD_data, centroid, 'correlation');
    [~, idx(:,k)] = min(distances, [], 2);
end

% Calculate entropy of pattern occurrence

H_patt = nan(k_num,height(BOLD_data));

for k = 1:k_num
    K = k_list(k);
    for t = 1:height(BOLD_data)
        start_time = max(1,round(t-window_size/2));
        end_time = min(height(BOLD_data),round(t+window_size/2));

        dat = squeeze(idx(start_time:end_time,k));

        patt_matrix = histcounts(dat,0.5:1:K+0.5)./(numel(dat));
        H_patt(k,t) = (-sum(patt_matrix.*log2(patt_matrix+eps)))./log2(K+eps);
    end
end

% Calculate entropy of transition matrix

H_TM = nan(k_num,height(BOLD_data));

for k = 1:k_num
    K = k_list(k);
    for t = 1:height(BOLD_data)
        start_time = max(1,round(t-window_size/2));
        end_time = min(height(BOLD_data),round(t+window_size/2));

        dat = squeeze(idx(start_time:end_time,k));
        dat = dat(~isnan(dat));
                    
        TM = zeros(K,K); % transition matrix
        for tt = 2:numel(dat)
            TM(dat(tt-1),dat(tt)) = TM(dat(tt-1),dat(tt))+1;
        end
        TM = (TM+eps)./sum(TM,'all'); % Normalize

        H_TM(k,t) = (-sum(TM .* log2(TM),'all'))./log2(numel(TM));
    end
end

% Calculate effort to compress

ETC_val = nan(k_num,height(BOLD_data));

for k = 1:k_num
    K = k_list(k);
    parfor t = 1:height(BOLD_data)
        start_time = max(1,round(t-window_size/2));
        end_time = min(height(BOLD_data),round(t+window_size/2));

        dat = squeeze(idx(start_time:end_time,k));
        dat = dat(~isnan(dat));
                    
        ETC_max = numel(dat)-1;

        ETC_val(k,t) = ETC(dat)./ETC_max;
    end
end

% Calculate pattern complexity

C_patt = (mean(H_patt,2) + mean(H_TM,2) + mean(ETC_val,2))./3;

end

