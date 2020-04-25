function flag=test(code)
% code       output: 染色体的编码值
global Tmin Tmax delta
x=code; %先解码
flag=1;
for i=3:length(x)
    if x(i)-x(i-1)>Tmin&&x(i)-x(i-1)<Tmax && abs(x(i)-x(i-1)-(x(i-1)-x(i-2)))<delta
        ;
    else
        flag=0;
    end
end     