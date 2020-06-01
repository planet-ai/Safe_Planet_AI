function [train,test] = create_new_dataset()
data1 = readtable('C:\Users\who\Desktop\datacollect\data_new.csv');

data1=data1(:,1:26);

data_poi = readtable('C:\Users\who\Desktop\datacollect\poi.csv');
data_groc = readtable('C:\Users\who\Desktop\datacollect\grocery.csv');
data_poi = table2array(data_poi);
data_groc = table2array(data_groc);
data_rev_1 = data1(:,[1,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,23,24,25,26]);
data_rev_1 = table2array(data_rev_1);
data_rev = [data_rev_1(:,1:4), sum([data_rev_1(:,5:9),data_rev_1(:,16:17)],2),  sum(data_rev_1(:,11:13),2), data_rev_1(:,14:15), data_rev_1(:,18:20)];

data_poi_add = [data_poi(:,1), sum(data_poi(:,2:end),2)];
data_groc_add = [data_groc(:,1), sum(data_groc(:,2:end),2)];

for i=1:length(data_rev)
    for j=1:length(data_poi_add)
        if data_rev(i,1) == data_poi_add(j,1)
            data_rev(i,12) = data_poi_add(j,2);
            
        end
    end
end
for i=1:length(data_rev)
    for j=1:length(data_groc_add)
        if data_rev(i,1) == data_poi_add(j,1)
            data_rev(i,13) = data_groc_add(j,2);
            
        end
    end
end

data_rev = data_rev(:,[2,3,4,5,6,7,8,9,10,12,13,11]);



data_random_1=data_rev(randperm(size(data_rev,1)),:);
% data_random_1 = table2array(data_random_1);
A=size(data_random_1);
seq = rand(A(1),A(2)); 

[rows, ~] = size(seq);

lastRow = int32(floor(0.8 * rows));

M = data_random_1(1:lastRow, :);
N = data_random_1(lastRow+1:end, :);
train1=M;
train1 = train1( ~any( isnan( train1 ) | isinf( train1 ), 2 ),: );
test1=N;
test1 = test1( ~any( isnan( test1 ) | isinf( test1 ), 2 ),: );

train2=train1(all(train1,2),:);
test2=test1(all(test1,2),:);

train = [normalize(train2(:,1),'range'),normalize(train2(:,2),'range'),normalize(train2(:,3),'range'),normalize(train2(:,4),'range'),normalize(train2(:,5),'range'),normalize(train2(:,6),'range'),normalize(train2(:,7),'range'),normalize(train2(:,8),'range'),normalize(train2(:,9),'range'),normalize(train2(:,10),'range'), normalize(train2(:,11),'range'), normalize(train2(:,12),'range')];
test = [normalize(test2(:,1),'range'),normalize(test2(:,2),'range'),normalize(test2(:,3),'range'),normalize(test2(:,4),'range'),normalize(test2(:,5),'range'),normalize(test2(:,6),'range'),normalize(test2(:,7),'range'),normalize(test2(:,8),'range'),normalize(test2(:,9),'range'),normalize(test2(:,10),'range'), normalize(test2(:,11),'range'), normalize(test2(:,12),'range')];

% train = train2;
% test = test2;
% train=train2(all(train2,2),:);
% test=test2(all(test2,2),:);
end