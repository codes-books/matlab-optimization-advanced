function [m,s,P,P_cl]=EM_pdf_est(X,y,m_ini,s_ini,P_ini)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [m,s,P,P_cl]=EM_pdf_est(X,y,m_ini,s_ini,P_ini)
% EM estimation of the pdfs of c classes. It is assumed that the pdf of
% each class is a mixture of Gaussians, that the respective covariance
% matrices are diagonal and that the covariance matrix of the i-th 
% distribution has the form sigma_i^2 I.
%
% INPUT ARGUMENTS:
%   X:      lxN matrix whose columns are the data vectors.
%   y:      N-dimensional vector contanining the class labels for each
%           one of the data vectors of X.
%   m_ini:  cl-dimensional object array, whose i-th element is an lxci
%           array. The j-th column of the later corresponds to the initial
%           estimate of the mean of the j-th normal distribution involved
%           in the mixture for the pdf of the i-th class.
%   s_ini:  cl-dimensional object array, whose i-th element is a ci
%           dimensional array whose i-th component is the variance for the
%           i-th class.
%   P_ini:  cl-dimensional object array, whose i-th element is a ci
%           dimensional array containing the initial estimate of the mixing
%           probabilities of the normal distributions for the pdf of the
%           i-th class.
%
% OUTPUT ARGUMENTS:
%   m:      it has the same structure with m_ini and contains the final
%           estimates of the means of the normal distributions.
%   s:      it has the same structure with s_ini and contains the final
%           estimates of the variances of the normal distributions.
%   P:      it has the same structure with P_ini and contains the final
%           estimates of the mixing probabilities of the normal
%           distributions.
%   P_cl:   a cl-dimensional array whose i-th component is the estimated a
%           priori probability of the i-th class. It is estimated as the
%           ratio of the number of vectors of the i-th class to the total
%           number of the data vectors.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
e_min=10^(-5);  %This parameter is used in the termination criterion
%of the EM algorithm

% Separate the vectors of different classes and estimate of the a
% priori class probabilities
cl=max(y);  % Total number of classes
acc_tot=[]; %  Count the number of points per class
for j=1:cl
    temp=[];
    t=0;
    for i=1:N
        if(y(i)==j)
            temp=[temp X(:,i)];
            t=t+1;
        end
    end
    acc_tot=[acc_tot t];
    Xs{j}=temp;
end
P_cl=acc_tot/N;

for j=1:cl
    [m{j},s{j},P{j},iter1,Q_tot,e_tot]=em_alg_function(Xs{j},m_ini{j},s_ini{j},P_ini{j},e_min);
    m{j}=m{j}';
end
