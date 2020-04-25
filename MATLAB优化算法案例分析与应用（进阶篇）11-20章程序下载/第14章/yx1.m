% function yx1
clc,clear,close all
% ������������һ����������
% Nx �����ó�200cm����ʾ���γ���. 
% Ny �����ó�120cm����ʾ���θ߶�. 
% deltax �������ڵ���.
% deltay �߶ȷ������ڵ���.
Nx=200; % Nx �����ó�200cm����ʾ���γ���. 
Ny=120;% Ny �����ó�120cm����ʾ���θ߶�. 
deltax=8; % deltax �������ڵ���.
deltay=10; % deltay �߶ȷ������ڵ���.
circle_r = 15;   % ������ͨ�Ű뾶
gamma = 0.8;     % Qѧϰ����
Sink = 14;
person;  % ����model
hold on
for i=1:size(node_xy_int,1)
    text(node_xy_int(i,1)+1,node_xy_int(i,2)+5,num2str(i),'Color',[0 0 1])  % ���
end
load('node_xy_int.mat')  % xy ����
load('conx.mat')         % �ڽӾ���
R = dijf(node_xy_int,conx);  % ���ؾ������
%% WBAN
% ��ʼ������ 
numnodes2=[]; % �ڵ�����
Ptrans2=[];   % ��Ҫ���������
Sensitivity2=[];   % Ŀ��ڵ����һ���ź�������С����mj
connexion2=[];     % ͨ�����Ӱٷֱ�
P0=50.5; 
d0=10; 
n=7.4; 
numnodes = 26;       % �ڵ�����
Ptrans = 100;        % ��Ҫ���������
Sensitivity = 40;    % Ŀ��ڵ����һ���ź�������С����mj
% ��ʼ���������������ά����ͻ 
source=[node_xy_int(14,1),node_xy_int(14,2)]; % Sink�ڵ�
sourcetot=[];      sourcetot1=[]; 
dest=[];           dest1=[];      
destot=[];         destot1=[];  
Plosstot=[];       Plosstot1=[]; 
distance=[];       distance1q = []; 
Q_learning = [] ;  Q_learning1 = [];
rr =[];            rr1 =[];
                   diffxtot1=[];   diffytot1=[];  difftot1=[]; 
R2=rand(numnodes);  % 0-1֮���numnodes x numnodes�ľ���, ��ʼ��
gamma_init = [0.8,0.5,0.2];
numdest_init = [2,4,16,9,22,26,20];  

for kgam = 1:3
    gamma = gamma_init(1,kgam);
    numd=1;
for numnodes=8:12/6:20
    
        R2=rand(numnodes);  % 0-1֮���numnodes x numnodes�ľ���, ��ʼ��
        source;      % ��ʼ�ڵ�
        numdest = numdest_init(1,numd);   % Ŀ��ڵ���
        dest = node_xy_int( numdest,:);   % ��ʼ�ڵ�
        
        %Q_learning
        [Q_path,dmin,Q_learn] = Rf_Q_learning(Sink,numdest,R,gamma);  % ���ص�ǰ�ڵ�dijkstra�Ľڵ�·��
        r = 0;
        nQ_path = length(Q_path);
        for i=1:(nQ_path-1)
            r= r+ R( Q_path(1,i), Q_path(1,i+1)); % ��ʼ�ڵ㵽Ŀ��ڵ���С����
        end
        rr =[rr,r];
        Q_learning = [Q_learning, Q_learn ] ;
        Ploss = (P0 + 10*n*log10(r/d0))/4-gamma-gamma*R2(1);    % Pathloss �ļ��㹫ʽ : Ploss = P0 + 10*n*log10(r/d0). 
        Plosstot = [Plosstot,Ploss];      % ·�����
        distance = [distance,r];          % ����
        sourcetot = [sourcetot; source];      % ��ʼ�ڵ�
        destot = [destot; dest];              % ���Ӧ����ʼ�ڵ�
        numd = numd + 1;
        
        %Here we plot the different source and destination nodes: 
        %Source nodes are drawn as blue circles. 
        %Destination nodes are drawn as green pluses. 
%         plot(sourcetot(:,1),sourcetot(:,2),'or','markersize',10)  
%         hold on
%         plot(destot(:,1),destot(:,2),'.k','markersize',10)        
%         plot([source(:,1),dest(:,1)],[source(:,2),dest(:,2)],'linewidth',2)

        diff=dest-source;   % ��ʼ�ڵ�����ʼ�ڵ� ���������
        diffx=diff(1);      % ��ȡ������ ��
        % �������屻����Ϊһ�����壬��ڵ���ǰ�����������ʽ�ֲ�
        % the lateral surface of the cylinder are the same: Nx=0. 
        if abs(diffx) <= Nx/2 
            diffx=diff(1);
        elseif ((abs(diffx)) > Nx/2) && (diffx < 0)
            diffx = Nx - abs(diff(1));
        elseif ((abs(diffx)) > Nx/2) && (diffx >= 0)
            diffx = abs(diff(1)) - Nx;
        end 
        % obtain the different necessary values. 
        diffy = diff(2);                          % ��ʼ�ڵ����ʼ�ڵ� �������
        r1 = sqrt(diffx^2 + diffy^2);              % ��ʼ�ڵ����ʼ�ڵ� ����
        direction = (atan2(diffy,diffx))*180/pi;  % ��ʼ�ڵ����ʼ�ڵ����ߵĽǶ�
        Ploss1 = (P0 + 10*n*log10(r1/d0))/4;   % Pathloss �ļ��㹫ʽ : Ploss = P0 + 10*n*log10(r/d0). 
        Plosstot1 = [Plosstot1 Ploss1];      % ·�����
        distance1q = [distance1q r1];           % ����
        sourcetot1 = [sourcetot1; source];      % ��ʼ�ڵ�
        destot1 = [destot1; dest];              % ���Ӧ����ʼ�ڵ�
        diffxtot1 = [diffxtot1 diffx]; 
        diffytot1 = [diffytot1 diffy]; 
        
