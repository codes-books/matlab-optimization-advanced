function   fitness=evaluateF(X,F_index);
% 计算适应度值
[N,dim]=size(X);
for i=1:N 
    % L 第 'i' 个种群，包含一组未知量解的个体
    L=X(i,:); 
    % 第 'i' 个种群的适应度计算计算
    fitness(i)=test_functions(L,F_index,dim);
end