function ObjVal = ackley(Chrom,switch1);

Dim=size(Chrom,2);
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);


      A = 1/Dim;
      Omega = 2 * pi;
      sum1=A.*sum((Chrom .* Chrom)')';
      %sum1=A.*sum(Chrom .* Chrom);
      sum2=A.*sum((cos(Omega * Chrom))')';
      ObjVal = -20*exp(-0.2*sqrt(sum1))-exp(sum2)+20+exp(1);

  