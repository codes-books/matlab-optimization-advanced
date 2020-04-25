function ret=Mutation1(pmutation,lenchrom,chrom,sizepop,num,maxgen,bound)
% ��������ɱ������
% pcorss                input  : �������
% lenchrom              input  : Ⱦɫ�峤��
% chrom     input  : Ⱦɫ��Ⱥ
% sizepop               input  : ��Ⱥ��ģ
% opts                  input  : ���췽����ѡ��
% pop                   input  : ��ǰ��Ⱥ�Ľ������������Ľ���������Ϣ
% bound                 input  : ÿ��������Ͻ���½�
% maxgen                input  ������������
% num                   input  : ��ǰ��������
% ret                   output : ������Ⱦɫ��
k1 = 0.6;   k2 = 0.7;
k3 = 0.001; k4 = 0.01;
% ������Ӧ��
for j=1:sizepop
    x=chrom(j,:);    % ����
    f(j)=fun1(x);     % Ⱦɫ�����Ӧ�� 
end
fmax = max(f);      % ��Ӧ�����ֵ
fmin = min(f);      % ��Ӧ����Сֵ
favg = mean(f);     % ��Ӧ��ƽ��ֵ

for i=1:sizepop   %ÿһ��forѭ���У����ܻ����һ�α��������Ⱦɫ�������ѡ��ģ�����λ��Ҳ�����ѡ��ģ�
    %������forѭ�����Ƿ���б���������ɱ�����ʾ�����continue���ƣ�
    % ���ѡ��һ��Ⱦɫ����б���
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);
    
     f1 = fun1( chrom(index(1),:) );  % ������Ӧ��ֵ
     f3 = max(f1);                   % �����д���
     if f3>=favg
         pmutation = k3*(fmax - f3)./(fmax-favg);
     else
         pmutation = k4;
     end
    
    % ������ʾ�������ѭ���Ƿ���б���
    pick=rand;
    if pick>pmutation
        continue;
    end
    flag=0;
    num = 0;
    chrom1 = chrom(i,:);
    while flag==0&&num<=20 
        % ����λ��
        pick=rand;
        while pick==0      
            pick=rand;
        end
        pos=ceil(pick*sum(lenchrom));  %���ѡ����Ⱦɫ������λ�ã���ѡ���˵�pos���������б���
    
        pick=rand; %���쿪ʼ     
        fg=(rand*(1-num/maxgen))^2;
        if pick>0.5
            chrom(i,pos)=chrom(i,pos)+(bound(pos,2)-chrom(i,pos))*fg;
        else
            chrom(i,pos)=chrom(i,pos)-(chrom(i,pos)-bound(pos,1))*fg;
        end   %�������
        flag=test(lenchrom,bound,chrom(i,:));     %����Ⱦɫ��Ŀ�����
         num = num+1;  % �����������
    end
    if num>20         % �������20�Σ��򲻱���
        chrom(i,:) = chrom1;
    end
end
ret=chrom;