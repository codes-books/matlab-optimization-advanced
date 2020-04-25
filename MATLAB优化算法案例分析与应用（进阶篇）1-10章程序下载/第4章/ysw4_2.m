clc,clear,close all
warning off
%%%%����7x7�����ͼƬ
I0=imread('.\��������ͼƬ\num0_1.bmp');         % ����0
yb0=im2bw(I0);                				   % ת���ɶ�ֵͼ��
I1=imread('.\��������ͼƬ\num1_1.bmp');         % ����1
yb1=im2bw(I1);                				   % ת���ɶ�ֵͼ��
I2=imread('.\��������ͼƬ\num2_1.bmp');         % ����2
yb2=im2bw(I2);                				   % ת���ɶ�ֵͼ��
I3=imread('.\��������ͼƬ\num3_1.bmp');         % ����3
yb3=im2bw(I3);                                 % ת���ɶ�ֵͼ��
I4=imread('.\��������ͼƬ\num4_1.bmp');         % ����4
yb4=im2bw(I4);                			       % ת���ɶ�ֵͼ��
I5=imread('.\��������ͼƬ\num5_1.bmp');         % ����5
yb5=im2bw(I5);               	               % ת���ɶ�ֵͼ��
p0=zeros(49,6);
%ת����ʽ��������ѵ������
T=zeros(49,6);
ta=eye(6);
yb=[yb0,yb1,yb2,yb3,yb4,yb5];     			% ����ѵ������
for k=1:6
    for m=1:7
        for n=1:7
            T(n+7*(m-1),k)=yb(m,n+7*(k-1));   % ͼ�����ݱ���Ϊ1��
        end
    end
end
[R1,Q1]=size(T);
[R2,Q2]=size(ta);
%�������������룬���³����
J=imnoise(T,'gaussian',0.01,0.001);

%����������
S1=10;
S2=R2;
net=newff(minmax(T),[S1,S2],{'logsig' 'logsig'},'traingdx');% ����һ����������
net.LW{2,1}=net.LW{2,1}*0.01;  % Ȩֵ
net.b{2}=net.b{2}*0.01;        % ��ֵ
%����������ѵ��������
net.performFcn='sse';
net.trainParam.goal=0.01;   	% ѵ�����
net.trainParam.epochs=1000; 	% ѵ������
net.trainParam.mc=0.02;     	% Ч��
[net,tr]=train(net,T,ta);

%%
%���ú������ġ�������Ϊ���Զ���
ya3=double(yb3);
t3=imnoise(ya3,'gaussian',0,0.01);
subplot(121),imshow(t3);title('�������Ĳ��Զ��� 3');
%������ģʽ����ʶ��
a3=zeros(49,1);
for m=1:7
    for n=1:7
        a3(n+7*(m-1),1)=yb3(m,n);
    end
end
result=sim(net,a3);
[resultmax,r]=max(result) 	 % ȡ�����Ϊһ��λ����Ϊʶ����
re=eye(7);              	 % ����ʶ����λͼ
for m=1:7
    for n=1:7
        re(m,n)=T(n+7*(m-1),r);
    end
end
subplot(122);
imshow(re);
title('ʶ����');