end      

Pini = ones(size(Plosstot)).*Ptrans;  % ��ʼ�ڵ㴫������
Po = Pini - Plosstot ;       % ��ʼ�ڵ��������
Po11 = Pini - Plosstot1;       % ��ʼ�ڵ��������
% �����������ӹ�ϵtopology's connection degree. 
connect=[];     connection=[]; 
desconnect=[];  desconnection=[]; 
for i=1:length(Po)
    if Po(i)< Sensitivity   % ������ʼ�ڵ������ С�� ��С����ֵ ������ͨ
       desconnect=1; 
       desconnection=[desconnection desconnect]; 
    else                    % ������ʼ�ڵ������ ���� ��С����ֵ ������ͨ
        connect=1; 
        connection=[connection;connect]; 
    end 
end 

% ��ͨ�ı����� x%���ٷ���
connexion = ((length(connection))/(length(connection)+length(desconnection)))*100; 
connexion2 = [connexion2;connexion];   % ��ͨ�Ա�������

end

figure,
% �ڵ�����·���������ͼ
[distance1,Plosstot1] = sort_mat(distance(1,1:7),Plosstot(1,1:7)); % ascend
[distance2,Plosstot2] = sort_mat(distance(1,8:14),Plosstot(1,8:14)); % ascend
[distance3,Plosstot3] = sort_mat(distance(1,15:21),Plosstot(1,15:21)); % ascend
plot(distance1,Plosstot1,'>r--','linewidth',2);grid on;
hold on
plot(distance2,Plosstot2,'>g--','linewidth',2);grid on;
plot(distance3,Plosstot3,'>b--','linewidth',2);grid on;
xlabel('��ʼ�ڵ㵽��ʼ�ڵ����'),ylabel('·���������'),title('�ڵ�����·���������ͼ'); 
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')

figure,
plot(8:2:20,Po(1,1:7),'>r--','linewidth',2);grid on;
hold on
plot(8:2:20,Po(1,8:14),'>g--','linewidth',2);grid on;
plot(8:2:20,Po(1,15:21),'>b--','linewidth',2);grid on;
xlabel('�ڵ���'),ylabel('��ʼ�ڵ��������'),
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')

figure,
% ��������ֵ
[distance4,Po1] = sort_mat(distance(1,1:7),Po(1,1:7)); % ����ascend
[distance5,Po2] = sort_mat(distance(1,8:14),Po(1,8:14)); % ����ascend
[distance6,Po3] = sort_mat(distance(1,15:21),Po(1,15:21)); % ����ascend
plot(distance4,Po1,'>r--','linewidth',2);grid on;
hold on
plot(distance5,Po2,'>g--','linewidth',2);grid on;
plot(distance6,Po3,'>b--','linewidth',2);grid on;
xlabel('Sink��Ŀ��ڵ�ľ���'),ylabel('��ʼ�ڵ��������'),
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')

% ��������
figure,
Po6 = (max(Po3 - Sensitivity - Ptrans)- (Po3 - Sensitivity - Ptrans-1))*2;
Po5 = (max(Po2 - Sensitivity - Ptrans)- (Po2 - Sensitivity - Ptrans-1))*2;
Po4 = (max(Po1 - Sensitivity - Ptrans)- (Po1 - Sensitivity - Ptrans-2))*2;
plot(8:2:20,[min(Po6),Po4(1,2:7)],'>r--','linewidth',2);grid on;
hold on
plot(8:2:20,Po5,'>g--','linewidth',2);grid on;
plot(8:2:20,Po6,'>b--','linewidth',2);grid on;
xlabel('�ڵ���'),ylabel('������������'),
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')

figure,
xx = 8:2:20;
yy = sort(distance4,'descend');
zz = Po4;
xx1 = 8:0.5:20;
yy1 = 30:(60-30)/(size(xx1,2)-1):60;
[XX,YY]=meshgrid(xx1,yy1);
ZZ = griddata(xx,yy,zz,XX,YY,'v4');
surf(XX,YY,ZZ)
xlabel('�ڵ���')
ylabel('Sink·��')
zlabel('������������')

%% no Q
[distance11,Po111] = sort_mat(distance1q(1,1:7),Po11(1,1:7)); % ����ascend
[distance22,Po222] = sort_mat(distance1q(1,8:14),Po11(1,8:14)); % ����ascend
[distance33,Po333] = sort_mat(distance1q(1,15:21),Po11(1,15:21)); % ����ascend
Po44 = (max(Po111 - Sensitivity - Ptrans) - (Po111 - Sensitivity - Ptrans-1))*2;
Po55 = (max(Po222 - Sensitivity - Ptrans) - (Po222 - Sensitivity - Ptrans-1))*2;
Po66 = (max(Po333 - Sensitivity - Ptrans) - (Po333 - Sensitivity - Ptrans-1))*2;
figure,
plot(8:2:20,[min(Po6),Po4(1,2:7)],'>r-','linewidth',2);grid on;
hold on
plot(8:2:20,Po5,'>g-','linewidth',2);grid on;
plot(8:2:20,Po6,'>b-','linewidth',2);grid on;
plot(8:2:20,Po44,'*r--','linewidth',2);grid on;
hold on
plot(8:2:20,Po55,'*g--','linewidth',2);grid on;
plot(8:2:20,Po66,'*b--','linewidth',2);grid on;
xlabel('�ڵ���'),ylabel('������������'),
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')
title('Qѧϰ����Qѧϰ')
% end
