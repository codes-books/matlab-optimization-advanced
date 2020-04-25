% ����t(i)����
function t = pop_meet_conditions(maxt)
global Tmin Tmax delta m tt PP Q cita
% �������˵����
% Tmin = 1;   % ��ʾ���ڳ����䷢���������Сֵ(min)
% Tmax = 10;  % ��ʾ���ڳ����䷢����������ֵ(min)
% delta = 4;  % ��ʾ���ڳ����������֮�������ֵ
% m = 500;    % ��ʾ�ܵķ�������(����)
% maxt = 960;    % t(i)�����ֵ

% �������˵����
% tΪ���������ĸ���

a = randi(10);  % t(1)��һ��ֵ��ȡֵ��Χ�趨Ϊ1-10֮�����ȡֵ
t(1) = a;       % ��ֵ

flag = 1;       % ��־����
% Loop
while flag==1
    
    for i=2:m
        flag = 1;       % ��־����
        while flag == 1
            % Tmin< t(i)-t(i-1) < Tmax
            a1 = randi(9);
            if a1>Tmin+2 && i==2
                t(i)=t(i-1)+a1; % Tmin < t(i)-t(i-1) < Tmax
                flag = 0;   % i ʱ���������
            elseif a1>Tmin+2 && i>2  % |t(i+1)-2*t(i)+t(i-1)|<delta 
                t(i)=t(i-1)+a1; % Tmin < t(i)-t(i-1) < Tmax
                if abs( (t(i)-t(i-1)) -(t(i-1)-t(i-2)) )<delta
                    flag = 0;  % i ʱ���������
                end
            end
        end
    end
    
    t = t*maxt/max(t);  % ttΪ���������ĸ���
 
    % ƽ�������ʽ���Լ��
 for i=1:length(t)
    if t(i)<60
        r(i) = 1638;
    elseif t(i)>=60&&t(i)<180
        r(i) = 3276;
    elseif t(i)>=180&&t(i)<240
        r(i) = 2457;
    elseif t(i)>=240&&t(i)<300
        r(i) = 1638;
    elseif t(i)>=300&&t(i)<480
        r(i) = 819;
    elseif t(i)>=480&&t(i)<600
        r(i) = 1638;
    elseif t(i)>=600&&t(i)<660
        r(i) = 2457;
    elseif t(i)>=660&&t(i)<780
        r(i) = 3276;
    elseif t(i)>=780&&t(i)<840
        r(i) = 2457;
    elseif t(i)>=840&&t(i)<900
        r(i) = 1638;
    elseif t(i)>=900
        r(i) = 819;
    end  
 end

 % Լ������
if sum(r*tt*PP)/m/Q > cita   % ƽ�������ʽ���Լ��
    flag = 0;
end

end


