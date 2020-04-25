function [Q_path,dmin,Q_learn] = Rf_Q_learning(sta,des,R,gamma)
% sta:起始节点
% des：目标节点
% Two input: R and gamma
% immediate reward matrix; 
% row and column = states; -Inf = no door between nodes
q=zeros(size(R));      % initialize Q as zero, 全0阵
q1=ones(size(R))*inf;  % initialize previous Q as big number，全inf矩阵
count=0;               % counter
for episode=0:50000
   % random initial state
   y=randperm(size(R,1));   % size(R,1)R的行数，随机的产生从1：size(R,1)的数
   state=y(1);
   
   % select any action from this state
   x=find(R(state,:)>=0);        % find possible action of this state
   if size(x,1)>0,
      x1=RandomPermutation(x);   % randomize the possible action
      x1=x1(1);                  % select an action 
   end
   qMax=max(q,[],2);
   q(state,x1)= R(state,x1)+gamma*qMax(x1);   % get max of all actions 
   state=x1;
   
   % break if convergence: small deviation on q for 1000 consecutive
%S = SUM(X) is the sum of the elements of the vector X. If X is a matrix, S is a row vector with the sum over each column.

   if sum(sum(abs(q1-q)))<0.0001 && sum(sum(q >0))
      if count>1000,
         episode;        % report last episode
         break          % for
      else
         count=count+1; % set counter if deviation of q is small
      end
   else
      q1=q;
      count=0; % reset counter when deviation of q from previous q is large
   end
end 
% normalize q
% For matrices,MAX(X) is a row vector containing the maximum element from each column。
% For vectors, MAX(X) is the largest element in X.
g=max(max(q));
if g>0, 
   q=100*q/g;
end
Q_learn = sum(sum(q))/50;

nq=size(q,1);
for i=1:nq
    for j=1:nq
        if q(i,j)==0
            q(i,j)=inf;
        end
    end
end
[Q_path,dmin] = dijkstra( sta,des, q);

end

function [r_path, r_cost] = dijkstra(pathS, pathE, transmat)
%  The Implemented Dijkstra's algorithm
%   pathS: 所求最短路径的起点
%   pathE :所求最短路径的终点
%   transmat: 图的转移矩阵或者邻接矩阵，应为方阵
if ( size(transmat,1) ~= size(transmat,2) )
  error( 'detect_cycles:Dijkstra_SC', ...
         'transmat has different width and heights' );
end

% 初始化:
%  noOfNode-图中的顶点数
%  parent(i)-节点i的父节点
%  distance(i)-从起点pathS的最短路径的长度
%  queue-图的广度遍历
noOfNode = size(transmat, 1);
 
for i = 1:noOfNode
  parent(i) = 0;
  distance(i) = Inf;
end
queue = [];

% Start from pathS
%
for i=1:noOfNode
  if transmat(pathS, i)~=Inf 
    distance(i) = transmat(pathS, i);
    parent(i)   = pathS;
    queue       = [queue i];
  end
end

% 对图进行广度遍历
while length(queue) ~= 0
  hopS  = queue(1);
  queue = queue(2:end);
  
  for hopE = 1:noOfNode
    if distance(hopE) > distance(hopS) + transmat(hopS,hopE)
      distance(hopE) = distance(hopS) + transmat(hopS,hopE);
      parent(hopE)   = hopS;
      queue          = [queue hopE];
    end
  end
  
end

% 回溯进行最短路径的查找
r_path = [pathE];    
i = parent(pathE);

while i~=pathS && i~=0
  r_path = [i r_path];
  i      = parent(i);
end
 
if i==pathS
  r_path = [i r_path];
else
  r_path = []
end

% 返回最短路径的权和
r_cost = distance(pathE);

end

