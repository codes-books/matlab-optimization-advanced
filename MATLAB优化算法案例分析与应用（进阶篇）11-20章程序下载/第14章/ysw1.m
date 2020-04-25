function ysw1
clc,clear,close all
% ������������һ����������
% Nx �����ó�200cm����ʾ���γ���. 
% Ny �����ó�120cm����ʾ���θ߶�. 
% deltax �������ڵ���.
% deltay �߶ȷ������ڵ���.
Nx=200; % Nx �����ó�200cm����ʾ���γ���. 
Ny=120;% Ny �����ó�120cm����ʾ���θ߶�. 
deltax=8;  % �����ܶ�
deltay=10; % �����ܶ�
circle_r = 15;      % Բ�Ȱ뾶
%% drawn 200 x 120 �ľ������� (human torso). 
person;
%�������ӹ�ϵͼ
load('conx.mat')         % �ڽӾ���
nconx = size(conx);
for i=1: nconx(1,1)
    for j=1:nconx(1,2)
        if conx(i,j)==1
            xconx=[ node_xy_int(i,1), node_xy_int(j,1)];
            yconx=[ node_xy_int(i,2), node_xy_int(j,2)];
            plot(xconx,yconx,'b--','linewidth',2);
%             pause(1)
        end
    end
end
%% ���·ģ��
person;        % ������ģ��
hold on
for i=1:size(node_xy_int,1)
    text(node_xy_int(i,1)+1,node_xy_int(i,2)+5,num2str(i),'Color',[0 0 1])
end
Dz = dijz(node_xy_int,conx);  % ���ؾ������
[r_path, r_cost] = dijkstra(18, 14, Dz);   % ���·
nr =length(r_path);
for i=1:(nr-1)
    xr=[node_xy_int(r_path(1,i),1), node_xy_int(r_path(1,i+1),1)];
    yr=[node_xy_int(r_path(1,i),2), node_xy_int(r_path(1,i+1),2)];
    plot(xr,yr,'r-','linewidth',2);
end
%% MST model
T=prim(Dz);  % ������С��ģ��
nT=size(T);
person;
hold on
for i=1:nT(1,2)
    xT=[node_xy_int(T(1,i),1), node_xy_int(T(2,i),1)];
    yT=[node_xy_int(T(1,i),2), node_xy_int(T(2,i),2)];
    plot(xT,yT,'r-','linewidth',2);
end

end


