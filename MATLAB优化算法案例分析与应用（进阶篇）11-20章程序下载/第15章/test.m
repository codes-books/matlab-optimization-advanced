function flag=test(code)
% code       output: Ⱦɫ��ı���ֵ
global Tmin Tmax delta
x=code; %�Ƚ���
flag=1;
for i=3:length(x)
    if x(i)-x(i-1)>Tmin&&x(i)-x(i-1)<Tmax && abs(x(i)-x(i-1)-(x(i-1)-x(i-2)))<delta
        ;
    else
        flag=0;
    end
end     