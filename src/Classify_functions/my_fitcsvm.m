function [ w, b ] = my_fitcsvm( x, y )
%fitcsvm Trains SVM for set of observations X and their lables Y
%   Detailed explanation goes here

y(y == 0) = -1; % for implementation purposes

opt_norm = inf;
opt_w = [];
opt_b = [];

vector_directions = [1 1; -1 1; -1 -1; 1 -1];
max_feature_val = max(max(x));

step_sizes = [0.1, 0.01, 0.001];
step_sizes = max_feature_val * step_sizes;

b_range = 5;
latest_optimum = max_feature_val * 10;

for i = 1:length(step_sizes)
    w = [latest_optimum, latest_optimum];
    improved = false;
    step = step_sizes(i);
    while improved == false
        % try all b
        max_b = max_feature_val * b_range; % assume max_f_v > 0
        min_b = -1 * max_b;
        b_step = step * b_range;
        for b = min_b:b_step:max_b
            for direction = 1:size(vector_directions, 1)
                w_t = w .* vector_directions(direction,:);
                found_option = true;
                % check constrains; for each observation i
                % yi * (w_t . xi) + b must be >= 1
                
                w_temp = repmat(w_t, [size(x, 1), 1]);
                constraints = dot(w_temp', x')'; % each row has w_t . xi
                constraints = constraints + b; % dot(...) + b
                constraints = y .* constraints; % yi * (dot(...) + b)
                
                if size(find(constraints < 1), 1) > 0
                    found_option = false;
                end
                if found_option
                    temp_norm = norm(w_t);
                    if temp_norm < opt_norm
                        opt_norm = temp_norm;
                        opt_w = w_t;
                        opt_b = b;
                    end
                end
            end
        end
        if w(1)  < 0
            improved = true;
%             'step improved'
        else
            w = w - step;
        end
    end
    latest_optimum = w(1) + step * 2;
end
w = opt_w;
b = opt_b;
end

