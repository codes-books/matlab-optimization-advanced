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
