function T=prim(D)
% D为矩阵
% T返回的连接树
n=size(D,1); % n个节点
T=[];
l=0; % l记录T的列数
q(1)=-1;
for i=2:n
    p(i)=1;
    q(i)=D(i,1);  % 第一个节点到其他节点距离
end
k=1;
while 1
    if k>=n   % 循环大于节点n个数，跳出循环，输出连接节点
        disp(T);
        break;
    else
        min=inf;
        for i=2:n
            if q(i)>0&q(i)<min
                min=q(i);  % 找到与第一个节点相连的所有节点，其中距离最近的节点的距离
                h=i;       % 记录最近节点 对应的节点序号
            end
        end
    end
    l=l+1;
    T(1,l)=h;    % 记录最近的那个节点
    T(2,l)=p(h); % 当前起始节点
    q(h)=-1;
    for j=2:n
        if D(h,j)<q(j)
            q(j)=D(h,j);
            p(j)=h;
        end
    end
    k=k+1;
end
