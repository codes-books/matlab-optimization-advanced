% geometric_brownian(N,r,alpha,T) simulates a geometric Brownian motion 
% on [0,T] using N normally distributed steps and parameters r and alpha


function [X] = geometric_brownian(N,r,alpha,T)
t = (0:1:N)'/N;                   % t is the column vector [0 1/N 2/N ... 1]
W = [0; cumsum(randn(N,1))]/sqrt(N); % S is running sum of N(0,1/N) variables
t = t*T;
W = W*sqrt(T);
Y = (r-(alpha^2)/2)*t + alpha * W;
X = exp(Y);
end