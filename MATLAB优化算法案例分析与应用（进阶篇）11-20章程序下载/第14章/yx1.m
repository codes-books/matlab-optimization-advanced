% function yx1
clc,clear,close all
% 人身体表面近似一个矩形区域
% Nx 被设置成200cm，表示矩形长度. 
% Ny 被设置成120cm，表示矩形高度. 
% deltax 横向两节点间隔.
% deltay 高度方向两节点间隔.
Nx=200; % Nx 被设置成200cm，表示矩形长度. 
Ny=120;% Ny 被设置成120cm，表示矩形高度. 
deltax=8; % deltax 横向两节点间隔.
deltay=10; % deltay 高度方向两节点间隔.
circle_r = 15;   % 覆盖面通信半径
gamma = 0.8;     % Q学习参数
Sink = 14;
person;  % 人体model
hold on
for i=1:size(node_xy_int,1)
    text(node_xy_int(i,1)+1,node_xy_int(i,2)+5,num2str(i),'Color',[0 0 1])  % 标记
end
load('node_xy_int.mat')  % xy 坐标
load('conx.mat')         % 邻接矩阵
R = dijf(node_xy_int,conx);  % 返回距离矩阵
%% WBAN
% 初始化变量 
numnodes2=[]; % 节点数量
Ptrans2=[];   % 需要传输的能量
Sensitivity2=[];   % 目标节点接受一个信号所需最小能量mj
connexion2=[];     % 通信链接百分比
P0=50.5; 
d0=10; 
n=7.4; 
numnodes = 26;       % 节点数量
Ptrans = 100;        % 需要传输的能量
Sensitivity = 40;    % 目标节点接受一个信号所需最小能量mj
% 初始化变量，避免变量维数冲突 
source=[node_xy_int(14,1),node_xy_int(14,2)]; % Sink节点
sourcetot=[];      sourcetot1=[]; 
dest=[];           dest1=[];      
destot=[];         destot1=[];  
Plosstot=[];       Plosstot1=[]; 
distance=[];       distance1q = []; 
Q_learning = [] ;  Q_learning1 = [];
rr =[];            rr1 =[];
                   diffxtot1=[];   diffytot1=[];  difftot1=[]; 
R2=rand(numnodes);  % 0-1之间的numnodes x numnodes的矩阵, 初始化
gamma_init = [0.8,0.5,0.2];
numdest_init = [2,4,16,9,22,26,20];  

for kgam = 1:3
    gamma = gamma_init(1,kgam);
    numd=1;
for numnodes=8:12/6:20
    
        R2=rand(numnodes);  % 0-1之间的numnodes x numnodes的矩阵, 初始化
        source;      % 起始节点
        numdest = numdest_init(1,numd);   % 目标节点标号
        dest = node_xy_int( numdest,:);   % 终始节点
        
        %Q_learning
        [Q_path,dmin,Q_learn] = Rf_Q_learning(Sink,numdest,R,gamma);  % 返回当前节点dijkstra的节点路径
        r = 0;
        nQ_path = length(Q_path);
        for i=1:(nQ_path-1)
            r= r+ R( Q_path(1,i), Q_path(1,i+1)); % 起始节点到目标节点最小距离
        end
        rr =[rr,r];
        Q_learning = [Q_learning, Q_learn ] ;
        Ploss = (P0 + 10*n*log10(r/d0))/4-gamma-gamma*R2(1);    % Pathloss 的计算公式 : Ploss = P0 + 10*n*log10(r/d0). 
        Plosstot = [Plosstot,Ploss];      % 路由损耗
        distance = [distance,r];          % 距离
        sourcetot = [sourcetot; source];      % 起始节点
        destot = [destot; dest];              % 相对应的终始节点
        numd = numd + 1;
        
        %Here we plot the different source and destination nodes: 
        %Source nodes are drawn as blue circles. 
        %Destination nodes are drawn as green pluses. 
%         plot(sourcetot(:,1),sourcetot(:,2),'or','markersize',10)  
%         hold on
%         plot(destot(:,1),destot(:,2),'.k','markersize',10)        
%         plot([source(:,1),dest(:,1)],[source(:,2),dest(:,2)],'linewidth',2)

        diff=dest-source;   % 终始节点与起始节点 横纵坐标差
        diffx=diff(1);      % 获取横坐标 差
        % 由于人体被表征为一个矩体，则节点在前后矩形面绕线式分布
        % the lateral surface of the cylinder are the same: Nx=0. 
        if abs(diffx) <= Nx/2 
            diffx=diff(1);
        elseif ((abs(diffx)) > Nx/2) && (diffx < 0)
            diffx = Nx - abs(diff(1));
        elseif ((abs(diffx)) > Nx/2) && (diffx >= 0)
            diffx = abs(diff(1)) - Nx;
        end 
        % obtain the different necessary values. 
        diffy = diff(2);                          % 起始节点和终始节点 纵坐标差
        r1 = sqrt(diffx^2 + diffy^2);              % 起始节点和终始节点 距离
        direction = (atan2(diffy,diffx))*180/pi;  % 起始节点和终始节点连线的角度
        Ploss1 = (P0 + 10*n*log10(r1/d0))/4;   % Pathloss 的计算公式 : Ploss = P0 + 10*n*log10(r/d0). 
        Plosstot1 = [Plosstot1 Ploss1];      % 路由损耗
        distance1q = [distance1q r1];           % 距离
        sourcetot1 = [sourcetot1; source];      % 起始节点
        destot1 = [destot1; dest];              % 相对应的终始节点
        diffxtot1 = [diffxtot1 diffx]; 
        diffytot1 = [diffytot1 diffy]; 
        
