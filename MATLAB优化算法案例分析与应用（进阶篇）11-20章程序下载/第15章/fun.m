function fitt = fun(t)
%�ú�������������Ӧ��ֵ
global PP C L m f p tt
% PP = 1;    % ��ʾͳһƱ��(Ԫ/��)
% C = 3.5;  % ��ʾ������Ӫ�ĵ�λ��ĳɱ�(Ԫ/��.����)
% L = 26.5; % ��ʾ������·�ܵĳ���(����)
% m = 500;  % ��ʾ�ܵķ�������(����)
% f = 2;    % ��ʾ����Ա����
% p = 10;   % ��ʾ����Ա����

fitt=0;      % ��ʼ��
for i=1:length(t)
    if t(i)<60
        r = 1638;
    elseif t(i)>=60&&t(i)<180
        r = 3276;
    elseif t(i)>=180&&t(i)<240
        r=2457;
    elseif t(i)>=240&&t(i)<300
        r = 1638;
    elseif t(i)>=300&&t(i)<480
        r = 819;
    elseif t(i)>=480&&t(i)<600
        r=1638;
    elseif t(i)>=600&&t(i)<660
        r = 2457;
    elseif t(i)>=660&&t(i)<780
        r = 3276;
    elseif t(i)>=780&&t(i)<840
        r = 2457;
    elseif t(i)>=840&&t(i)<900
        r = 1638;
    elseif t(i)>=900
        r = 819;
    end
    
    fitt = fitt + r*tt*PP - (C*L*m+tt*f*p);   % R'����Ӧ��
    
end







