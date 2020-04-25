function fitness = Fitness_ACO(x,method)
% ��Ⱥ�㷨ACO�� �����Ż�����
% ���룺
% x - ����
% method - aco��Ⱥ�㷨
% �����
% fitness - ������Ӧ��ֵ

if (nargin<2)   % Ĭ��Ϊaco
    method='aco';
end
if strcmpi(method,'aco') % ACO �㷨
    fitness = -20*exp(-0.2*sqrt((x(1)^2+x(2)^2)/2))-exp((cos(2*pi*x(1))+cos(2*pi*x(2)))/2)+20+2.71289;
end
