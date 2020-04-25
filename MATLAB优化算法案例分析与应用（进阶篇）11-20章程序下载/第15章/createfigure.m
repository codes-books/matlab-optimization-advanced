function createfigure(X1, Y1)
%CREATEFIGURE(X1, Y1)
%  X1:  x ���ݵ�ʸ��
%  Y1:  y ���ݵ�ʸ��

%  �� MATLAB �� 24-Jul-2014 21:24:06 �Զ�����

% ���� figure
figure1 = figure('Color',[1 1 1]);

% ���� axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');

% ���� plot
plot1 = plot(X1,Y1,'Parent',axes1,'MarkerSize',20,'Marker','.',...
    'LineWidth',2,...
    'LineStyle','--',...
    'Color',[0 0 1],...
    'DisplayName','data1');

% ���� xlabel
xlabel('ʱ��');

% ���� ylabel
ylabel('����Ƶ��');

% ��ȡͼ�е� xdata
xdata1 = get(plot1, 'xdata');
% ��ȡͼ�е� ydata
ydata1 = get(plot1, 'ydata');
% ȷ������Ϊ��ʸ��
xdata1 = xdata1(:);
ydata1 = ydata1(:);


% ɾ�� NaN ֵ����������
nanMask1 = isnan(xdata1(:)) | isnan(ydata1(:));
if any(nanMask1)
    warning('GeneratedCode:IgnoringNaNs', ...
        '���� NaN ��������ݵ㽫�����ԡ�');
    xdata1(nanMask1) = [];
    ydata1(nanMask1) = [];
end

% �������ڻ��� xlim �������ͼ�� x ֵ
axesLimits1 = xlim(axes1);
xplot1 = linspace(axesLimits1(1), axesLimits1(2));


fitResults1 = polyfit(xdata1, ydata1, 10);
% �������ʽ
yplot1 = polyval(fitResults1, xplot1);
% �������ͼ
fitLine1 = plot(xplot1,yplot1,'DisplayName','   10 ��','Parent',axes1,...
    'Tag','10th degree',...
    'Color',[0.75 0 0.75]);

% ���������õ���ȷλ��
setLineOrder(axes1, fitLine1, plot1);

% ���� legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.138988095238093 0.777777777777778 0.185714285714286 0.188888888888889]);

%-------------------------------------------------------------------------%
function setLineOrder(axesh1, newLine1, associatedLine1)
%SETLINEORDER(AXESH1,NEWLINE1,ASSOCIATEDLINE1)
%  ������˳��
%  AXESH1:  ��
%  NEWLINE1:  ����
%  ASSOCIATEDLINE1:  �����

% ��ȡ���Ӽ�
hChildren = get(axesh1,'Children');
% ɾ������
hChildren(hChildren==newLine1) = [];
% ��ȡ����ߵ�����
lineIndex = find(hChildren==associatedLine1);
% �Ը��������������Ա�������ʾ��������
hNewChildren = [hChildren(1:lineIndex-1);newLine1;hChildren(lineIndex:end)];
% �����Ӽ�:
set(axesh1,'Children',hNewChildren);

