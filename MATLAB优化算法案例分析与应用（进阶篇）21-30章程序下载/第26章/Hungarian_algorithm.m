% �������㷨
clc,clear,close all
warning off
feature jit off
n=4;
A=[4 5 5 1
2 2 4 6
4 2 3 3
5 0 2 1];
for(i=1:n)
    L(i,1)=0;
    L(i,2)=0;
end
for(i=1:n)
    for(j=1:n)
        if(L(i,1)<A(i,j))
            L(i,1)=A(i,j);
        end;    % ���n�s�_??L
        M(i,j)=0;
    end;
end
for(i=1:n)
    for(j=1:n)    % �����q?Gl
        if(L(i,1)+L(j,2)==A(i,j))
            Gl(i,j)=1;
        else
            Gl(i,j)=0;
        end;
    end;
end

ii=0;jj=0;
for(i=1:n)
    for(j=1:n)
        if(Gl(i,j))
            ii=i;
            jj=j;
            break;
        end;
    end
    if(ii)
        break;
    end;
end      % ?��?��Gl �I���?�I���n�C�zM

M(ii,jj)=1;
for(i=1:n)
    S(i)=0;
    T(i)=0;
    NlS(i)=0;
end

while(1)
    
for(i=1:n)
    k=1;
    % ��?.
    for(j=1:n)
        if(M(i,j))
            k=0;
            break;
        end;
    end

    if(k)
        break;
    end;
end

if(k==0)
    break;
end   % ?���ŉ��C�zM, �Z�@?�~

S(1)=i;jss=1;jst=0; %S={xi}, T=?

while(1)
jsn=0;
for(i=1:jss)
    for(j=1:n)
        if(Gl(S(i),j))
            jsn=jsn+1;
            NlS(jsn)=j; % NL(S)={v|u��S,uv��EL}
            for(k=1:jsn-1)
                if(NlS(k)==j)
                    jsn=jsn-1;
                end;
            end;
        end;
    end;
end

if(jsn==jst)
    pd=1;    % ���fNL(S)=T?
    for(j=1:jsn)
        if(NlS(j)~=T(j))
            pd=0;
            break;
        end;
    end;
end

if(jsn==jst&pd)
    al=Inf;   % �@��NL(S)=T, ?�Zal, Inf ?��
    for(i=1:jss)
        for(j=1:n)
            pd=1;
            for(k=1:jst)
                if(T(k)==j)
                    pd=0;
                    break;
                end;
            end
            if(pd&al>L(S(i),1)+L(j,2)-A(S(i),j))
                al=L(S(i),1)+L(j,2)-A(S(i),j);
            end;
        end;
    end
    for(i=1:jss)
        L(S(i),1)=L(S(i),1)-al;
    end     % ?���s�_??
    for(j=1:jst)
        L(T(j),2)=L(T(j),2)+al;
    end     % ?���s�_??
    for(i=1:n)
        for(j=1:n) %�����q?GL
            if(L(i,1)+L(j,2)==A(i,j))
                Gl(i,j)=1;
                else Gl(i,j)=0;
            end
            M(i,j)=0;
            k=0;
        end;
    end
    ii=0;
    jj=0;
    
    for(i=1:n)
        for(j=1:n)
            if(Gl(i,j))
                ii=i;
                jj=j;
                break;
            end;
        end
        if(ii)
            break;
        end;
    end %?��?��Gl �I���?�I���n�C�zM
    
    M(ii,jj)=1;
    break
    else %NL(S)��T
        for(j=1:jsn)
            pd=1; %��y��NL(S)\T
            for(k=1:jst)
                if(T(k)==NlS(j))
                    pd=0;
                    break;
                end;
            end
            if(pd)jj=j;
                break;
            end;
        end
        pd=0; %���fy ����?M�I?�a�_
        
        for(i=1:n)
            if(M(i,NlS(jj)))
                pd=1;
                ii=i;
                break;
            end;
        end
        if(pd)
            jss=jss+1;
            S(jss)=ii;
            jst=jst+1;
            T(jst)=NlS(jj); %S=S��{x}, T=T��{y}
            else %?��Gl �I���M-�����H, ?���C�zM
                for(k=1:jst)
                    M(S(k),T(k))=1;
                    M(S(k+1),T(k))=0;
                end
                if(jst==0)
                    k=0;
                end
                M(S(k+1),NlS(jj))=1;
                break;
        end;
end;
end;
end

MaxZjpp=0;

for(i=1:n)
    for(j=1:n)
        if(M(i,j))
            MaxZjpp=MaxZjpp+A(i,j);
        end;
    end;
end
M %?���ŉ��C�zM
MaxZjpp %?���ŉ��C�zM�I?, ����?��

