%ʵ��Ŀ�꺯���ļ���
function [objvalue]=calobjvalue(pop,i)
global length N min max code;          % Ĭ��Ⱦɫ��Ķ����Ƴ���length=10
distance=0;
for j=1:N
    temp(:,j)=decodechrom(pop,1+(j-1)*length,length);%��popÿ��(���壩ÿ�У�ÿ�λ���ת����ʮ������
    x(:,j)=temp(:,j)/(2^length-1)*(max(j)-min(j))+min(j);    % popsize��N ����ֵ���е���ת��Ϊ���������   
    distance=distance+(x(:,j)-code(i,j)).^2;                 % ����popsize����ͬ�ľ���
end
objvalue=sqrt(distance);         %����Ŀ�꺯��ֵ��ŷ�Ͼ���