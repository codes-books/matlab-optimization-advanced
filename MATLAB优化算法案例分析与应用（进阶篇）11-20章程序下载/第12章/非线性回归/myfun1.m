function f = myfun1(xs,xdata)
% global X0 X1 X2 X3 X4 X5 X6
a1 = xs(1); % 植被因子C 系数
a2 = xs(2); % 入流流量Q 系数
b = xs(3);  % 入流流量Q 指数
a3 = xs(4); % 土壤初始含水量因素 系数
a4 = xs(5); % SS入流浓度 系数
a5 = xs(6); % 带宽因素m  系数
a6 = xs(7); % 坡度因素%  系数
a7 = xs(8); % 常数项     系数
X1 = xdata(:,1);  X2 = xdata(:,2);  X3 = xdata(:,3);
X4 = xdata(:,4);  X5 = xdata(:,5);  X6 = xdata(:,6);
f = a1*X1+a2*(X2).^(b)+a3*X3+a4*X4+a5*log(X5)+a6*X6+a7;
