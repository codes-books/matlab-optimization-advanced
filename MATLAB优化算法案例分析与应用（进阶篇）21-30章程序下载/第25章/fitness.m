% Shaffer's函数的最小值
% f(x)=0.5+(sin(sqrt(x1^2+x2^2))^2-0.5)/(1.0+0.001(x1^2+x2^2))^2
% 目标函数--适应度函数
function costy = fitness(x)
costy = 0.5 + (sin(sqrt(x(1)^2+x(2)^2))^2-0.5)/(1.0+0.001*(x(1)^2+x(2)^2))^2;


