function B=hjjsort(A)
% ��A=[3 1 4 7 6 9]�û��ɡ�7     9     6     3     4     1��
N=length(A);t=[0 0];
for i=1:N           
    temp(i,2)=A(i);
    temp(i,1)=i;
end
for i=1:N-1    % ���׷��� A ����
    for j=2:N+1-i
        if temp(j,2)<temp(j-1,2)
            t=temp(j-1,:);temp(j-1,:)=temp(j,:);temp(j,:)=t;
        end
    end
end
for i=1:N/2   % ���źõ�A����
    t=temp(i,2);temp(i,2)=temp(N+1-i,2);temp(N+1-i,2)=t;
end
for i=1:N
    A(temp(i,1))=temp(i,2);
end
B=A;