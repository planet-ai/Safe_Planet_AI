function [ population ] = init(m, n, ub, lb)

for i = 1 : m
    for j = 1 : n 
        population.chrom(i).gene(j) = (ub(j) - lb(j)) * rand() + lb(j);
    end
end
