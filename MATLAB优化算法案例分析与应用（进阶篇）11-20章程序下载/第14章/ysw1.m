function ysw1
clc,clear,close all
% 人身体表面近似一个矩形区域
% Nx 被设置成200cm，表示矩形长度. 
% Ny 被设置成120cm，表示矩形高度. 
% deltax 横向两节点间隔.
% deltay 高度方向两节点间隔.
Nx=200; % Nx 被设置成200cm，表示矩形长度. 
Ny=120;% Ny 被设置成120cm，表示矩形高度. 
deltax=8;  % 网格密度
deltay=10; % 网格密度
circle_r = 15;      % 圆度半径
%% drawn 200 x 120 的矩形区域 (human torso). 
person;
%画出链接关系图
load('conx.mat')         % 邻接矩阵
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
%% 最短路模型
person;        % 画人体模型
hold on
for i=1:size(node_xy_int,1)
    text(node_xy_int(i,1)+1,node_xy_int(i,2)+5,num2str(i),'Color',[0 0 1])
end
Dz = dijz(node_xy_int,conx);  % 返回距离矩阵
[r_path, r_cost] = dijkstra(18, 14, Dz);   % 最短路
nr =length(r_path);
for i=1:(nr-1)
    xr=[node_xy_int(r_path(1,i),1), node_xy_int(r_path(1,i+1),1)];
    yr=[node_xy_int(r_path(1,i),2), node_xy_int(r_path(1,i+1),2)];
    plot(xr,yr,'r-','linewidth',2);
end
%% MST model
T=prim(Dz);  % 返回最小树模型
nT=size(T);
person;
hold on
for i=1:nT(1,2)
    xT=[node_xy_int(T(1,i),1), node_xy_int(T(2,i),1)];
    yT=[node_xy_int(T(1,i),2), node_xy_int(T(2,i),2)];
    plot(xT,yT,'r-','linewidth',2);
end

end


