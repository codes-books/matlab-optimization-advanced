clc,clear,close all;
warning off
global popsize length min max N code;
N=12;                % ÿ��Ⱦɫ�������ʮ���Ʊ���λ����
M=100;               % ��������
popsize=30;          % ���ó�ʼ������Ⱥ���С
length=10;           % lengthΪÿ�λ���Ķ����Ʊ���λ��
chromlength=N*length;  % �ַ������ȣ����峤�ȣ���Ⱦɫ��Ķ����Ʊ��볤��
pc=0.7;                % ���ý�����ʣ������н�������Ƕ�ֵ���������ñ仯�Ľ�����ʿ��ñ��ʽ��ʾ�����дһ��������ʺ�����������������ѵ���õ���ֵ��Ϊ�������
pm=0.3;                % ���ñ�����ʣ�ͬ��Ҳ������Ϊ�仯��
bound={-100*ones(popsize,1),zeros(popsize,1)};
min=bound{1};max=bound{2};
pop=initpop(popsize,chromlength);                     %���г�ʼ�����������������ʼȺ��
ymax=500;   % ��Ӧ��ֵ��ʼ��

ysw_x = zeros(3,12);
%����C2:�������ͱ��룬ÿһ��Ϊһ�֣�code(1,:)��������code(2,:)��50����code(3,:)��150��
code =[-0.8180   -1.6201  -14.8590  -17.9706  -24.0737  -33.4498  -43.3949  -53.3849  -63.3451  -73.0295  -79.6806  -74.3230
       -0.7791   -1.2697  -14.8682  -26.2274  -30.2779  -39.4852  -49.4172  -59.4058  -69.3676  -79.0657  -85.8789  -81.0905
       -0.8571   -1.9871  -13.4385  -13.8463  -20.4918  -29.9230  -39.8724  -49.8629  -59.8215  -69.4926  -75.9868  -70.6706];

for i=1:3   % 3�ֹ���ģʽ��ÿ��ģʽӦ�ò��� popsize �ּ���������壩��ÿ�ּ�����ĳ��Ⱥ͹��ϱ���ĳ�����ͬ
    pop=initpop(popsize,chromlength);                     %���г�ʼ�����������������ʼȺ��
    for k=1:M
       [objvalue]=calobjvalue(pop,i);                 %����Ŀ�꺯��
       fitvalue=calfitvalue(objvalue); favg(k)=sum(fitvalue)/popsize;  %����Ⱥ����ÿ���������Ӧ��
       newpop=selection(pop,fitvalue); objvalue=calobjvalue(newpop,i); %ѡ��
       newpop=crossover(newpop,pc,k);  objvalue=calobjvalue(newpop,i); %����
       newpop=mutation(newpop,pm);     objvalue=calobjvalue(newpop,i); %����
       [bestindividual,bestfit]=best(newpop,fitvalue);%���Ⱥ������Ӧֵ��С�ĸ��弰����Ӧֵ
       if bestfit<ymax
          ymax=bestfit;
           for j=1:N  %���룡
               temp(:,j)=decodechrom(bestindividual,1+(j-1)*length,length);      %��newpopÿ��(���壩ÿ�У�ÿ�λ���ת����ʮ������
               x(:,j)=temp(:,j)/(2^length-1)*(max(j)-min(j))+min(j);     % popsize��N ����ֵ���е���ת��Ϊ���������       
           end
          ysw_x(i,:) = x;  %���룡
       end
       y(i,k)=ymax;
       if ymax<10     % ������ֵС���趨��ֵ��ֹͣ����
           break
       end
       pop=newpop;
   end  
end

ysw_x   % ���Ϊ(i*popsie)������������壩
plot(1:M,favg)