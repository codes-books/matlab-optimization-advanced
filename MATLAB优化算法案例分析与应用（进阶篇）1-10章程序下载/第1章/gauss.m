function [z]=gauss(x,m,s)
% ������x�㴦�ĸ�˹����ֵ
% ����:
%   x:  l-dimensional ������
%   m:  Jxl matrix, ��˹�ֲ���ֵ
%   s:  J-dimensional row vector Э�������
%���:
%   z:  J-dimensional vector����x���ĸ�˹����ֵ.
 
[J,l]=size(m);
[p,l]=size(x);
z=[];
for j=1:J
    t=(x-m(j,:))*(x-m(j,:))';
    c=1/(2*pi*s(j))^(l/2);
    z=[z c*exp(-t/(2*s(j)))];
end
