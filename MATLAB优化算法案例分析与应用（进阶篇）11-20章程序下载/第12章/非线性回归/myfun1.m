function f = myfun1(xs,xdata)
% global X0 X1 X2 X3 X4 X5 X6
a1 = xs(1); % ֲ������C ϵ��
a2 = xs(2); % ��������Q ϵ��
b = xs(3);  % ��������Q ָ��
a3 = xs(4); % ������ʼ��ˮ������ ϵ��
a4 = xs(5); % SS����Ũ�� ϵ��
a5 = xs(6); % ��������m  ϵ��
a6 = xs(7); % �¶�����%  ϵ��
a7 = xs(8); % ������     ϵ��
X1 = xdata(:,1);  X2 = xdata(:,2);  X3 = xdata(:,3);
X4 = xdata(:,4);  X5 = xdata(:,5);  X6 = xdata(:,6);
f = a1*X1+a2*(X2).^(b)+a3*X3+a4*X4+a5*log(X5)+a6*X6+a7;
