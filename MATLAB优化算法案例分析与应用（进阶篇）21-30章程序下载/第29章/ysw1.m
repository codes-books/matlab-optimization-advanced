%% DE
%% ��ջ�������
clc,clear,close all
warning off
feature jit off
F0 = 0.5;  % �Ǳ�����    
Gm = 100;  % ����������
Np = 100;  % ��Ⱥ��ģ
CR = 0.9;  % �ӽ�����
G = 1;     % ��ʼ������
N = 10;    % ���������ά�����������δ֪������
ge = zeros(1,Np);    % ����������Ŀ�꺯��ֵ
bestx = zeros(Np,N); % ���������Ž�
% �ⷶΧ
xmin = -5.12; % ����
xmax = 5.12;  % ����
% ������ʼ��Ⱥ
X0 = (xmax-xmin)*rand(Np,N)+xmin;
X = X0;
% ��ѡ���ʼ��
X1new = zeros(Np,N);  % ��ʼ��
X1_new = zeros(Np,N); % ��ʼ��
X1 = zeros(Np,N);     % ��ʼ��
value = zeros(1,Np);  % ��ʼ��
while G<=Gm   % ������ʼ
    disp(['����������  ',num2str(G)])
    
    for i=1:Np
        %����j,k,p������ͬ����
        a=1;b = Np;
        dx = randperm(b-a+1)+a-1;
        j=dx(1);k=dx(2);p=dx(3);
        if j==i
            j=dx(4);
        elseif k==i
            k=dx(4);
        elseif p==i
            p=dx(4);
        end

        % ��������
        namd=exp(1-Gm/(Gm+1-G));
        F=F0*2.^namd;

        bon = X(p,:)+F*(X(j,:)-X(k,:)); % �������
        if (bon>xmin)&(bon<xmax)        % ��ֹ���쳬���߽�
            X1new(i,:)=bon;
        else
            X1new(i,:)=(xmax-xmin)*rand(1,N)+xmin;
        end
    end
    % �ӽ�����
    for i=1:Np
        if rand>CR   % ���ö���ֲ�������
            X1_new(i,:)= X(i,:);
        else
            X1_new(i,:) = X1new(i,:);
        end
    end
    % ��������
    for i=1:Np
        if fitness(X1_new(i,:))<fitness(X(i,:))
            X1(i,:)=X1_new(i,:);
        else 
            X1(i,:)=X(i,:);
        end
    end
   % �ҳ���Сֵ
    for i=1:Np
        value(i)=fitness(X1(i,:));
    end
    [fmin,nmin]=min(value);
    ge(G)=fmin;
    bestx(G,:) = X1(nmin,:); 
    G=G+1;
    X = X1;
end
bestx(end,:)  % �������Ž�
ge(end)

%% ��ֽ����㷨������� 
figure('color',[1,1,1]),
plot(1:length(ge),ge,'b--');
title(['��Ӧ������  ' '��ֹ������' num2str(Gm)]);
xlabel('��������');   ylabel('��Ӧ��');
legend('�����Ӧ��');

