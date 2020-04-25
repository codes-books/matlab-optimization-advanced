function f = myfun(xs)
global X0 X1 X2 X3 X4 X5 X6
a1 = xs(1); % 植被因子C 系数
a2 = xs(2); % 入流流量Q 系数
b = xs(3);  % 入流流量Q 指数
a3 = xs(4); % 土壤初始含水量因素 系数
a4 = xs(5); % SS入流浓度 系数
a5 = xs(6); % 带宽因素m  系数
a6 = xs(7); % 坡度因素%  系数
a7 = xs(8); % 常数项     系数
f=0;
n = length(X0);
for i=1:n
    f = f + a1*X1(i)+a2*(X2(i))^(b)+a3*X3(i)+a4*X4(i)+a5*log(X5(i))+a6*X6(i)+a7 -X0(i);
end

