function T=prim(D)
% DΪ����
% T���ص�������
n=size(D,1); % n���ڵ�
T=[];
l=0; % l��¼T������
q(1)=-1;
for i=2:n
    p(i)=1;
    q(i)=D(i,1);  % ��һ���ڵ㵽�����ڵ����
end
k=1;
while 1
    if k>=n   % ѭ�����ڽڵ�n����������ѭ����������ӽڵ�
        disp(T);
        break;
    else
        min=inf;
        for i=2:n
            if q(i)>0&q(i)<min
                min=q(i);  % �ҵ����һ���ڵ����������нڵ㣬���о�������Ľڵ�ľ���
                h=i;       % ��¼����ڵ� ��Ӧ�Ľڵ����
            end
        end
    end
    l=l+1;
    T(1,l)=h;    % ��¼������Ǹ��ڵ�
    T(2,l)=p(h); % ��ǰ��ʼ�ڵ�
    q(h)=-1;
    for j=2:n
        if D(h,j)<q(j)
            q(j)=D(h,j);
            p(j)=h;
        end
    end
    k=k+1;
end
