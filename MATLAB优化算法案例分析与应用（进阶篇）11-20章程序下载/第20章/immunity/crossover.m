function newpop=crossover(pop,pc,k)
global N length M;
pc=pc-(M-k)/M*1/20;
A=1:N*length;
% A=randcross(A,N,length); % ������A�Ĵ���������ң���ʵ�����������ԣ�
for i=1:length
    n1=A(i);n2=i+10; % ���ѡ�е�Ҫ���н������������Ⱦɫ��
    for j=1:N                     % N�㣨�Σ�����
           cpoint=length-round(length*pc);        % ������Ⱦɫ�������ѡ��Ľ����λ��
           temp1=pop(n1,(j-1)*length+cpoint+1:j*length);temp2=pop(n2,(j-1)*length+cpoint+1:j*length);
           pop(n1,(j-1)*length+cpoint+1:j*length)=temp2;pop(n2,(j-1)*length+cpoint+1:j*length)=temp1;
    end      
    newpop=pop;
end
   