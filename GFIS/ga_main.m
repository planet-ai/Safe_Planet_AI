%{
THIS CODE HAS BEEN PREPARED BY
******ANIRUDH CHHABRA******
NASA SPACE APPS CHALLENGE COVID-19 (2020)
%}
clear;
clc;
close all;
%% Initial setup
[train, test]   =   create_new_dataset();

f1         =   train(:,1);
f2         =   train(:,2);
f3         =   train(:,3);
f4         =   train(:,4);
f5         =   train(:,5);
f6         =   train(:,6);
f7         =   train(:,7);
f8         =   train(:,8);
f9         =   train(:,9);
f10        =   train(:,10);
f11        =   train(:,11);
classi     =   train(:,12);

%parameters for GA
m=5; %candidate solutions or chromosomes


 %upper bounds for all variables
ub=[ ones(1, 9)*(max(f1)+0.1), ones(1, 9)*(max(f2)+0.1), ones(1, 9)*(max(f3)+0.1),...
    ones(1, 9)*(max(f4)+0.1), ones(1, 9)*(max(f5)+0.1), ones(1, 9)*(max(f6)+0.1), ones(1, 9)*(max(f7)+0.1), ones(1, 9)*(max(f8)+0.1),...
    ones(1, 9)*(max(f9)+0.1), ones(1, 9)*(max(f10)+0.1),...
    ones(1, 9), ones(1, 9), ones(1, 9), ones(1, 9), ones(1, 9),...
    ones(1, 9)*(max(f11)+0.1),...
    ones(1, 9), ones(1, 9), ones(1, 9), ones(1, 9),...
    ones(1, 9)*(max(classi)+0.1),...
    ones(1,9)*3.5, ones(1,9)*3.5, ones(1,9)*3.5,...
    ones(1,9)*3.5, ones(1,9)*3.5, ones(1,9)*3.5,...
    ones(1,9)*3.5, ones(1,9)*3.5, ones(1,9)*3.5,...
    ones(1,9)*3.5];

 %lower bounds for all variables
lb=[ ones(1, 9)*(min(f1)-0.1), ones(1, 9)*(min(f2)-0.1), ones(1, 9)*(min(f3)-0.1),...
    ones(1, 9)*(min(f4)-0.1), ones(1, 9)*(min(f5)-0.1), ones(1, 9)*(min(f6)-0.1), ones(1, 9)*(min(f7)-0.1), ones(1, 9)*(min(f8)-0.1),...
    ones(1, 9)*(min(f9)-0.1), ones(1, 9)*(min(f10)-0.1),...
    zeros(1, 9), zeros(1, 9), zeros(1, 9), zeros(1, 9), zeros(1, 9),...
    ones(1, 9)*(min(f11)-0.1),...
    zeros(1, 9), zeros(1, 9), zeros(1, 9),zeros(1, 9),...
    ones(1, 9)*(min(classi)-0.1),...
    ones(1,9)*-0.5, ones(1,9)*-0.5, ones(1,9)*-0.5,...
    ones(1,9)*-0.5, ones(1,9)*-0.5, ones(1,9)*-0.5,...
    ones(1,9)*-0.5, ones(1,9)*-0.5, ones(1,9)*-0.5,...
    ones(1,9)*-0.5];
 
 
if length(ub) == length(lb)
    n=length(ub) %number of variables or genes
else
    disp('upper bound vector length not equal to lower bound vector length')
    return;
end

gen= 2000; %number of generations
Pc= 0.75; %Probability of Crossover
Pm= 0.25; %Probability of Mutation
Er= 0.2; %Elitism Ratio

%% Training the FIS using a Genetic Algorithm
%GA Start
[population] = init(m, n, ub, lb); %initialize a random population
ctr=1;

for k=1:m %get fitness values
    population.chrom(k).fv = getfitness(population.chrom(k).gene(:), train);
end
testerror(1)=1/max([ population.chrom(:).fv ]);
disp(['generation #' , num2str(ctr)]);
% figure;
for ctr=2:gen
    tic
    for k = 1 : m
        population.chrom(k).fv = getfitness(population.chrom(k).gene(:), train);
    end
    for k = 1: 2: m
        [p1, p2] = select(population, m);% Selection
        [c1 , c2] = cross(p1, p2, Pc, ub, lb, n);% Crossover
        [c1] = mutation(c1, Pm, ub, lb, n);% Mutation
        [c2] = mutation(c2, Pm, ub, lb, n);
        npop.chrom(k).gene = c1.gene;
        npop.chrom(k+1).gene = c2.gene;
    end
    [npop] = elitism(population, npop, Er, m);% Elitism
    population = npop; %update population
    disp(['generation #' , num2str(ctr)]);
    testerror(ctr)=1/max([ population.chrom(:).fv ]);
%     hold on;
%     plot(ctr,testerror(ctr),'.');
%     drawnow;
toc
end %GA End
figure;
grid on
plot(testerror);
for k = 1 : m
    population.chrom(k).fv = getfitness(population.chrom(k).gene(:), train);
end
[~,index] = sort([ population.chrom(:).fv ] , 'descend'); %rearrange in descending order
%% final solution
solution.gene  = population.chrom(index(1)).gene; 
solution.fv    = population.chrom(index(1)).fv;
sol=solution.gene;
save('solution55.mat', 'sol');
%% Validation (using the final solution obtained from GA)
ff1         =   test(:,1);
ff2         =   test(:,2);
ff3         =   test(:,3);
ff4         =   test(:,4);
ff5         =   test(:,5);
ff6         =   test(:,6);
ff7         =   test(:,7);
ff8         =   test(:,8);
ff9         =   test(:,9);
ff10        =   test(:,10);
ff11        =   test(:,11);
cclassi     =   test(:,12);

% hold on;
%%
for i=1:size(test)
    f(i) = script(ff1(i),ff2(i),ff3(i),ff4(i),ff5(i),ff6(i),ff7(i),ff8(i),ff9(i),ff10(i),ff11(i), solution.gene);
    error(i) = abs(f(i)-cclassi(i));
    var(i)=(error(i));
    var2(i)=f(i)/cclassi(i);
%     plot(i,var, 'go', 'MarkerSize',3);

end
figure;
grid on
plot(var);

figure;
scatter(f,cclassi);


figure;
grid on
plot(var2);


% accuracy = 100*(1-abs(mean(error)));
% disp(['Percentage Accuracy = ',num2str(accuracy),'%']);
% visualization();
