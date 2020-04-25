function ret=Cross(pcross,lenchrom,chrom,sizepop,bound)
%��������ɽ������
% pcorss                input  : �������
% lenchrom              input  : Ⱦɫ��ĳ���
% chrom     input  : Ⱦɫ��Ⱥ
% sizepop               input  : ��Ⱥ��ģ
% ret                   output : ������Ⱦɫ��
k1 = 0.6;   k2 = 0.7;
k3 = 0.001;  k4 = 0.01;
% ������Ӧ��
for j=1:sizepop
    x=chrom(j,:);    % ����
    f(j)=fun(x);     % Ⱦɫ�����Ӧ�� 
end
fmax = max(f);      % ��Ӧ�����ֵ
fmin = min(f);      % ��Ӧ����Сֵ
favg = mean(f);     % ��Ӧ��ƽ��ֵ

 for i=1:sizepop  %ÿһ��forѭ���У����ܻ����һ�ν��������Ⱦɫ�������ѡ��ģ�����λ��Ҳ�����ѡ��ģ�%������forѭ�����Ƿ���н���������ɽ�����ʾ�����continue���ƣ�
     % ���ѡ������Ⱦɫ����н���
     pick=rand(1,2);       
     while prod(pick)==0
         pick=rand(1,2);
     end
     index=ceil(pick.*sizepop);  
     
     f1 = fun( chrom(index(1),:) );  % ������Ӧ��ֵ
     f2 = fun( chrom(index(2),:) );  % ������Ӧ��ֵ
     f3 = max(f1,f2);                % �����д���
     if f3>=favg
         pcross = k1*(fmax - f3)./(fmax-favg);
     else
         pcross = k2;
     end
     
     % ������ʾ����Ƿ���н���
     pick=rand;
     while pick==0
         pick=rand;
     end
     if pick>pcross
         continue;
     end
     flag=0;
     while flag==0
         % ���ѡ�񽻲�λ
         pick=rand;
         while pick==0
             pick=rand;
         end
         pos=ceil(pick.*sum(lenchrom)); %���ѡ����н����λ�ã���ѡ��ڼ����������н��棬ע�⣺����Ⱦɫ�彻���λ����ͬ
         pick=rand; %���濪ʼ
         v1=chrom(index(1),pos);
         v2=chrom(index(2),pos);
         chrom(index(1),pos)=pick*v2+(1-pick)*v1;
         chrom(index(2),pos)=pick*v1+(1-pick)*v2; %�������
         flag1=test(lenchrom,bound,chrom(index(1),:));  %����Ⱦɫ��1�Ŀ�����
         flag2=test(lenchrom,bound,chrom(index(2),:));  %����Ⱦɫ��2�Ŀ�����
         if   flag1*flag2==0
             flag=0;
         else flag=1;
         end    %�������Ⱦɫ�岻�Ƕ����У������½���
     end
 end
ret=chrom;