function plot_data(X,y,m,h)
% ��ͼ��ʵ�ֲ�ͬ�������࣬�ò�ͬ����ɫ��ʾ
% ����:
%   X:  lxN matrix, ��ͼ����X������������һ��һ�л���
%   y:  N-dimensional vector���������
%   m:  lxc matrix, ��ֵ����.
%   h:  ͼ����
 
[l,N]=size(X); % N=no. of data vectors, l=dimensionality
[l,c]=size(m); % c=no. of classes
 
if(l~=2) || (c>7)
    fprintf('����ά�������⣬����\n')
    return
else
    pale=['r.'; 'g.'; 'b.'; 'y.'; 'm.'; 'c.';'co'];
    figure(h)
    % ��ͼ
    hold on
    for i=1:N
        plot(X(1,i),X(2,i),pale(y(i),:))
        hold on
    end
    
    % ��������������
    for j=1:c
        plot(m(1,j),m(2,j),'k+')
        hold on
    end
end


