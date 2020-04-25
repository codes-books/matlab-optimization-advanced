clc,clear,close all
warning off
figure('color',[1,1,1])  % 白色背景
axis([0 101 0 101]);
hold on; 
NumOfNodes = 400;  % 节点数
Range = 2;     % 
breadth = 0;   % 
display_node_numbers = 1;
num_len =[];
%创建城市交通网络
for length=0:100
    for breadth=0:100
        city(length+1,breadth+1)=breadth;
    end
end
city(:,[1,11,21,31,41,51,61,71,81,91,101])=[];
city([1,11,21,31,41,51,61,71,81,91,101],:)=[];
plot(city',city,'.g','markersize',6)
axis off
%% 产生节点（车载网络中的车辆）
Node = zeros(NumOfNodes,5); % 1:X, 2:Y, 3:更新后的X, 4:更新后的Y, 5:车辆运动方向
%获取随机节点——在相应的公路上产生节点
for node_index = 1:NumOfNodes    % NumOfModes = 400
    TempX = randint(1,1,[0,100]);
    if (rem(TempX,10)==0)
        Node(node_index,1) = TempX;       % X坐标
        Node(node_index,2) = randint(1,1,[0,100]); % Y坐标
    else
        Node(node_index,2) = 10*(randint(1,1,[0,10])); % Y坐标
        Node(node_index,1) = randint(1,1,[0,100]); % X坐标
    end
end
% plot(Node(:,1),Node(:,2),'.k')

%% 车辆防碰撞仿真
h2 = ones(NumOfNodes,1);   % 初始化 1   NumOfModes = 400
h3 = ones(NumOfNodes,1);   % 初始化 1   NumOfModes = 400
for n = 0:100   % 步数
    n        % iter
    for node_index = 1:NumOfNodes    % NumOfModes = 400
        if(rem(Node(node_index,1),10)~=0)      % x方向车辆节点沿x轴运动，y不变
            % 画图句柄，如果关图形显示窗口，则相应的程序中断
            h2(node_index) = plot(Node(node_index,1)+n*(2*(rem(node_index,2))-1), Node(node_index,2),'.k');
            % 更新x坐标，Node = zeros(NumOfNodes,5); % 1:X, 2:Y, 3:更新后的X, 4:更新后的Y, 5:车辆运动方向
            Node(node_index,3) = Node(node_index,1)+n*(2*(rem(node_index,2))-1);
            % Y不变
            Node(node_index,4) = Node(node_index,2);
            % 粒子运动的方向
            Node(node_index,5) = rem(node_index,2)+2;
        else   % y方向车辆节点沿y轴运动，x不变
            % 画图句柄，如果关图形显示窗口，则相应的程序中断
            h2(node_index) = plot(Node(node_index,1),Node(node_index,2)+n*(2*(rem(node_index,2))-1),'.k');
            % x不变
            Node(node_index,3) = Node(node_index,1);
            % 更新y坐标，Node = zeros(NumOfNodes,5); % 1:X, 2:Y, 3:更新后的X, 4:更新后的Y, 5:车辆运动方向
            Node(node_index,4) = Node(node_index,2)+n*(2*(rem(node_index,2))-1);
            % 粒子运动的方向
            Node(node_index,5) = rem(node_index,2);
        end
    end
    for p = 1:NumOfNodes       % 400 
        for q = 1:NumOfNodes   % 400
            if(p~=q) 
                % 判断不同的粒子之间的的距离  
                % Range = 2; 小于2 警示作用
                if((abs(Node(q,3)-Node(p,3))<=Range) && (abs(Node(q,4)-Node(p,4))<=Range))
                    if(Node(q,5) ~= Node(p,5)) % 方向不同，碰撞
                        plot(Node(p,3),Node(p,4),'xb');
                        % 距离小于等于1，下一时刻碰撞，一步一格
                        if(((rem(Node(p,3),10))<=Range-1) && ((rem(Node(p,4),10))<=Range-1))
                            plot(Node(q,3),Node(q,4),'or')
                        end
                    end
                end
            end
        end
    end
    pause(0.1); 
    set(h2(),'Visible','off');
end
