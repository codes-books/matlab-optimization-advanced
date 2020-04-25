function [m,s,Pa,iter,Q_tot,e_tot]=em_alg_function(x,m,s,Pa,e_min)
% ��ʽʹ�ø�ʽ:
%  [m,s,Pa,iter,Q_tot,e_tot]=em_alg_function(x,m,s,Pa,e_min)
%  EM�㷨���ƻ�ϸ�˹�ֲ�����
% ����:
%   x:      lxN ����, ÿһ����һ����������
%   m:      lxJ ����, ��ֵ��ֵ
%   s:      1xJ ����, ��j��Ϊ��j����˹�ֲ���Э����ֵ
%   Pa:     J-ά����, ��j��Ϊ��j����˹�ֲ����������ֵ
%   e_min:  ������ֹ��ֵ
%���:
%   m:      ��̬�ֲ��ľ�ֵ��ֵ
%   s:       ��̬�ֲ���Э�����ֵ
%   Pa:     J-dimensional vector, ������ʹ�ֵ
%   iter:     ����������
%   Q_tot:  ÿ�ε�������Ȼֵ
%   e_tot:  ÿ�ε��������ֵ
x=x';   							% ת��
m=m';  							% ת��
[p,n]=size(x);   					% ����ά��
[J,n]=size(m);  					% ����ά��
 
e=e_min+1;
 
Q_tot=[];  						% ��ʼ��
e_tot=[];   						% ��ʼ��
 
iter=0;
while (e>e_min)
    iter=iter+1;  					% ��������
    e;
    
    P_old=Pa;  					% ��ǰֵ������һ��ֵ
    m_old=m;  					% ��ǰֵ������һ��ֵ
    s_old=s;   					% ��ǰֵ������һ��ֵ
    
    % ȷ��P(j|x_k; theta(t))
    for k=1:p
        temp=gauss(x(k,:),m,s);
        P_tot=temp*Pa';
        for j=1:J
            P(j,k)=temp(j)*Pa(j)/P_tot;
        end
    end
    
    % ������Ȼ����ֵ
    Q=0;
    for k=1:p
        for j=1:J
            Q=Q+P(j,k)*(-(n/2)*log(2*pi*s(j)) - sum( (x(k,:)-m(j,:)).^2)/(2*s(j)) + log(Pa(j)) );
        end
    end
    Q_tot=[Q_tot Q];
    
    % ȷ����ֵ
    for j=1:J
        a=zeros(1,n);
        for k=1:p
            a=a+P(j,k)*x(k,:);
        end
        m(j,:)=a/sum(P(j,:));
    end
    
    % ȷ������
    for j=1:J
        b=0;
        for k=1:p
            b=b+ P(j,k)*((x(k,:)-m(j,:))*(x(k,:)-m(j,:))');
        end
        s(j)=b/(n*sum(P(j,:)));
        
        if(s(j)<10^(-10))  			% ��СֵԼ��
            s(j)=0.001;
        end
        
    end
    
    %�������ֵ
    for j=1:J
        a=0;
        for k=1:p
            a=a+P(j,k);
        end
        Pa(j)=a/p;
    end
    
    e=sum(abs(Pa-P_old))+sum(sum(abs(m-m_old)))+sum(abs(s-s_old));    
    e_tot=[e_tot e];    
end
