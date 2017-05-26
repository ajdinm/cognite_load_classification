function [ prediction,score ] = quad_predict( w, b, x)
%quad_predict Predicts class of x

%Y=(w*x+b)/w(end); %Seperating hyperplane 
prediction = sign(dot(w, x) + b);
score=dot(w,x)+b;
if prediction < 0
    prediction = 0;
end

end

