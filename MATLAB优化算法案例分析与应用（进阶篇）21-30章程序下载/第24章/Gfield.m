function a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it);
% 万有引力加速度计算
[N,dim]=size(X);
final_per=2; % 只有2%的个体对其他个体有力的作用

 % 合力
 if ElitistCheck==1
     kbest=final_per+(1-iteration/max_it)*(100-final_per); %kbest
     kbest=round(N*kbest/100);
 else
     kbest=N; 
 end
    [Ms ds]=sort(M,'descend');

 for i=1:N
     E(i,:)=zeros(1,dim);
     for ii=1:kbest
         j=ds(ii);
         if j~=i
            R=norm(X(i,:)-X(j,:),Rnorm); %欧式距离
         for k=1:dim 
             E(i,k)=E(i,k)+rand*(M(j))*((X(j,k)-X(i,k))/(R^Rpower+eps));
              %note that Mp(i)/Mi(i)=1
         end
         end
     end
 end

%%acceleration
a=E.*G; %note that Mp(i)/Mi(i)=1


