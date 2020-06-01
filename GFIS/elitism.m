function [npop] = elitism(population , npop, Er, m)

nume=round(m*Er);

[~ , indx] = sort([ population.chrom(:).fv ] , 'descend');

for k = 1:nume
    npop.chrom(k).gene  = population.chrom(indx(k)).gene;
    npop.chrom(k).fv  = population.chrom(indx(k)).fv;
end

for k = (nume+1):m
    npop.chrom(k).gene  = npop.chrom(k).gene;
    npop.chrom(k).fv  = npop.chrom(k).fv;
end

end