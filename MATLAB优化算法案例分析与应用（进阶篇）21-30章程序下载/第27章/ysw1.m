% 人工蜂群算法
% 参数说明：
% Foods [FoodNumber][D]; % 初始化的食物源
% ObjVal[FoodNumber];    % 目标函数
% Fitness[FoodNumber];   % 适应度值，目标函数值的倒数
% trial[FoodNumber];     % 拖尾参数
% prob[FoodNumber];      % 计算的概率值
% solution [D];          % 产生的新解，候选位置 produced by v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) j is a randomly chosen parameter and k is a randomlu chosen solution different from i*/
% ObjValSol;             % 新解下的目标函数值
% FitnessSol;            % 新解的适应度值
% neighbour, param2change; 对应于方程 v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij})*/
% GlobalMin;             % 目标函数值最小值
% GlobalParams[D];       % 每一次运行该算法得到的最优个体值，未知数的解
% GlobalMins[runtime];   % 循环计算该算法的次数，记录下的最小解，验证算法的鲁棒性和稳定性
clc,clear,close all
warning off
feature jit off
tic
% 算法参数
NP=20;           % 蜂群大小
FoodNumber=NP/2; % 蜂群食物源数量，也就是产生 解 的个数
limit=10;       % 经过“limit”次采蜜蜂和观察蜂的循环搜索之后，不能够被改进，那么该位置将被放弃
maxCycle=500;    % 最大迭代循环

%/* Problem specific variables*/
objfun='Sphere';     % 待优化函数
D=10;               % 未知数为100个
ub=ones(1,D)*10;    % 未知量取值下边界
lb=ones(1,D)*(-10); % 未知量取值上边界
runtime=1;           % 算法运行次数，一般设置1即可

GlobalMins=zeros(1,runtime);   % 适应度最小值初始化

for r=1:runtime
  
% 初始化变量值
Range = repmat((ub-lb),[FoodNumber 1]);       % 最大值
Lower = repmat(lb, [FoodNumber 1]);           % 最小值
Foods = rand(FoodNumber,D) .* Range + Lower;  % 初始化个体

ObjVal=feval(objfun,Foods);       % 目标函数值
Fitness=calculateFitness(ObjVal); % 适应度值，取其导数，为最小值

% 设定拖尾矩阵，初始化
trial=zeros(1,FoodNumber);

% 找到最好的食物源
BestInd=find(ObjVal==min(ObjVal));
BestInd=BestInd(end);
GlobalMin=ObjVal(BestInd);     % 函数值最小
GlobalParams=Foods(BestInd,:); % 相应的食物源个体

iter=1;
while ((iter <= maxCycle)),  % 迭代开始

% 采蜜蜂
    for i=1:(FoodNumber)
        % 参数随机可变
        Param2Change=fix(rand*D)+1;
        % 随机选择相连个体
        neighbour=fix(rand*(FoodNumber))+1;
        % 随机选择的个体不等于i
        while(neighbour==i)
            neighbour=fix(rand*(FoodNumber))+1;
        end;
        
       sol=Foods(i,:);  % 个体选择
       %  /*v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
       sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
        
       % 个体取值范围约束
        ind=find(sol<lb); % 最小值约束
        sol(ind)=lb(ind);
        ind=find(sol>ub); % 最大值约束
        sol(ind)=ub(ind);
        
        % 估计新的目标函数值和适应度值
        ObjValSol=feval(objfun,sol);
        FitnessSol=calculateFitness(ObjValSol);
        
       % 更新最优个体值
       if (FitnessSol>Fitness(i)) % 如果新产生的个体值适应度值越大，则表明函数值越小，则个体最优
            Foods(i,:)=sol;
            Fitness(i)=FitnessSol;
            ObjVal(i)=ObjValSol;
            trial(i)=0;
        else
            trial(i)=trial(i)+1; % /*if the solution i can not be improved, increase its trial counter*/
       end;
    end;
    
% 观察蜂
% 计算概率
% 观察蜂根据与蜜源相关的概率值选择蜜源，概率值计算公式
% prob(i)=a*fitness(i)/max(fitness)+b*/
prob=(0.9.*Fitness./max(Fitness))+0.1;  
i=1;
t=0;
while(t<FoodNumber)
    if(rand<prob(i))
        t=t+1;
        % 继续随机选择个体
        Param2Change=fix(rand*D)+1;
        % 随机选择相连个体
        neighbour=fix(rand*(FoodNumber))+1;
        % 随机选择的个体不等于i      
        while(neighbour==i)
            neighbour=fix(rand*(FoodNumber))+1;
        end;
       sol=Foods(i,:);  % 个体选择
       %  /*v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
       sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
        
       % 个体取值范围约束
       ind=find(sol<lb); % 最小值约束
       sol(ind)=lb(ind);
       ind=find(sol>ub); % 最大值约束
       sol(ind)=ub(ind);
        
       % 估计新的目标函数值和适应度值
       ObjValSol=feval(objfun,sol);
       FitnessSol=calculateFitness(ObjValSol);
        
       % 更新最优个体值
       if (FitnessSol>Fitness(i)) % 如果新产生的个体值适应度值越大，则表明函数值越小，则个体最优
            Foods(i,:)=sol;
            Fitness(i)=FitnessSol;
            ObjVal(i)=ObjValSol;
            trial(i)=0;
        else
            trial(i)=trial(i)+1; % /*if the solution i can not be improved, increase its trial counter*/
       end;
    end;
    
    i=i+1;
    if (i==(FoodNumber)+1) 
        i=1;
    end;   
end; 

    % 记录最好的目标函数值
    ind=find(ObjVal==min(ObjVal));
    ind=ind(end);
    if (ObjVal(ind)<GlobalMin)
        GlobalMin=ObjVal(ind);      % 最优目标函数值
        GlobalParams=Foods(ind,:);  % 最优个体
    end;
         
         
% 侦察蜂
% 如果某一次循环拖尾次数大于设定limit，则重新更新个体，重新计算
ind=find(trial==max(trial));
ind=ind(end);
if (trial(ind)>limit)
    Bas(ind)=0;
    sol=(ub-lb).*rand(1,D)+lb;
    ObjValSol=feval(objfun,sol);
    FitnessSol=calculateFitness(ObjValSol);
    Foods(ind,:)=sol;
    Fitness(ind)=FitnessSol;
    ObjVal(ind)=ObjValSol;
end;

fprintf('iter=%d ObjVal=%g\n',iter,GlobalMin);
iter=iter+1;

end % End of ABC

GlobalMins(r)=GlobalMin;
end; % end of runs
disp('最优解为：')
GlobalParams
disp('最优目标函数值为：')
GlobalMin

toc
% save all

