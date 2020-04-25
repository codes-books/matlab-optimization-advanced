clc,clear,close all
warning off      % ��������
N = 1000;        % �źŹ۲ⳤ��
a1 = 0.99;       % һ��AR����
sigma = 0.0731; % ���԰���������
for kk =1:100
    v = sqrt(sigma)*randn(N,1); % ����v��n�����԰�����
    u0 = [0];      % ��ʼ����
    num = 1;       % ����ϵ��
    den = [1,a1];  % ��ĸϵ��
    Zi = filtic(num,den,u0);    % �˲����ĳ�ʼ����
    un = filter(num,den,v,Zi);   % ������������u(n), N x 1 x trials
%     figure,stem(un),title('����ź�');grid on;
    % ����������Ӧ�źź͹۲����ݾ���
    n0 = 1;          % ��ʵ��n0������Ԥ��
    M = 2;           % �˲�������
    b = un(n0+1:N);  % Ԥ���������Ӧ
    L = length(b);  
    un1 = [zeros(M-1,1)',un'];  % ��չ����
    A = zeros(M,L);
    for k=1:L
        A(:,k) = un1(M-1+k : -1 : k);   % �����۲����ݾ���
    end
    % Ӧ��RLS�㷨���е���Ѱ�ż�������Ȩ����
    delta = 0.004; % ��������
    lamda = 0.98;  % ��������
    w = zeros(M,L+1); 
    epsilon = zeros(L,1); 
    P1 = eye(M)/delta;
    % RLS�����㷨����
    for k=1:L  
        PIn = P1 * A(:,k);
        denok = lamda + A(:,k)'*PIn;
        kn = PIn/denok;
        epsilon(k) = b(k)-w(:,k)'*A(:,k);
        w(:,k+1) = w(:,k) + kn*conj(epsilon(k));
        P1 = P1/lamda - kn*A(:,k)'*P1/lamda;
    end
    w1(kk,:) = w(1,:);
    w2(kk,:) = w(2,:);
    MSE = abs(epsilon).^2;
    MSE_P(kk) = mean(MSE);
end
W1 = mean(w1); % ȡƽ��ֵ
W2 = mean(w2); % ȡƽ��ֵ 
figure,plot(1:kk,MSE_P,'r','linewidth',2),title('ƽ��MSE');grid on;
figure,plot(1:length(W1),W1,'r','linewidth',2),title('ƽ��MSE');hold on;
plot(1:length(W2),W2,'b','linewidth',2),title('Ȩֵ');hold on;
grid on;legend('\alpha1=0','\alpha2=-1')
