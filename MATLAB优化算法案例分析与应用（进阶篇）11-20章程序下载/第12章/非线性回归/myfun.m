function f = myfun(xs)
global X0 X1 X2 X3 X4 X5 X6
a1 = xs(1); % ֲ������C ϵ��
a2 = xs(2); % ��������Q ϵ��
b = xs(3);  % ��������Q ָ��
a3 = xs(4); % ������ʼ��ˮ������ ϵ��
a4 = xs(5); % SS����Ũ�� ϵ��
a5 = xs(6); % ��������m  ϵ��
a6 = xs(7); % �¶�����%  ϵ��
a7 = xs(8); % ������     ϵ��
f=0;
n = length(X0);
for i=1:n
    f = f + a1*X1(i)+a2*(X2(i))^(b)+a3*X3(i)+a4*X4(i)+a5*log(X5(i))+a6*X6(i)+a7 -X0(i);
end

