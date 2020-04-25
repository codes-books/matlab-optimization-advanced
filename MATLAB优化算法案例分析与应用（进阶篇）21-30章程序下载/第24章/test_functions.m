% ��Ӧ�Ⱥ���
function fit=test_functions(L,F_index,dim)

% ��ͬ����Ӧ�Ⱥ���
if F_index==1
fit=sum(L.^2);
end

if F_index==2 
fit=sum(abs(L))+prod(abs(L));
end

if F_index==3
    fit=0;
    for i=1:dim
    fit=fit+sum(L(1:i))^2;
    end
end

if F_index==4
    fit=max(abs(L));
end

if F_index==5
    fit=sum(100*(L(2:dim)-(L(1:dim-1).^2)).^2+(L(1:dim-1)-1).^2);
end

if F_index==6
    fit=sum(floor((L+.5)).^2);
end

if F_index==7
    fit=sum([1:dim].*(L.^4))+rand;
end

if F_index==8
    fit=sum(-L.*sin(sqrt(abs(L))));
end

if F_index==9
    fit=sum(L.^2-10*cos(2*pi.*L))+10*dim;
end

if F_index==10
    fit=-20*exp(-.2*sqrt(sum(L.^2)/dim))-exp(sum(cos(2*pi.*L))/dim)+20+exp(1);
end

if F_index==11
    fit=sum(L.^2)/4000-prod(cos(L./sqrt([1:dim])))+1;
end

if F_index==12
    fit=(pi/dim)*(10*((sin(pi*(1+(L(1)+1)/4)))^2)+sum((((L(1:dim-1)+1)./4).^2).*...
        (1+10.*((sin(pi.*(1+(L(2:dim)+1)./4)))).^2))+((L(dim)+1)/4)^2)+sum(Ufun(L,10,100,4));
end
if F_index==13
    fit=.1*((sin(3*pi*L(1)))^2+sum((L(1:dim-1)-1).^2.*(1+(sin(3.*pi.*L(2:dim))).^2))+...
        ((L(dim)-1)^2)*(1+(sin(2*pi*L(dim)))^2))+sum(Ufun(L,5,100,4));
end

if F_index==14
aS=[-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;,...
-32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];
    for j=1:25
        bS(j)=sum((L'-aS(:,j)).^6);
    end
    fit=(1/500+sum(1./([1:25]+bS))).^(-1);
end

if F_index==15
    aK=[.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
    bK=[.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
    fit=sum((aK-((L(1).*(bK.^2+L(2).*bK))./(bK.^2+L(3).*bK+L(4)))).^2);
end

if F_index==16
    fit=4*(L(1)^2)-2.1*(L(1)^4)+(L(1)^6)/3+L(1)*L(2)-4*(L(2)^2)+4*(L(2)^4);
end

if F_index==17
    fit=(L(2)-(L(1)^2)*5.1/(4*(pi^2))+5/pi*L(1)-6)^2+10*(1-1/(8*pi))*cos(L(1))+10;
end

if F_index==18
    fit=(1+(L(1)+L(2)+1)^2*(19-14*L(1)+3*(L(1)^2)-14*L(2)+6*L(1)*L(2)+3*L(2)^2))*...
        (30+(2*L(1)-3*L(2))^2*(18-32*L(1)+12*(L(1)^2)+48*L(2)-36*L(1)*L(2)+27*(L(2)^2)));
end

if F_index==19
    aH=[3 10 30;.1 10 35;3 10 30;.1 10 35];cH=[1 1.2 3 3.2];
    pH=[.3689 .117 .2673;.4699 .4387 .747;.1091 .8732 .5547;.03815 .5743 .8828];
    fit=0;
    for i=1:4
    fit=fit-cH(i)*exp(-(sum(aH(i,:).*((L-pH(i,:)).^2))));
    end
end

if F_index==20
    aH=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
cH=[1 1.2 3 3.2];
pH=[.1312 .1696 .5569 .0124 .8283 .5886;.2329 .4135 .8307 .3736 .1004 .9991;...
.2348 .1415 .3522 .2883 .3047 .6650;.4047 .8828 .8732 .5743 .1091 .0381];
    fit=0;
    for i=1:4
    fit=fit-cH(i)*exp(-(sum(aH(i,:).*((L-pH(i,:)).^2))));
    end
end

aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

if F_index==21
    fit=0;
  for i=1:5
    fit=fit-((L-aSH(i,:))*(L-aSH(i,:))'+cSH(i))^(-1);
  end
end

if F_index==22
    fit=0;
  for i=1:7
    fit=fit-((L-aSH(i,:))*(L-aSH(i,:))'+cSH(i))^(-1);
  end
end

if F_index==23
    fit=0;
  for i=1:10
    fit=fit-((L-aSH(i,:))*(L-aSH(i,:))'+cSH(i))^(-1);
  end
end

function y=Ufun(x,a,k,m)
y=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
return