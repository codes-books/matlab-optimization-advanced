function [Matching,Cost] = Hungarian(Perf)
% [MATCHING,COST] = Hungarian_New(WEIGHTS)
% 匈牙利算法
% 给定一个n x n矩阵的边权矩阵，使用匈牙利算法求解最小边权值和问题，类似最小树问题
% 如果矩阵中出现inf，则表示没有边与之相连
% 输出：
%       Matching 为一个 n x n的矩阵，只有0 和 1
%        COST 为对应Matching处为1所在位置的元素和

 % 初始化变量
 Matching = zeros(size(Perf));

  % 移除Inf，加速算法执行效率
  % 针对每一列找inf
    num_y = sum(~isinf(Perf),1);
  % 针对每一行找inf
    num_x = sum(~isinf(Perf),2);
    
  % Find the columns(vertices) and rows(vertices) that are isolated
    x_con = find(num_x~=0);
    y_con = find(num_y~=0);
    
  % 缩减矩阵
    P_size = max(length(x_con),length(y_con));
    P_cond = zeros(P_size);
    P_cond(1:length(x_con),1:length(y_con)) = Perf(x_con,y_con);
    if isempty(P_cond)
      Cost = 0;
      return
    end

      % 计算边权矩阵
      Edge = P_cond;
      Edge(P_cond~=Inf) = 0;
      % 修正权效矩阵
      cnum = min_line_cover(Edge);
    
      % 对未标记的行和已标记的列画纵、横线P
      Pmax = max(max(P_cond(P_cond~=Inf)));
      P_size = length(P_cond)+cnum;
      P_cond = ones(P_size)*Pmax;
      P_cond(1:length(x_con),1:length(y_con)) = Perf(x_con,y_con);
   
