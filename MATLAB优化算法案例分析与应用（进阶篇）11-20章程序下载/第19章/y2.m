clc,clear,close all
warning off
im = imread('y3.jpg');
figure(1),
imshow(im)
hold on
load('node_car_2.mat') % 节点坐标
load('adj_node_2.mat') %邻接矩阵
plot(node_car_2(:,1),node_car_2(:,2),'sr')
nconx = size(adj_node_2);
for i=1: nconx(1,1)
    for j=1:nconx(1,2)
        if adj_node_2(i,j)==1
            xconx=[ node_car_2(i,1), node_car_2(j,1)];
            yconx=[ node_car_2(i,2), node_car_2(j,2)];
            plot(xconx,yconx,'b-','linewidth',2);
            % pause(1)
        end
    end
end
n=length(adj_node_2);
x1(n,n)=0;
for i=1:n
    for j=i:(n-1)
        x1(i,j+1)=sqrt((node_car_2(j+1,1)-node_car_2(i,1)).^2+(node_car_2(j+1,2)-node_car_2(i,2)).^2);
    end
end
x2=x1';
x3=x2+x1;           % 所有的道路之间的距离
x4 = x3.* adj_node_2; % 判断节点是否相连接
for i=1:n
    for j=1:n
        if x4(i,j)==0
            x4(i,j)=inf;   % 不相连接的节点距离无穷大
        end
    end
end
T=prim(x4)  % 返回最小树模型
nT=size(T);
figure(2),
imshow(im)
hold on
for i=1:nT(1,2)
    xT=[node_car_2(T(1,i),1), node_car_2(T(2,i),1)];
    yT=[node_car_2(T(1,i),2), node_car_2(T(2,i),2)];
    plot(xT,yT,'r-','linewidth',2);
end

%% 最短路问题
figure(3)
imshow(im);
hold on
for i=1:n
    text(node_car_2(i,1)+35,node_car_2(i,2)+20,num2str(i),'Color',[1 0 0])
end
% for i=1: nconx(1,1)
%     for j=1:nconx(1,2)
%         if adj_node_2(i,j)==1
%             xconx=[ node_car_2(i,1), node_car_2(j,1)];
%             yconx=[ node_car_2(i,2), node_car_2(j,2)];
%             plot(xconx,yconx,'b-','linewidth',2);
%             % pause(1)
%         end
%     end
% end
[r_path, r_cost] = dijkstra(9, 10, x4)   % 最短路
nr =length(r_path);
for i=1:(nr-1)
    xr=[node_car_2(r_path(1,i),1), node_car_2(r_path(1,i+1),1)];
    yr=[node_car_2(r_path(1,i),2), node_car_2(r_path(1,i+1),2)];
    plot(xr,yr,'r-','linewidth',2);
end






