% 万有引力搜索算法
function [Fbest,Lbest,BestChart,MeanChart]=GSA(F_index,N,max_it,ElitistCheck,min_flag,Rpower)
%V:   速度
%a:   加速度
%M:   质量.  Ma=Mp=Mi=M;
%dim: 待求解未知量维数
%N:   智能粒子个数
%X:   种群个体位置. dim-by-N matrix.
%R:   种群之间的距离
%[low-up]: 取值范围
%Rnorm:  范数
%Rpower: Power of R 
Rnorm=2;  % 2阶范数，即欧氏距离
% 获取待求解目标方程的未知数个体以及取值范围
[low,up,dim]=test_functions_range(F_index); 
% 随机的初始化个体
X=initialization(dim,N,up,low); 
% 适应度值数组初始化
BestChart=[];
MeanChart=[];
V=zeros(N,dim); % 速度初始化
for iteration=1:max_it  % 迭代开始
%     iteration
    
    % 检查x个体是否在取值范围内
    X=space_bound(X,up,low); 
    % 计算适应度值
    fitness=evaluateF(X,F_index); 
    
    if min_flag==1
        [best best_X]=min(fitness); %minimization.
    else
        [best best_X]=max(fitness); %maximization.
    end        
    
    if iteration==1
       Fbest=best;Lbest=X(best_X,:);
    end
    if min_flag==1
      if best<Fbest  % 极小值求解
       Fbest=best;Lbest=X(best_X,:);
      end
    else 
      if best>Fbest  % 极大值求解
       Fbest=best;Lbest=X(best_X,:);
      end
    end
      
BestChart=[BestChart Fbest];          % 最优适应度值
MeanChart=[MeanChart mean(fitness)];  % 平均适应度值

% M计算
[M]=massCalculation(fitness,min_flag); 
%万有引力常数计算
G=Gconstant(iteration,max_it); 
%加速度a计算
a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it);

% 个体更新
[X,V]=move(X,a,V);

end % 迭代终止

