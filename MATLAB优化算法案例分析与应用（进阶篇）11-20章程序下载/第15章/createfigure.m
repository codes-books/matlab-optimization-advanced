function createfigure(X1, Y1)
%CREATEFIGURE(X1, Y1)
%  X1:  x 数据的矢量
%  Y1:  y 数据的矢量

%  由 MATLAB 于 24-Jul-2014 21:24:06 自动生成

% 创建 figure
figure1 = figure('Color',[1 1 1]);

% 创建 axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');

% 创建 plot
plot1 = plot(X1,Y1,'Parent',axes1,'MarkerSize',20,'Marker','.',...
    'LineWidth',2,...
    'LineStyle','--',...
    'Color',[0 0 1],...
    'DisplayName','data1');

% 创建 xlabel
xlabel('时间');

% 创建 ylabel
ylabel('发车频率');

% 获取图中的 xdata
xdata1 = get(plot1, 'xdata');
% 获取图中的 ydata
ydata1 = get(plot1, 'ydata');
% 确保数据为列矢量
xdata1 = xdata1(:);
ydata1 = ydata1(:);


% 删除 NaN 值并发出警告
nanMask1 = isnan(xdata1(:)) | isnan(ydata1(:));
if any(nanMask1)
    warning('GeneratedCode:IgnoringNaNs', ...
        '具有 NaN 坐标的数据点将被忽略。');
    xdata1(nanMask1) = [];
    ydata1(nanMask1) = [];
end

% 查找用于基于 xlim 绘制拟合图的 x 值
axesLimits1 = xlim(axes1);
xplot1 = linspace(axesLimits1(1), axesLimits1(2));


fitResults1 = polyfit(xdata1, ydata1, 10);
% 计算多项式
yplot1 = polyval(fitResults1, xplot1);
% 绘制拟合图
fitLine1 = plot(xplot1,yplot1,'DisplayName','   10 次','Parent',axes1,...
    'Tag','10th degree',...
    'Color',[0.75 0 0.75]);

% 将新线设置到正确位置
setLineOrder(axes1, fitLine1, plot1);

% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.138988095238093 0.777777777777778 0.185714285714286 0.188888888888889]);

%-------------------------------------------------------------------------%
function setLineOrder(axesh1, newLine1, associatedLine1)
%SETLINEORDER(AXESH1,NEWLINE1,ASSOCIATEDLINE1)
%  设置线顺序
%  AXESH1:  轴
%  NEWLINE1:  新线
%  ASSOCIATEDLINE1:  结合线

% 获取轴子级
hChildren = get(axesh1,'Children');
% 删除新行
hChildren(hChildren==newLine1) = [];
% 获取结合线的索引
lineIndex = find(hChildren==associatedLine1);
% 对各条线重新排序，以便新线显示关联数据
hNewChildren = [hChildren(1:lineIndex-1);newLine1;hChildren(lineIndex:end)];
% 设置子级:
set(axesh1,'Children',hNewChildren);

