% Simulation of Brownian Motion
% Input : t (Time vector), n (No. of samples)
% Author : abhiruplahiri@yahoo.com

function [w] = simbrownian(t,n)
randn('state',100);    % setting state for repeated simulations give same result 
dt=t/n;
w=zeros(1,n);
dw=zeros(1,n);
w(1)=0;
for j=2:n
    w(j)=w(j-1)+sqrt(dt)*randn;
end
% plot([dt:dt:t],w,'r-')    
% grid
