function [fv] = getfitness(chrom, train)

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

for i=1:size(train)
    fi=classi(i);
    %     [f1, f2] = script(f1(i),f2(i),f3(i),f4(i),f5(i),f6(i),f7(i),f8(i),f9(i),f10(i),f11(i), chrom);
    output1 = script(f1(i),f2(i),f3(i),f4(i),f5(i),f6(i),f7(i),f8(i),f9(i),f10(i),f11(i), chrom);
    %     error(i) = sqrt((f1-fi)*(f1-fi) + (f2-fd)*(f2-fd));
    error(i) = abs(output1-fi);
end

value_to_minimize = mean(error);

fv=1/value_to_minimize;

%%
% TRY THIS | COMPARE RESULTS
% fv=-1*value_to_minimize;
end