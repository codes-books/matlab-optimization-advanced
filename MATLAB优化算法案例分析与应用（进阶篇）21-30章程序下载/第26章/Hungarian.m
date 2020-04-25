function [Matching,Cost] = Hungarian(Perf)
% [MATCHING,COST] = Hungarian_New(WEIGHTS)
% �������㷨
% ����һ��n x n����ı�Ȩ����ʹ���������㷨�����С��Ȩֵ�����⣬������С������
% ��������г���inf�����ʾû�б���֮����
% �����
%       Matching Ϊһ�� n x n�ľ���ֻ��0 �� 1
%        COST Ϊ��ӦMatching��Ϊ1����λ�õ�Ԫ�غ�

 % ��ʼ������
 Matching = zeros(size(Perf));

  % �Ƴ�Inf�������㷨ִ��Ч��
  % ���ÿһ����inf
    num_y = sum(~isinf(Perf),1);
  % ���ÿһ����inf
    num_x = sum(~isinf(Perf),2);
    
  % Find the columns(vertices) and rows(vertices) that are isolated
    x_con = find(num_x~=0);
    y_con = find(num_y~=0);
    
  % ��������
    P_size = max(length(x_con),length(y_con));
    P_cond = zeros(P_size);
    P_cond(1:length(x_con),1:length(y_con)) = Perf(x_con,y_con);
    if isempty(P_cond)
      Cost = 0;
      return
    end

      % �����Ȩ����
      Edge = P_cond;
      Edge(P_cond~=Inf) = 0;
      % ����ȨЧ����
      cnum = min_line_cover(Edge);
    
      % ��δ��ǵ��к��ѱ�ǵ��л��ݡ�����P
      Pmax = max(max(P_cond(P_cond~=Inf)));
      P_size = length(P_cond)+cnum;
      P_cond = ones(P_size)*Pmax;
      P_cond(1:length(x_con),1:length(y_con)) = Perf(x_con,y_con);
   
%*************************************************
% ��Ҫ��ⲽ��
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

% �Ƴ����е�����ڵ�
Matching(x_con,y_con) = M(1:length(x_con),1:length(y_con));
Cost = sum(sum(Perf(Matching==1)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   STEP 1:��ÿ����СԪ��
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
%   STEP 2: Ѱ��P_cond�е�0Ԫ��
%**************************************************************************
function [r_cov,c_cov,M,stepnum] = step2(P_cond)

% �������
  P_size = length(P_cond);
  r_cov = zeros(P_size,1);  % ��¼ Ԫ��Ϊ0 ���ڵ���
  c_cov = zeros(P_size,1);  % ��¼ Ԫ��Ϊ0 ���ڵ���
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
  
% ���³�ʼ������
  r_cov = zeros(P_size,1);  % A vector that shows if a row is covered
  c_cov = zeros(P_size,1);  % A vector that shows if a column is covered
  stepnum = 3;
  
%**************************************************************************
%   STEP 3: ����ÿһ��һ��0
%**************************************************************************
function [c_cov,stepnum] = step3(M,P_size)

  c_cov = sum(M,1);
  if sum(c_cov) == P_size
    stepnum = 7;
  else
    stepnum = 4;
  end
  
%**************************************************************************
%   STEP 4: Ѱ��û�б�����Ϊ0��Ԫ�أ�����ڸ���û��0Ԫ�أ��򷵻ص���5��Step 5.  
%           ����ֱ�����Ǹ�Ԫ��Ϊ0��
%**************************************************************************
function [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(P_cond,r_cov,c_cov,M)

P_size = length(P_cond);

zflag = 1;
while zflag  
    % Ѱ�ҵ�һ��δ�����ǵ�0Ԫ��
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

    % ���û�б�����Ϊ0Ԫ��ʱ����ת��step 6
      if row == 0
        stepnum = 6;
        zflag = 0;
        Z_r = 0;
        Z_c = 0;
      else
        % Prime the uncovered zero
        M(row,col) = 2;
        % �ڸ��У���һ����ʼ0Ԫ�أ����Ǹ��У���һ������0Ԫ�ص���ȥ��������
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
% STEP 5: Z0 Ϊ��Ѱ����0Ԫ��in Step 4.Z1ΪZ0�е�����0Ԫ�أ�Z2 Ϊ��Ҫ��0Ԫ�أ�ȥ������
%         0�����У�������Ҫ��0Ԫ�أ� ���ص� Step 3.
%**************************************************************************
function [M,r_cov,c_cov,stepnum] = step5(M,Z_r,Z_c,r_cov,c_cov)
  zflag = 1;
  ii = 1;
  while zflag 
    % Ѱ�������ڵ���ʼ0Ԫ��
    rindex = find(M(:,Z_c(ii))==1);
    if rindex > 0
      % ������ʼ0
      ii = ii+1;
      % ������ʼ0���ڵ���
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
  
  % ���
  r_cov = r_cov.*0;
  c_cov = c_cov.*0;
  
  % Remove all the primes
  M(M==2) = 0;

stepnum = 3;

% *************************************************************************
% STEP 6: ��ÿһ�е���һ����С��ֵ����ÿһ�м�ȥһ����С�����ֵ
%         ���ص�step 4
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
    
    
    