%*************************************************
% 主要求解步骤
%*************************************************
  exit_flag = 1;
  stepnum = 1;
  while exit_flag
    switch stepnum
      case 1
        [P_cond,stepnum] = step1(P_cond);
      case 2
        [r_cov,c_cov,M,stepnum] = step2(P_cond);
      case 3
        [c_cov,stepnum] = step3(M,P_size);
      case 4
        [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(P_cond,r_cov,c_cov,M);
      case 5
        [M,r_cov,c_cov,stepnum] = step5(M,Z_r,Z_c,r_cov,c_cov);
      case 6
        [P_cond,stepnum] = step6(P_cond,r_cov,c_cov);
      case 7
        exit_flag = 0;
    end
  end

% 移除所有的虚拟节点
Matching(x_con,y_con) = M(1:length(x_con),1:length(y_con));
Cost = sum(sum(Perf(Matching==1)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   STEP 1:找每行最小元素
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [P_cond,stepnum] = step1(P_cond)

  P_size = length(P_cond);
  
  % Loop throught each row
  for ii = 1:P_size
    rmin = min(P_cond(ii,:));
    P_cond(ii,:) = P_cond(ii,:)-rmin;
  end

  stepnum = 2;
  
%**************************************************************************  
%   STEP 2: 寻找P_cond中的0元素
%**************************************************************************
function [r_cov,c_cov,M,stepnum] = step2(P_cond)

% 定义变量
  P_size = length(P_cond);
  r_cov = zeros(P_size,1);  % 记录 元素为0 所在的行
  c_cov = zeros(P_size,1);  % 记录 元素为0 所在的列
  M = zeros(P_size);        % A mask that shows if a position is starred or primed
  
  for ii = 1:P_size
    for jj = 1:P_size
      if P_cond(ii,jj) == 0 && r_cov(ii) == 0 && c_cov(jj) == 0
        M(ii,jj) = 1;
        r_cov(ii) = 1;
        c_cov(jj) = 1;
      end
    end
  end
  
% 重新初始化操作
  r_cov = zeros(P_size,1);  % A vector that shows if a row is covered
  c_cov = zeros(P_size,1);  % A vector that shows if a column is covered
  stepnum = 3;
  
%**************************************************************************
%   STEP 3: 给定每一类一个0
%**************************************************************************
function [c_cov,stepnum] = step3(M,P_size)

  c_cov = sum(M,1);
  if sum(c_cov) == P_size
    stepnum = 7;
  else
    stepnum = 4;
  end
  
%**************************************************************************
%   STEP 4: 寻找没有被覆盖为0的元素，如果在该行没有0元素，则返回到第5步Step 5.  
%           否则，直到覆盖该元素为0。
%**************************************************************************
function [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(P_cond,r_cov,c_cov,M)

P_size = length(P_cond);

zflag = 1;
while zflag  
    % 寻找第一个未被覆盖的0元素
      row = 0; col = 0; exit_flag = 1;
      ii = 1; jj = 1;
      while exit_flag
          if P_cond(ii,jj) == 0 && r_cov(ii) == 0 && c_cov(jj) == 0
            row = ii;
            col = jj;
            exit_flag = 0;
          end      
          jj = jj + 1;      
          if jj > P_size; jj = 1; ii = ii+1; end      
          if ii > P_size; exit_flag = 0; end      
      end

    % 如果没有被覆盖为0元素时，则转到step 6
      if row == 0
        stepnum = 6;
        zflag = 0;
        Z_r = 0;
        Z_c = 0;
      else
        % Prime the uncovered zero
        M(row,col) = 2;
        % 在该行，有一个起始0元素，覆盖该行，用一个含有0元素的列去修正该列
        % Cover the row and uncover the column containing the zero
          if sum(find(M(row,:)==1)) ~= 0
            r_cov(row) = 1;
            zcol = find(M(row,:)==1);
            c_cov(zcol) = 0;
          else
            stepnum = 5;
            zflag = 0;
            Z_r = row;
            Z_c = col;
          end            
      end
end
  
%**************************************************************************
% STEP 5: Z0 为已寻到的0元素in Step 4.Z1为Z0列的其它0元素，Z2 为主要的0元素，去掉所有
%         0的序列，保留主要的0元素， 返回到 Step 3.
%**************************************************************************
function [M,r_cov,c_cov,stepnum] = step5(M,Z_r,Z_c,r_cov,c_cov)
  zflag = 1;
  ii = 1;
  while zflag 
    % 寻找列所在的起始0元素
    rindex = find(M(:,Z_c(ii))==1);
    if rindex > 0
      % 保存起始0
      ii = ii+1;
      % 保存起始0所在的行
      Z_r(ii,1) = rindex;
      % The column of the starred zero is the same as the column of the 
      % primed zero
      Z_c(ii,1) = Z_c(ii-1);
    else
      zflag = 0;
    end
    
    % Continue if there is a starred zero in the column of the primed zero
    if zflag == 1;
      % Find the column of the primed zero in the last starred zeros row
      cindex = find(M(Z_r(ii),:)==2);
      ii = ii+1;
      Z_r(ii,1) = Z_r(ii-1);
      Z_c(ii,1) = cindex;    
    end    
  end
  
  % UNSTAR all the starred zeros in the path and STAR all primed zeros
  for ii = 1:length(Z_r)
    if M(Z_r(ii),Z_c(ii)) == 1
      M(Z_r(ii),Z_c(ii)) = 0;
    else
      M(Z_r(ii),Z_c(ii)) = 1;
    end
  end
  
  % 清除
  r_cov = r_cov.*0;
  c_cov = c_cov.*0;
  
  % Remove all the primes
  M(M==2) = 0;

stepnum = 3;

% *************************************************************************
% STEP 6: 在每一行叠加一个很小的值，在每一列减去一个很小的这个值
%         返回到step 4
%**************************************************************************
function [P_cond,stepnum] = step6(P_cond,r_cov,c_cov)
a = find(r_cov == 0);
b = find(c_cov == 0);
minval = min(min(P_cond(a,b)));

P_cond(find(r_cov == 1),:) = P_cond(find(r_cov == 1),:) + minval;
P_cond(:,find(c_cov == 0)) = P_cond(:,find(c_cov == 0)) - minval;

stepnum = 4;

function cnum = min_line_cover(Edge)
  % Step 2
    [r_cov,c_cov,M,stepnum] = step2(Edge);
  % Step 3
    [c_cov,stepnum] = step3(M,length(Edge));
  % Step 4
    [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(Edge,r_cov,c_cov,M);
  % Calculate the deficiency
    cnum = length(Edge)-sum(r_cov)-sum(c_cov);
    
    
    