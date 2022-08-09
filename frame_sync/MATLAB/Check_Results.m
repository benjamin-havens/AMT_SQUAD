% Check frame sync results
% Calculates the difference between max indices in the hope that they 
% are 6656 samples apart, indicating good frame synchronization

results = L0_res; % Change to use different results
cutoff = 5e6; % Change if the graph looks like a different cutoff is better
max_num = size(results(results > cutoff));
max_num = max_num(1);

diffs = zeros(max_num - 1, 1);
[maxes, max_idxs] = maxk(results, max_num);
max_idxs = sort(max_idxs);
for idx = 1:max_num - 1
    diffs(idx) = max_idxs(idx + 1) - max_idxs(idx);
    if (diffs(idx) ~= 1 && ...
            mod(diffs(idx), 6656) && ...
            mod(diffs(idx), 6656) ~= 1 && ...
            mod(diffs(idx), 6656) ~= 6655 && ...
            mod(diffs(idx), 16) ~= 15 && ...
            mod(diffs(idx), 16))
        fprintf("Between %d and %d, there are an irregular %d indices.\n", ...
            max_idxs(idx), max_idxs(idx + 1), diffs(idx))
    end
end