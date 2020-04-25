clc,clear,close all
warning off
% 1. To generate X, utilize the function mixt_model
randn('seed',0); 
m1=[1, 2]'; m2=[2, 3]';
m=[m1 m2];
S(:,:,1)=[0.5 -0.05; -0.05 0.1];
S(:,:,2)=[0.2 0; 0 0.2];
P=[1/2 1/2];
N=1000;
sed=0; 
[X,y]=mixt_model(m,S,P,N,sed);
figure(1);
plot(X(1,:),X(2,:),'.');

%% 2. Repeat step 1 for P1 = 0.85, P2 = 0.15.
clc,clear,close all
warning off
randn('seed',0); 
m1=[1, 2]'; m2=[2, 3]';
m=[m1 m2];
S(:,:,1)=[0.5 -0.05; -0.05 0.1];
S(:,:,2)=[0.2 0; 0 0.2];
P=[0.75 0.25];
N=1000;
sed=0; 
[X,y]=mixt_model(m,S,P,N,sed);
figure(2);
plot(X(1,:),X(2,:),'.');

%% 3. Play by changing the parameters of the covariance matrices and the mixing probabilities P1 and P2.
clc,clear,close all
warning off
randn('seed',0); 
m1=[1, 2]'; m2=[2, 3]';
m=[m1 m2];
S(:,:,1)=[0.5 0.05; 0.05 0.1];
S(:,:,2)=[0.2 0; 0 0.2];
P=[0.5 0.5];
N=1000;
sed=0; 
[X,y]=mixt_model(m,S,P,N,sed);
figure(3);
plot(X(1,:),X(2,:),'.');

randn('seed',0); 
m1=[1, 2]'; m2=[2, 3]';
m=[m1 m2];
S(:,:,1)=[0.5 0.05; 0.05 0.1];
S(:,:,2)=[0.2 0; 0 0.2];
P=[0.25 0.75];
N=1000;
sed=0; 
[X,y]=mixt_model(m,S,P,N,sed);
figure(4);
plot(X(1,:),X(2,:),'.');
