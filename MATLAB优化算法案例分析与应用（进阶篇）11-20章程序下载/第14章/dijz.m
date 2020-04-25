function x4=dijz(node_AP,adj_node)
n=length(adj_node);
x1(n,n)=0;
for i=1:n
    for j=i:(n-1)
        x1(i,j+1)=sqrt((node_AP(j+1,1)-node_AP(i,1)).^2+(node_AP(j+1,2)-node_AP(i,2)).^2);
    end
end
x2=x1';
x3=x2+x1;           % 所有的道路之间的距离
x4 = x3.* adj_node; % 判断节点是否相连接
for i=1:n
    for j=1:n
        if x4(i,j)==0
            x4(i,j)=inf;   % 不相连接的节点距离无穷大
        end
    end
end