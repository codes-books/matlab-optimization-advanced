% decodechrom.m�����Ĺ����ǽ�Ⱦɫ��(������Ʊ���)ת��Ϊʮ���ƣ�����spoint��ʾ������Ķ����ƴ�����ʼλ��
% (���ڶ���������ԣ�������������������20Ϊ��ʾ��ÿ������10Ϊ�����һ��������1��ʼ����һ��������11��ʼ������Ϊ1)��
% ����1ength��ʾ����ȡ�ĳ��ȣ�����Ϊ10����
%�Ŵ��㷨�ӳ���
%Name: decodechrom.m
%�������Ʊ���ת����ʮ����
function pop2=decodechrom(pop,spoint,length)
pop1=pop(:,spoint:spoint+length-1); %���ӵڡ�spoint��λ��ʼ���ڡ�spoint+length-1��λ�������λ��ʾһ��������ȡ��
pop2=decodebinary(pop1);   %�������溯����decodebinary(pop)�����ö����Ʊ�ʾ�ĸ�������Ϊʮ������,�õ�popsize��1��������