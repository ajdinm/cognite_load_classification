function [ w, b ] = quad_fitcsvm( x, y )
%Finds largest marging hyperlane for dataset

 y(y == 0) = -1;

[n, p] = size(x);
H = eye(p+1);
H(p+1, p+1) = 0;
f = zeros(p+1, 1);

A = -[diag(y)*x y];
bb = -ones(n, 1);
options = optimoptions('quadprog','Display','off');
w = quadprog(H, f, A, bb,[],[],[],[],[], options);
b = w(end);
w = w(1:end-1);

end

