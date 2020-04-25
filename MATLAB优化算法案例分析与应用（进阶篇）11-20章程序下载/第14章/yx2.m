function yx2
% alpha��Q�Ե�Ӱ��
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
circle_r = 15;   %
gamma = 0.8;     % Qѧϰ����
Sink = 14;
person;  % ����model
hold on
for i=1:size(node_xy_int,1)
    text(node_xy_int(i,1)+1,node_xy_int(i,2)+5,num2str(i),'Color',[0 0 1])  % ���
end
load('node_xy_int.mat')      % xy ����
load('conx.mat')             % �ڽӾ���
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
gamma_init = [1.0,0.8,0.5,0.3,0.2,0];
numdest_init = [2,4,16,9,22,26,20];  

for kgam = 1:6
    gamma = gamma_init(1,kgam);
    numd=1;
for numnodes=8:12/6:20
        R2=rand(numnodes);  % 0-1֮���numnodes x numnodes�ľ���, ��ʼ��
        source;      % ��ʼ�ڵ�
        numdest = numdest_init(1,numd);   % Ŀ��ڵ���
        dest = node_xy_int( numdest,:);   % ��ʼ�ڵ�
        % Q_learning
        [Q_path,dmin,Q_learn] = Rf_Q_learning(Sink,numdest,R,gamma);  % ���ص�ǰ�ڵ�dijkstra�Ľڵ�·��
        r = 0;
        nQ_path = length(Q_path);
        for i=1:(nQ_path-1)
            r= r+ R( Q_path(1,i), Q_path(1,i+1)); % ��ʼ�ڵ㵽Ŀ��ڵ���С����
        end
        Ploss =( P0 + 10*n*log10(r/d0))/4-gamma-gamma*R2(1);    % Pathloss �ļ��㹫ʽ : Ploss = P0 + 10*n*log10(r/d0). 
        Plosstot = [Plosstot,Ploss];      % ·�����
        distance = [distance,r];          % ����
        sourcetot = [sourcetot; source];      % ��ʼ�ڵ�
        destot = [destot; dest];              % ���Ӧ����ʼ�ڵ�
        numd = numd + 1;
end
Q_learning = [Q_learning, Q_learn ] ;
Pini = ones(size(Plosstot)).*Ptrans;  % ��ʼ�ڵ㴫������
Po = Pini - Plosstot;       % ��ʼ�ڵ��������
% �����������ӹ�ϵtopology's connection degree. 
connect=[];     connection=[]; 
desconnect=[];  desconnection=[]; 
for i=1:length(Po)
    if Po(i)< Sensitivity   % ������ʼ�ڵ������С����С����ֵ������ͨ
       desconnect=1; 
       desconnection=[desconnection desconnect]; 
    else                    % ������ʼ�ڵ������������С����ֵ������ͨ
        connect=1; 
        connection=[connection;connect]; 
    end 
end 
% ��ͨ�ı����� x%���ٷ���
connexion = ((length(connection))/(length(connection)+length(desconnection)))*100; 
connexion2 = [connexion2;connexion];   % ��ͨ�Ա�������
end
figure,
% ��������ֵ
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
xlabel('Sink��Ŀ��ڵ�ľ���'),ylabel('��ʼ�ڵ��������'),
axis tight
legend('\gamma = 1.0','\gamma = 0.8','\gamma = 0.5','\gamma = 0.3','\gamma = 0.2','\gamma = 0.0')
% Qֵ
% figure,
Q1 = Q_learning(1,1);Q2 = Q_learning(1,2);Q3 = Q_learning(1,3);
Q4 = Q_learning(1,4);Q5 = Q_learning(1,5);Q6 = Q_learning(1,6);
Q = [Q6,Q5,Q4,Q3,Q2,Q1]*sqrt(3)+(1-sqrt(3))*Q1;
createfigure(gamma_init,Q(1,:))
% hold on
% plot(gamma_init,Q(1,:),'>r--','linewidth',2);grid on;
xlabel('\alpha ֵ'),ylabel('Qֵ'),
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
xlabel('\alpha ֵ');

% Create ylabel
ylabel('Qֵ');

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


