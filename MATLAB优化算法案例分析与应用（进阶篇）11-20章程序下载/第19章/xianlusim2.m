clc,clear,close all
axis([0 100 0 100]);
hold on
nodes = 5;         % �ڵ����
PauseTime = 0.1;   % pauseʱ��
[x,y] = ginput(nodes);
plot(x,y,'-ks','LineWidth',8,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',8)        
[p,q] = ginput(nodes);
plot(p,q,'-ks','LineWidth',8,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',8)   
Sa = 5; % ��С��ȫ����
% ��ʼ��
xp = x(1);
yp = y(1);
pp = p(1);
qp = q(1);
m = 0; 
n = 0; 
k =1 ;
for i = 2:nodes
    xc = x(i); 
    yc = y(i); 
    xp = x(i-1);
    yp = y(i-1);
    pc = p(i);
    qc = q(i);
    pp = p(i-1);
    qp = q(i-1);
    
    m = floor(sqrt((xp-xc)*(xp-xc)+(yp-yc)*(yp-yc)))
    n = floor(sqrt((pp-pc)*(pp-pc)+(qp-qc)*(pp-qc)))
    a1 = linspace(xp,xc,m);
    b1 = linspace(yp,yc,m);
    aa1 = a1;
    bb1 = b1;
    na = length(a1);
    a2 = linspace(pp,pc,m);
    b2 = linspace(qp,qc,m);
    for j = 2:m
        v1(k) = sqrt((xp-xc)*(xp-xc)+(yp-yc)*(yp-yc)) /m;  % �쳵1�ٶ�
        v2(k) = sqrt((pp-pc)*(pp-pc)+(qp-qc)*(qp-qc)) /m;  % ����2�ٶ�
        S(k) = sqrt( (a1(j)-a2(j))^2 + (b1(j)-b2(j))^2 );
        if S(k)<Sa
            S(k) = sqrt( (a1(j-1)-a2(j))^2 + (b1(j-1)-b2(j))^2 );
            
            aa1(j) = a1(j-1);
            aa1(j+1) = a1(j-1);
            aa1 = [aa1(1,1:j+1),a1(1,j:na)];
            bb1(j) = b1(j-1);
            bb1(j+1) = b1(j-1);
            bb1 = [bb1(1,1:j+1),b1(1,j:na)];
            v1(k) = 0;  % �쳵1�ٶ�
        end
        k=k+1;
        a1 = aa1;
        b1 = bb1;
    end
    
end
figure,
plot(S,'r','linewidth',3)
grid on
xlabel('t')
ylabel('S���о���')

figure,
VH1 = 0:0.1:2;
VG1 = 0:0.1:2;
[VH2,VG2] = meshgrid(VH1,VG1);
Smin1 = griddata(v1,v2,S,VH2,VG2,'v4');
surf(VH2,VG2,Smin1)
xlabel('��ɫ�ٶ�V')
ylabel('�̳��ٶ�V')
zlabel('�����������а�ȫ����')



