%%
%����������
L=4000;                         %LΪ������·���ܳ�
b=2;                            %��վ����м������ֵ
N=10;                           %N����վ
Q=4;                            %������·���д���
q=0;                            %qΪ�������д���������
flagn=0;                        %flagΪ�������п��Ʊ���
w=10;                           %wΪ����
dt=2   ;                      %dettΪʱ�䲽��
dett1=3 ;                       %dett1Ϊÿ���ϳ�����ʱ��
dett2=10 ;                      %dett2Ϊ�ȳ����������ʣ�ÿ����ʱ������һ���ȳ��ˣ�
M=floor(Q*4000/dt/w)+1;       %�ܵ����в�����
detbus=w*dt;                  %��λʱ��dett�ڳ�����ʻ��·��
stopgap=4000/N;              %���ڳ�վ֮��ļ�ࣨ���֣�
t=stopgap:stopgap:4000;   %��վ�����ʼ��վ��1վ���ľ���
e=detbus/2;                     %eΪ����վ������ĳ��복վ������ݲ�ֵ
n=zeros(N,2);                   %nΪ��վ��ʼ�ȳ�����,��վ״̬ 

xx=linspace(0,4000,N+1);        %����վ��ĺ�����
yy=0:1000:4000;                 %������·�ĺ�����
wt=0.01;                        %pause�ĵȴ�ʱ��
detbusij=zeros(3,M);            %��ʱ�����ڳ�����ľ���
time=stopgap/detbus;         %���ڳ�վ�䳵������ʱ��
c=floor(M/time)+1;              %�趨���������ĳ�վ��
busn=zeros(4,c);                %�趨����������վʱ�ϳ�����
flag=zeros(4,1);                %����ͨ��1վ��־
m=0;                            %mΪѭ������
%%
%����λ�ó�ʼ��������λ�ÿɵ�
bus(1,1)=0;                     %1����ʼ���г�
bus(2,1)=500;                   %2����ʼ���г�
bus(3,1)=1000;                  %3����ʼ���г�
bus(4,1)=1500;                  %4����ʼ���г�

for j=1:4
    bus(j,2)=0;                 %������վ��־
    bus(j,3)=floor(bus(j,1)/(4000/N))+1; %��ʼ��������/�չ���վ�ı��
    bus(j,4)=bus(j,1);          %��ʼ�������복1λ�õľ���
    bus(j,5)=0;                 %��ʼ�����ȳ�ʱ��
    bus(j,6)=0;                 %��ʼ�����ϳ�����
    num(j,1)=1;                 %���ø��������ĳ�վ��
end
%%ѭ����������
for  k=1:M                             %MΪ�ܵ�ʱ�䲽��
     n(:,1)=n(:,1)+1.0*dt/dett2;     %���������ɸ�վ�㰴ʱ��������ӵȴ�����
    for j=1:4
        a=bus(j,3);                    %������������·�α�Ÿ���a
        if a>N                         %���ж���䱣֤·�α�Ų��������·�α��
                a=a-N;
        end
        %���ж�����ж������ĵ�վ״̬
        if  bus(j,2)==0                %����Ϊ��վ״̬
            bus(j,1)=bus(j,1)+detbus ; %k ʱ�̸�������λ��
            bus(j,4)=bus(j,4)+detbus ; %kʱ�̸�������0λ�õ��ܵľ���
             if bus(1,4)>=4000*Q
                    flagn=1;
             end
            if bus(j,1)>4000           %���ж���䱣֤����λ��ʼ����������·��
                bus(j,1)=bus(j,1)-4000;
                if bus(j,1)<e
                       flag(j,1)=1;
                else
                       bus(j,3)=1;     %����䱣֤·�α�Ų��������·�α��
                end
            end
            if flag(j,1)==1
                    h=0;
            else 
                    h=t(a);
            end
            m=h-bus(j,1);              %�жϸ�������һվ�ľ���
            if abs(m)<=e               %eΪ����վ������ĳ��복վ������ݲ�ֵ
                  bus(j,2)=1;          %ȷ����վ�󣬸��ĸ�����վ��־           
            end
        else                           %������վ״̬
            b=a+1;
            if  b>N                    %���ж���䱣֤��վ��Ų��������վ���
                b=b-N;
            end
            if n(b,1)>1.0*dt/dett1
                  bus(j,6)=bus(j,6)+1.0*dt/dett1; %�����ϳ�����
            elseif  n(b,1)>0      
                  bus(j,6)=bus(j,6)+n(b,1);         %�����ϳ�����
            else  
                  bus(j,6)=bus(j,6)+0;              %�����ϳ�����
            end
           n(b,1)=n(b,1)-1.0*dt/dett1;            %����վ�󣬰��������ɸ�վ�㰴ʱ����������ϳ�����
            if  n(b,1)<=0
                n(b,1)=0;
                num(j,1)=num(j,1)+1;                %���Ӿ�����վ����
                d=num(j,1);             
                busn(j,d)=bus(j,6) ;                %�վ����ĳ�վ�ϳ�����
                bus(j,6)=0;                         %�������ϳ���������
                n(b,2)=1;                           %���ĸ�վ�ϳ�/�ȳ�״̬���ĸ�����վ��־
                if flag(j,1)==1
                            bus(j,3)=1;             %�����������/�չ�·�εı��
                            flag(j,1)=0;            %�����1վ��־
               else
                            bus(j,3)=a+1;           %�����������/�չ�·�εı��
               end
            end
            if n(b,2)==1                            %���ж�����ж��Ƿ���ĸ�����վ��־
                 n(b,2)=0;                          %���ĸ�վ�ϳ�/�ȳ�״̬���ĸ�����վ��־
                 bus(j,2)=0;                        %���ĸ�����վ��־
            end
      end
    end 
    plot(xx(1:end-1),ones(1,N)*L,'.','Markersize',6);   %������վ��͹�����·
    hold on;
    plot(yy,ones(1,length(yy))*L,'-');                  %��bus·��
    plot(bus(1,1),L,'sk','MarkerFaceColor','r','Markersize',15);                    %��bus1·��
    plot(bus(2,1),L,'sk','MarkerFaceColor','g','Markersize',15);                    %��bus2·��
    plot(bus(3,1),L,'sk','MarkerFaceColor','c','Markersize',15);                    %��bus3·��
    plot(bus(4,1),L,'sk','MarkerFaceColor','y','Markersize',15);                    %��bus4·��
    axis equal
    for j=1:N;                                             %ѭ�������ʾ��վ�ȳ�����
        r=L;
        r=r-n(j,1);                                        %���߳���ʾ�ȳ���������
        GRAP=plot([xx(j),xx(j)],[L,r],'-','LineWidth', 6);%��ͼ
              
    end
    pause(wt);                                             %���Ʒ���Ч��
    hold off;
    m=k;
    detbusij(1,k)=bus(2,4)-bus(1,4);
    detbusij(2,k)=bus(3,4)-bus(2,4);
    detbusij(3,k)=bus(4,4)-bus(3,4);
    detbusij;
    if flagn==1
        break;
    end
end
Max=max(num);
busnum=busn(:,1:Max) ;                                     %busnumΪ����������վ���ϳ�����
detbusijnum=detbusij*L ;                                  %detbusijnumΪ���ڳ���ĳ����
busnum'                                                    %�������������վ���ϳ�����
detbusijnum'                                               %������ڳ���ĳ����
