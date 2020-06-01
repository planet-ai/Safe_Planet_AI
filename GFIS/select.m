% function [p1, p2] = select(population, m)
% % Rank Based Roulette Wheel Selection
% normalized_fv = [population.chrom(:).fv] ./ sum([population.chrom(:).fv]);
% 
% [~ , rank] = sort(normalized_fv);
% sumrank=sum(rank);
% 
% % for i=1:m
% %     newfv(i)=rank(i)/sumrank;
% % end
% 
% for i = 1 : m
%     temppop.chrom(i).gene = population.chrom(rank(i)).gene;
%     temppop.chrom(i).fv = rank(i)/sumrank;%newfv(i);
% end
% 
% c=zeros(1 , m);
% % normalized_fv(rank(i))*
% 
% 
% for i = 1 : m
%     for j = i : m
%         c(i) = c(i) + temppop.chrom(j).fv;
%     end
% end
% 
% R = rand(); % in [0,1]
% p1_idx = m;
% for i = 1: m
%     if R > c(i)
%         p1_idx = i ;
%         break;
%     end
% end
% 
% p2_idx = p1_idx;
% flag = 0; % to break the while loop in rare cases where we keep getting the same index
% while p2_idx == p1_idx
%     flag = flag + 1;
%     R = rand(); % in [0,1]
%     if flag > 20
%         break;
%     end
%     for i = 1: length(c)
%         if R > c(i)
%             p2_idx = i;
%             break;
%         end
%     end
% end
% 
% p1 = temppop.chrom(p1_idx);
% p2 = temppop.chrom(p2_idx);
% end


function [p1, p2] = select(population, m)

if any([population.chrom(:).fv] < 0 )
    a=1;
    b=abs(min([population.chrom(:).fv]));
    scaled_fv = a *  [population.chrom(:).fv] + b;
    
    normalized_fv = [scaled_fv] ./ sum([scaled_fv]);
else
    normalized_fv = [population.chrom(:).fv] ./ sum([population.chrom(:).fv]);
end

[~ , sorted_index] = sort(normalized_fv , 'descend');

for i = 1 : m
    temppop.chrom(i).gene = population.chrom(sorted_index(i)).gene;
    temppop.chrom(i).fv = population.chrom(sorted_index(i)).fv;
    temppop.chrom(i).normalized_fv = normalized_fv(sorted_index(i));
end

c=zeros(1 , m);

for i = 1 : m
    for j = i : m
        c(i) = c(i) + temppop.chrom(j).normalized_fv;
    end
end

R = rand(); % in [0,1]
p1_idx = m;
for i = 1: length(c)
    if R > c(i)
        p1_idx = i - 1;
        break;
    end
end

p2_idx = p1_idx;
flag = 0; % to break the while loop in rare cases where we keep getting the same index
while p2_idx == p1_idx
    flag = flag + 1;
    R = rand(); % in [0,1]
    if flag > 20
        break;
    end
    for i = 1: length(c)
        if R > c(i)
            p2_idx = i - 1;
            break;
        end
    end
end

p1 = temppop.chrom(p1_idx);
p2 = temppop.chrom(p2_idx);

end