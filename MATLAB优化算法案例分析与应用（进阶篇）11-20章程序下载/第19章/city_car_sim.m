clc,clear,close all
warning off
figure('color',[1,1,1])  % ��ɫ����
axis([0 101 0 101]);
hold on; 
NumOfNodes = 400;  % �ڵ���
Range = 2;     % 
breadth = 0;   % 
display_node_numbers = 1;
num_len =[];
%�������н�ͨ����
for length=0:100
    for breadth=0:100
        city(length+1,breadth+1)=breadth;
    end
end
city(:,[1,11,21,31,41,51,61,71,81,91,101])=[];
city([1,11,21,31,41,51,61,71,81,91,101],:)=[];
plot(city',city,'.g','markersize',6)
axis off
%% �����ڵ㣨���������еĳ�����
Node = zeros(NumOfNodes,5); % 1:X, 2:Y, 3:���º��X, 4:���º��Y, 5:�����˶�����
%��ȡ����ڵ㡪������Ӧ�Ĺ�·�ϲ����ڵ�
for node_index = 1:NumOfNodes    % NumOfModes = 400
    TempX = randint(1,1,[0,100]);
    if (rem(TempX,10)==0)
        Node(node_index,1) = TempX;       % X����
        Node(node_index,2) = randint(1,1,[0,100]); % Y����
    else
        Node(node_index,2) = 10*(randint(1,1,[0,10])); % Y����
        Node(node_index,1) = randint(1,1,[0,100]); % X����
    end
end
% plot(Node(:,1),Node(:,2),'.k')

%% ��������ײ����
h2 = ones(NumOfNodes,1);   % ��ʼ�� 1   NumOfModes = 400
h3 = ones(NumOfNodes,1);   % ��ʼ�� 1   NumOfModes = 400
for n = 0:100   % ����
    n        % iter
    for node_index = 1:NumOfNodes    % NumOfModes = 400
        if(rem(Node(node_index,1),10)~=0)      % x�������ڵ���x���˶���y����
            % ��ͼ����������ͼ����ʾ���ڣ�����Ӧ�ĳ����ж�
            h2(node_index) = plot(Node(node_index,1)+n*(2*(rem(node_index,2))-1), Node(node_index,2),'.k');
            % ����x���꣬Node = zeros(NumOfNodes,5); % 1:X, 2:Y, 3:���º��X, 4:���º��Y, 5:�����˶�����
            Node(node_index,3) = Node(node_index,1)+n*(2*(rem(node_index,2))-1);
            % Y����
            Node(node_index,4) = Node(node_index,2);
            % �����˶��ķ���
            Node(node_index,5) = rem(node_index,2)+2;
        else   % y�������ڵ���y���˶���x����
            % ��ͼ����������ͼ����ʾ���ڣ�����Ӧ�ĳ����ж�
            h2(node_index) = plot(Node(node_index,1),Node(node_index,2)+n*(2*(rem(node_index,2))-1),'.k');
            % x����
            Node(node_index,3) = Node(node_index,1);
            % ����y���꣬Node = zeros(NumOfNodes,5); % 1:X, 2:Y, 3:���º��X, 4:���º��Y, 5:�����˶�����
            Node(node_index,4) = Node(node_index,2)+n*(2*(rem(node_index,2))-1);
            % �����˶��ķ���
            Node(node_index,5) = rem(node_index,2);
        end
    end
    for p = 1:NumOfNodes       % 400 
        for q = 1:NumOfNodes   % 400
            if(p~=q) 
                % �жϲ�ͬ������֮��ĵľ���  
                % Range = 2; С��2 ��ʾ����
                if((abs(Node(q,3)-Node(p,3))<=Range) && (abs(Node(q,4)-Node(p,4))<=Range))
                    if(Node(q,5) ~= Node(p,5)) % ����ͬ����ײ
                        plot(Node(p,3),Node(p,4),'xb');
                        % ����С�ڵ���1����һʱ����ײ��һ��һ��
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
