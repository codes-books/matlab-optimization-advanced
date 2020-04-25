function yx2
% alpha对Q对的影响
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
circle_r = 15;   %
gamma = 0.8;     % Q学习参数
Sink = 14;
person;  % 人体model
hold on
for i=1:size(node_xy_int,1)
    text(node_xy_int(i,1)+1,node_xy_int(i,2)+5,num2str(i),'Color',[0 0 1])  % 标记
end
load('node_xy_int.mat')      % xy 坐标
load('conx.mat')             % 邻接矩阵
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
gamma_init = [1.0,0.8,0.5,0.3,0.2,0];
numdest_init = [2,4,16,9,22,26,20];  

for kgam = 1:6
    gamma = gamma_init(1,kgam);
    numd=1;
for numnodes=8:12/6:20
        R2=rand(numnodes);  % 0-1之间的numnodes x numnodes的矩阵, 初始化
        source;      % 起始节点
        numdest = numdest_init(1,numd);   % 目标节点标号
        dest = node_xy_int( numdest,:);   % 终始节点
        % Q_learning
        [Q_path,dmin,Q_learn] = Rf_Q_learning(Sink,numdest,R,gamma);  % 返回当前节点dijkstra的节点路径
        r = 0;
        nQ_path = length(Q_path);
        for i=1:(nQ_path-1)
            r= r+ R( Q_path(1,i), Q_path(1,i+1)); % 起始节点到目标节点最小距离
        end
        Ploss =( P0 + 10*n*log10(r/d0))/4-gamma-gamma*R2(1);    % Pathloss 的计算公式 : Ploss = P0 + 10*n*log10(r/d0). 
        Plosstot = [Plosstot,Ploss];      % 路由损耗
        distance = [distance,r];          % 距离
        sourcetot = [sourcetot; source];      % 起始节点
        destot = [destot; dest];              % 相对应的终始节点
        numd = numd + 1;
end
Q_learning = [Q_learning, Q_learn ] ;
Pini = ones(size(Plosstot)).*Ptrans;  % 起始节点传输能量
Po = Pini - Plosstot;       % 终始节点接受能量
% 考虑拓扑连接关系topology's connection degree. 
connect=[];     connection=[]; 
desconnect=[];  desconnection=[]; 
for i=1:length(Po)
    if Po(i)< Sensitivity   % 到达终始节点的能量小于最小能量值，不连通
       desconnect=1; 
       desconnection=[desconnection desconnect]; 
    else                    % 到达终始节点的能量大于最小能量值，则连通
        connect=1; 
        connection=[connection;connect]; 
    end 
end 
% 连通的比例， x%，百分数
connexion = ((length(connection))/(length(connection)+length(desconnection)))*100; 
connexion2 = [connexion2;connexion];   % 连通性比例数组
end
figure,
% 接收能量值
[distance1,Po1] = sort_mat(distance(1,1:7),Po(1,1:7)); % ascend
[distance2,Po2] = sort_mat(distance(1,8:14),Po(1,8:14)); % ascend
[distance3,Po3] = sort_mat(distance(1,15:21),Po(1,15:21)); % ascend
[distance4,Po4] = sort_mat(distance(1,22:28),Po(1,22:28)); % ascend
[distance5,Po5] = sort_mat(distance(1,29:35),Po(1,29:35)); % ascend
[distance6,Po6] = sort_mat(distance(1,36:42),Po(1,36:42)); % ascend
hold on
plot(distance1,Po1,'>r--','linewidth',2);grid on;
plot(distance2,Po2,'>g--','linewidth',2);grid on;
plot(distance3,Po3,'>b--','linewidth',2);grid on;
plot(distance4,Po4,'sk--','linewidth',2);grid on;
plot(distance5,Po5,'sc--','linewidth',2);grid on;
plot(distance6,Po6,'*b--','linewidth',2);grid on;
xlabel('Sink到目标节点的距离'),ylabel('终始节点接受能量'),
axis tight
legend('\gamma = 1.0','\gamma = 0.8','\gamma = 0.5','\gamma = 0.3','\gamma = 0.2','\gamma = 0.0')
% Q值
% figure,
Q1 = Q_learning(1,1);Q2 = Q_learning(1,2);Q3 = Q_learning(1,3);
Q4 = Q_learning(1,4);Q5 = Q_learning(1,5);Q6 = Q_learning(1,6);
Q = [Q6,Q5,Q4,Q3,Q2,Q1]*sqrt(3)+(1-sqrt(3))*Q1;
createfigure(gamma_init,Q(1,:))
% hold on
% plot(gamma_init,Q(1,:),'>r--','linewidth',2);grid on;
xlabel('\alpha 值'),ylabel('Q值'),
axis tight
end


function createfigure(X1, Y1)
%CREATEFIGURE(X1, Y1)
%  X1:  vector of x data
%  Y1:  vector of y data

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 1]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[78.1642648891164 283.090285369811]);
grid(axes1,'on');
hold(axes1,'all');

% Create plot
plot1 = plot(X1,Y1,'Marker','>','LineWidth',2,'LineStyle','--',...
    'Color',[1 0 0],...
    'DisplayName','data1');

% Create xlabel
xlabel('\alpha 值');

% Create ylabel
ylabel('Q值');

% Get xdata from plot
xdata1 = get(plot1, 'xdata');
% Get ydata from plot
ydata1 = get(plot1, 'ydata');
% Make sure data are column vectors
xdata1 = xdata1(:);
ydata1 = ydata1(:);


% Remove NaN values and warn
nanMask1 = isnan(xdata1(:)) | isnan(ydata1(:));
if any(nanMask1)
    warning('GeneratedCode:IgnoringNaNs', ...
        'Data points with NaN coordinates will be ignored.');
    xdata1(nanMask1) = [];
    ydata1(nanMask1) = [];
end

% Find x values for plotting the fit based on xlim
axesLimits1 = xlim(axes1);
xplot1 = linspace(axesLimits1(1), axesLimits1(2));


fitResults1 = polyfit(xdata1, ydata1, 3);
% Evaluate polynomial
yplot1 = polyval(fitResults1, xplot1);
% Plot the fit
fitLine1 = plot(xplot1,yplot1,'DisplayName','   cubic','Parent',axes1,...
    'Tag','cubic',...
    'Color',[0.75 0 0.75]);

% Set new line in proper position
setLineOrder(axes1, fitLine1, plot1);
end
%-------------------------------------------------------------------------%
function setLineOrder(axesh1, newLine1, associatedLine1)
%SETLINEORDER(AXESH1,NEWLINE1,ASSOCIATEDLINE1)
%  Set line order
%  AXESH1:  axes
%  NEWLINE1:  new line
%  ASSOCIATEDLINE1:  associated line

% Get the axes children
hChildren = get(axesh1,'Children');
% Remove the new line
hChildren(hChildren==newLine1) = [];
% Get the index to the associatedLine
lineIndex = find(hChildren==associatedLine1);
% Reorder lines so the new line appears with associated data
hNewChildren = [hChildren(1:lineIndex-1);newLine1;hChildren(lineIndex:end)];
% Set the children:
set(axesh1,'Children',hNewChildren);

end


