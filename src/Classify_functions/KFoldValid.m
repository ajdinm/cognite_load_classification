function [ idx ] = KFoldValid(k,N)
%k=num of k folds
%N= num of observation

k=int32(k);
G=k*2;
N=int32(N);
temp=N;
for i=1:G
    EqualParts(i)=idivide(temp,G+1-i,'round');
    temp=N-sum(EqualParts);
end

idx=randperm(N);
evens=idx(mod(idx,2)==0); %Even number = 0's
odds=idx(mod(idx,2)~=0); %Odd numbers = 1's

Start=1;
Stop=EqualParts(1);
idx = cell(k,1);
for i = 1:k
    idx{i,1} = [evens(Start:Stop), odds(Start:Stop)];
    Start=Stop+1;
    Stop=sum(EqualParts(1:i+1));
end

   