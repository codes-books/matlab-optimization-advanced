figure('Color',[1 1 1]);
% ��Բ
t=0:0.01:2*pi;
x=circle_r*cos(t);
y=circle_r*sin(t);
plot(x,y,'k')
hold on
% ������
rectangle('Position', [-30 -85 60 70]) 
% �����
rectangle('Position', [-45 -65 15 50]) 
% ���ұ�
rectangle('Position', [30 -65 15 50]) 
% ������
rectangle('Position', [-20 -135 15 50]) 
% ������
rectangle('Position', [5 -135 15 50]) 
axis equal;axis off; 
hold on 
%�����ڵ�
load('node_xy_int.mat')  % xy ����
plot(node_xy_int(:,1),node_xy_int(:,2),'sr')
plot(node_xy_int(14,1),node_xy_int(14,2),'r.','markersize',20)
text(node_xy_int(14,1)+4,node_xy_int(14,2)+1,'Sink','Color',[0 0 1])
