function [xx,yy]=sort_mat(x,y)
% ����ʹ����xΪ��׼������x,y���Ӧ������С��������
% xΪҪ����ľ���  1 x N
% yΪҪ��Ӧ������ľ���   1 x N
[a,b]=sort(x);
% aΪ����Ľ��
% bΪx��������������
nx =size(x);
for i=1:nx(1,2)
    xx(i)=x(1,b(i));
    yy(i)=y(1,b(i));
end