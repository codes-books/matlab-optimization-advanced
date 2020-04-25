clc,clear,close all
warning off
N = 40; % ��Ⱥ����
c1 = 2; % ����Ⱥ����
c2 = 2; % ����Ⱥ����
wmax = 0.9; % ���Ȩ��
wmin = 0.6; % ��СȨ��
M = 100;    % ѭ����������
D = 2;      % ��Ⱥ�и������,2��δ֪��
format long;
%------��ʼ����Ⱥ�ĸ���------------
for i=1:N
    for j=1:D
        x(i,j)=rands(1);  %�����ʼ��λ��
        v(i,j)=rands(1);  %�����ʼ���ٶ�
    end
end

%% ------�ȼ���������ӵ���Ӧ��----------------------
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end

pg=x(N,:);             % PgΪȫ������
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end

%% ------������Ҫѭ��------------
for t=1:M

    for j=1:N
        fv(j) = fitness(x(j,:));  % ��Ӧ��ֵ
    end
    fvag = sum(fv)/N;   % ƽ����Ӧ��ֵ
    fmin = min(fv);     % ��С��Ӧ��ֵ
    for i=1:N
        if fv(i) <= fvag
            w = wmin + (fv(i)-fmin)*(wmax-wmin)/(fvag-fmin);  % ����ӦȨֵ
        else
            w = wmax;   % Ȩֵ
        end
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:)); % �ٶȸ���
        x(i,:)=x(i,:)+v(i,:);    % �������
        if x(i,1)>1||x(i,1)<-1
            x(i,1)=rands(1);
        end
        if x(i,2)>1||x(i,2)<-1
            x(i,2)=rands(1);
        end
        if fitness(x(i,:))<p(i)  % ��Ӧ��ֵ����
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end

        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
    Pbest(t)=fitness(pg);
end
r=[1:1:100];
plot(r,Pbest,'r--','linewidth',2);
xlabel('��������'),ylabel('��Ӧ��ֵ')
title('����ӦȨ��PSO�㷨')
hold on
xm = pg'
fv = fitness(pg)
