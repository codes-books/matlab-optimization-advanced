function result=resultselect(fitvalue_for,fitvalue,x_for,x);
global popsize;
A=[fitvalue_for;fitvalue];B=[x_for;x];    
N=2*popsize;
t=0;
for i=1:N           
    temp1(i)=A(i);
    temp2(i,:)=B(i,:);
end
for i=1:N-1    % ���׷��� A ����
    for j=2:N+1-i
        if temp1(j)<temp1(j-1)
            t1=temp1(j-1);t2=temp2(j-1,:);
            temp1(j-1)=temp1(j);temp2(j-1,:)=temp2(j,:);
            temp1(j)=t1;temp2(j,:)=t2;
        end
    end
end
for i=1:popsize  % ��A�ĵ���Ӧֵ��ǰһ�룩�����ȡ��
    result(i,:)=temp2(i,:);
end

