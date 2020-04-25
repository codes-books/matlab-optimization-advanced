clc,clear,close all
warning off
im = imread('y4.jpg');
figure(1),
imshow(im)
hold on
load('node_AP.mat') % �ڵ�����
load('adj_node.mat') %�ڽӾ���
plot(node_AP(:,1),node_AP(:,2),'sr')
nconx = size(adj_node);
for i=1: nconx(1,1)
    for j=1:nconx(1,2)
        if adj_node(i,j)==1
            xconx=[ node_AP(i,1), node_AP(j,1)];
            yconx=[ node_AP(i,2), node_AP(j,2)];
            plot(xconx,yconx,'b-','linewidth',2);
            % pause(1)
        end
    end
end
n=length(adj_node);
x1(n,n)=0;
for i=1:n
    for j=i:(n-1)
        x1(i,j+1)=sqrt((node_AP(j+1,1)-node_AP(i,1)).^2+(node_AP(j+1,2)-node_AP(i,2)).^2);
    end
end
x2=x1';
x3=x2+x1;           % ���еĵ�·֮��ľ���
x4 = x3.* adj_node; % �жϽڵ��Ƿ�������
for i=1:n
    for j=1:n
        if x4(i,j)==0
            x4(i,j)=inf;   % �������ӵĽڵ���������
        end
    end
end
T=prim(x4)  % ������С��ģ��
nT=size(T);
figure(2),
imshow(im)
hold on
for i=1:nT(1,2)
    xT=[node_AP(T(1,i),1), node_AP(T(2,i),1)];
    yT=[node_AP(T(1,i),2), node_AP(T(2,i),2)];
    plot(xT,yT,'r-','linewidth',2);
end

%% ���·����
figure(3)
imshow(im);
hold on
for i=1:n
    text(node_AP(i,1)+35,node_AP(i,2)+20,num2str(i),'Color',[1 0 0])
end
% for i=1: nconx(1,1)
%     for j=1:nconx(1,2)
%         if adj_node(i,j)==1
%             xconx=[ node_AP(i,1), node_AP(j,1)];
%             yconx=[ node_AP(i,2), node_AP(j,2)];
%             plot(xconx,yconx,'b-','linewidth',2);
%             % pause(1)
%         end
%     end
% end
[r_path, r_cost] = dijkstra(2, 15, x4)   % ���·
nr =length(r_path);
for i=1:(nr-1)
    xr=[node_AP(r_path(1,i),1), node_AP(r_path(1,i+1),1)];
    yr=[node_AP(r_path(1,i),2), node_AP(r_path(1,i+1),2)];
    plot(xr,yr,'r-','linewidth',2);
end