end      

Pini = ones(size(Plosstot)).*Ptrans;  % 起始节点传输能量
Po = Pini - Plosstot ;       % 终始节点接受能量
Po11 = Pini - Plosstot1;       % 终始节点接受能量
% 考虑拓扑连接关系topology's connection degree. 
connect=[];     connection=[]; 
desconnect=[];  desconnection=[]; 
for i=1:length(Po)
    if Po(i)< Sensitivity   % 到达终始节点的能量 小于 最小能量值 ，不连通
       desconnect=1; 
       desconnection=[desconnection desconnect]; 
    else                    % 到达终始节点的能量 大于 最小能量值 ，则连通
        connect=1; 
        connection=[connection;connect]; 
    end 
end 

% 连通的比例， x%，百分数
connexion = ((length(connection))/(length(connection)+length(desconnection)))*100; 
connexion2 = [connexion2;connexion];   % 连通性比例数组

end

figure,
% 节点距离和路由损耗能量图
[distance1,Plosstot1] = sort_mat(distance(1,1:7),Plosstot(1,1:7)); % ascend
[distance2,Plosstot2] = sort_mat(distance(1,8:14),Plosstot(1,8:14)); % ascend
[distance3,Plosstot3] = sort_mat(distance(1,15:21),Plosstot(1,15:21)); % ascend
plot(distance1,Plosstot1,'>r--','linewidth',2);grid on;
hold on
plot(distance2,Plosstot2,'>g--','linewidth',2);grid on;
plot(distance3,Plosstot3,'>b--','linewidth',2);grid on;
xlabel('起始节点到终始节点距离'),ylabel('路由能量损耗'),title('节点距离和路由损耗能量图'); 
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')

figure,
plot(8:2:20,Po(1,1:7),'>r--','linewidth',2);grid on;
hold on
plot(8:2:20,Po(1,8:14),'>g--','linewidth',2);grid on;
plot(8:2:20,Po(1,15:21),'>b--','linewidth',2);grid on;
xlabel('节点数'),ylabel('终始节点接受能量'),
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')

figure,
% 接收能量值
[distance4,Po1] = sort_mat(distance(1,1:7),Po(1,1:7)); % 距离ascend
[distance5,Po2] = sort_mat(distance(1,8:14),Po(1,8:14)); % 距离ascend
[distance6,Po3] = sort_mat(distance(1,15:21),Po(1,15:21)); % 距离ascend
plot(distance4,Po1,'>r--','linewidth',2);grid on;
hold on
plot(distance5,Po2,'>g--','linewidth',2);grid on;
plot(distance6,Po3,'>b--','linewidth',2);grid on;
xlabel('Sink到目标节点的距离'),ylabel('终始节点接受能量'),
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')

% 生存周期
figure,
Po6 = (max(Po3 - Sensitivity - Ptrans)- (Po3 - Sensitivity - Ptrans-1))*2;
Po5 = (max(Po2 - Sensitivity - Ptrans)- (Po2 - Sensitivity - Ptrans-1))*2;
Po4 = (max(Po1 - Sensitivity - Ptrans)- (Po1 - Sensitivity - Ptrans-2))*2;
plot(8:2:20,[min(Po6),Po4(1,2:7)],'>r--','linewidth',2);grid on;
hold on
plot(8:2:20,Po5,'>g--','linewidth',2);grid on;
plot(8:2:20,Po6,'>b--','linewidth',2);grid on;
xlabel('节点数'),ylabel('网络生存周期'),
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
xlabel('节点数')
ylabel('Sink路径')
zlabel('网络生存周期')

%% no Q
[distance11,Po111] = sort_mat(distance1q(1,1:7),Po11(1,1:7)); % 距离ascend
[distance22,Po222] = sort_mat(distance1q(1,8:14),Po11(1,8:14)); % 距离ascend
[distance33,Po333] = sort_mat(distance1q(1,15:21),Po11(1,15:21)); % 距离ascend
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
xlabel('节点数'),ylabel('网络生存周期'),
% axis tight
legend('\gamma = 0.8','\gamma = 0.5','\gamma = 0.2')
title('Q学习和无Q学习')
% end
