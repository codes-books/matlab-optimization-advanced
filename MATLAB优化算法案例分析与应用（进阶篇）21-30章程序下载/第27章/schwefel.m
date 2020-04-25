function ObjVal = schwefel(Chrom,switch1);

% Dimension of objective function
  
    Dim=size(Chrom,2);
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);


      % function 7, sum of -xi*sin(sqrt(abs(xi))) for i = 1:Dim (Dim=10)
      % n = Dim, -500 <= xi <= 500
      % global minimum at (xi)=(420.9687) ; fmin=?
      ObjVal = sum((-Chrom .* sin(sqrt(abs(Chrom))))')';
   % otherwise error, wrong format of Chrom
