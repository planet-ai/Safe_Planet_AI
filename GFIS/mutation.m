function [c] = mutation(c, Pm, ub, lb, n)

for i = 1: n
    num = rand();
    if num < Pm
        c.gene(i) = (ub(i)-lb(i))*rand() + lb(i);
    end
end

end