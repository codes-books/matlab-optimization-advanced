%ʵ�ָ���Ľ���ļ���
function [objx]=calx(pop)
% global N length  % Ĭ��Ⱦɫ��Ķ����Ƴ���length=10
N=12; length=10;
for j=1:N  %���룡
   temp(:,j)=decodechrom(pop,1+(j-1)*length,length);      %��newpopÿ��(���壩ÿ�У�ÿ�λ���ת����ʮ������
   x(:,j)=temp(:,j)/(2^length-1)*(max(j)-min(j))+min(j);     % popsize��N ����ֵ���е���ת��Ϊ���������       
end
objx = x;         % ʵ�ָ���Ľ���ļ���