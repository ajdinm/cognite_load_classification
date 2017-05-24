x = [5     1;
     6    -1;
     7     3;
     1     7;
     2     8;
     3     8];
 sigma = 1;
 
 x = gaussian_kernel(x, sigma);
y = [1 1 1 0 0 0]';

[w, b] = quad_fitcsvm(x, y);

positive_test = [6 -5; 5 1];
negative_test = [2 10; 3 8];
% validation_set = [positive_test;negative_test];
validation_set = x;
% validation_labels = [1 1 0 0]';
validation_labels = y;

hits = 0;
for i = 1:size(validation_labels, 1)
    if quad_predict(w, b, validation_set(i,:)) == validation_labels(i)
        hits = hits + 1;
    end
end
hits/length(validation_labels)
 