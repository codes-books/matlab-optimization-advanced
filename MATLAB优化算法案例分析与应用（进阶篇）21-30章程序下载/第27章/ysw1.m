% �˹���Ⱥ�㷨
% ����˵����
% Foods [FoodNumber][D]; % ��ʼ����ʳ��Դ
% ObjVal[FoodNumber];    % Ŀ�꺯��
% Fitness[FoodNumber];   % ��Ӧ��ֵ��Ŀ�꺯��ֵ�ĵ���
% trial[FoodNumber];     % ��β����
% prob[FoodNumber];      % ����ĸ���ֵ
% solution [D];          % �������½⣬��ѡλ�� produced by v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) j is a randomly chosen parameter and k is a randomlu chosen solution different from i*/
% ObjValSol;             % �½��µ�Ŀ�꺯��ֵ
% FitnessSol;            % �½����Ӧ��ֵ
% neighbour, param2change; ��Ӧ�ڷ��� v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij})*/
% GlobalMin;             % Ŀ�꺯��ֵ��Сֵ
% GlobalParams[D];       % ÿһ�����и��㷨�õ������Ÿ���ֵ��δ֪���Ľ�
% GlobalMins[runtime];   % ѭ��������㷨�Ĵ�������¼�µ���С�⣬��֤�㷨��³���Ժ��ȶ���
clc,clear,close all
warning off
feature jit off
tic
% �㷨����
NP=20;           % ��Ⱥ��С
FoodNumber=NP/2; % ��Ⱥʳ��Դ������Ҳ���ǲ��� �� �ĸ���
limit=10;       % ������limit���β��۷�͹۲���ѭ������֮�󣬲��ܹ����Ľ�����ô��λ�ý�������
maxCycle=500;    % ������ѭ��

%/* Problem specific variables*/
objfun='Sphere';     % ���Ż�����
D=10;               % δ֪��Ϊ100��
ub=ones(1,D)*10;    % δ֪��ȡֵ�±߽�
lb=ones(1,D)*(-10); % δ֪��ȡֵ�ϱ߽�
runtime=1;           % �㷨���д�����һ������1����

GlobalMins=zeros(1,runtime);   % ��Ӧ����Сֵ��ʼ��

for r=1:runtime
  
% ��ʼ������ֵ
Range = repmat((ub-lb),[FoodNumber 1]);       % ���ֵ
Lower = repmat(lb, [FoodNumber 1]);           % ��Сֵ
Foods = rand(FoodNumber,D) .* Range + Lower;  % ��ʼ������

ObjVal=feval(objfun,Foods);       % Ŀ�꺯��ֵ
Fitness=calculateFitness(ObjVal); % ��Ӧ��ֵ��ȡ�䵼����Ϊ��Сֵ

% �趨��β���󣬳�ʼ��
trial=zeros(1,FoodNumber);

% �ҵ���õ�ʳ��Դ
BestInd=find(ObjVal==min(ObjVal));
BestInd=BestInd(end);
GlobalMin=ObjVal(BestInd);     % ����ֵ��С
GlobalParams=Foods(BestInd,:); % ��Ӧ��ʳ��Դ����

iter=1;
while ((iter <= maxCycle)),  % ������ʼ

% ���۷�
    for i=1:(FoodNumber)
        % ��������ɱ�
        Param2Change=fix(rand*D)+1;
        % ���ѡ����������
        neighbour=fix(rand*(FoodNumber))+1;
        % ���ѡ��ĸ��岻����i
        while(neighbour==i)
            neighbour=fix(rand*(FoodNumber))+1;
        end;
        
       sol=Foods(i,:);  % ����ѡ��
       %  /*v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
       sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
        
       % ����ȡֵ��ΧԼ��
        ind=find(sol<lb); % ��СֵԼ��
        sol(ind)=lb(ind);
        ind=find(sol>ub); % ���ֵԼ��
        sol(ind)=ub(ind);
        
        % �����µ�Ŀ�꺯��ֵ����Ӧ��ֵ
        ObjValSol=feval(objfun,sol);
        FitnessSol=calculateFitness(ObjValSol);
        
       % �������Ÿ���ֵ
       if (FitnessSol>Fitness(i)) % ����²����ĸ���ֵ��Ӧ��ֵԽ�����������ֵԽС�����������
            Foods(i,:)=sol;
            Fitness(i)=FitnessSol;
            ObjVal(i)=ObjValSol;
            trial(i)=0;
        else
            trial(i)=trial(i)+1; % /*if the solution i can not be improved, increase its trial counter*/
       end;
    end;
    
% �۲��
% �������
% �۲���������Դ��صĸ���ֵѡ����Դ������ֵ���㹫ʽ
% prob(i)=a*fitness(i)/max(fitness)+b*/
prob=(0.9.*Fitness./max(Fitness))+0.1;  
i=1;
t=0;
while(t<FoodNumber)
    if(rand<prob(i))
        t=t+1;
        % �������ѡ�����
        Param2Change=fix(rand*D)+1;
        % ���ѡ����������
        neighbour=fix(rand*(FoodNumber))+1;
        % ���ѡ��ĸ��岻����i      
        while(neighbour==i)
            neighbour=fix(rand*(FoodNumber))+1;
        end;
       sol=Foods(i,:);  % ����ѡ��
       %  /*v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
       sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
        
       % ����ȡֵ��ΧԼ��
       ind=find(sol<lb); % ��СֵԼ��
       sol(ind)=lb(ind);
       ind=find(sol>ub); % ���ֵԼ��
       sol(ind)=ub(ind);
        
       % �����µ�Ŀ�꺯��ֵ����Ӧ��ֵ
       ObjValSol=feval(objfun,sol);
       FitnessSol=calculateFitness(ObjValSol);
        
       % �������Ÿ���ֵ
       if (FitnessSol>Fitness(i)) % ����²����ĸ���ֵ��Ӧ��ֵԽ�����������ֵԽС�����������
            Foods(i,:)=sol;
            Fitness(i)=FitnessSol;
            ObjVal(i)=ObjValSol;
            trial(i)=0;
        else
            trial(i)=trial(i)+1; % /*if the solution i can not be improved, increase its trial counter*/
       end;
    end;
    
    i=i+1;
    if (i==(FoodNumber)+1) 
        i=1;
    end;   
end; 

    % ��¼��õ�Ŀ�꺯��ֵ
    ind=find(ObjVal==min(ObjVal));
    ind=ind(end);
    if (ObjVal(ind)<GlobalMin)
        GlobalMin=ObjVal(ind);      % ����Ŀ�꺯��ֵ
        GlobalParams=Foods(ind,:);  % ���Ÿ���
    end;
         
         
% ����
% ���ĳһ��ѭ����β���������趨limit�������¸��¸��壬���¼���
ind=find(trial==max(trial));
ind=ind(end);
if (trial(ind)>limit)
    Bas(ind)=0;
    sol=(ub-lb).*rand(1,D)+lb;
    ObjValSol=feval(objfun,sol);
    FitnessSol=calculateFitness(ObjValSol);
    Foods(ind,:)=sol;
    Fitness(ind)=FitnessSol;
    ObjVal(ind)=ObjValSol;
end;

fprintf('iter=%d ObjVal=%g\n',iter,GlobalMin);
iter=iter+1;

end % End of ABC

GlobalMins(r)=GlobalMin;
end; % end of runs
disp('���Ž�Ϊ��')
GlobalParams
disp('����Ŀ�꺯��ֵΪ��')
GlobalMin

toc
% save all

