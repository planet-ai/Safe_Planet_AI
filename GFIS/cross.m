function [c1 , c2] = cross(p1, p2, Pc, ub, lb, n)

c1.gene = zeros(1,n);
c2.gene = zeros(1,n);


for k = 1 : n
    beta = rand();
    c1.gene(k) = beta .* p1.gene(k) + (1-beta)* p2.gene(k); 
    c2.gene(k) = (1-beta) .* p1.gene(k) + beta* p2.gene(k);
    
    if c1.gene(k) > ub(k) 
        c1.gene(k)  =  ub(k);
    end
    if c1.gene(k) < lb(k)
        c1.gene(k) = lb(k);
    end
    
    if c2.gene(k) > ub(k) 
        c2.gene(k)  =  ub(k);
    end
    
    if c2.gene(k) < lb(k)
        c2.gene(k) = lb(k);
    end
end

R1 = rand();

if R1 > Pc
    c1 = p1;
end

R2 = rand();

if R2 > Pc
    c2 = p2;
end

end










% num = length(p1.gene);
% ub = num - 1;
% lb = 1;
% 
% cp1= round ((ub-lb)*rand() + lb);
% 
% cp2 = cp1;
% 
% while cp2 == cp1
%     cp2 = round (  (ub - lb) *rand() + lb  );
% end
% 
% if cp1 > cp2
%     temp = cp1;
%     cp1  = cp2;
%     cp2  = temp;
% end
% 
% part1 = p1.gene(1:cp1);
% part2 = p2.gene(cp1 + 1 :cp2);
% part3 = p1.gene(cp2+1:end);
% 
% c1.gene = [part1 , part2 , part3];
% 
% part1 = p2.gene(1:cp1);
% part2 = p1.gene(cp1 + 1 :cp2);
% part3 = p2.gene(cp2+1:end);
% 
% c2.gene = [part1 , part2 , part3];
% 
% rnum = rand();
% 
% if rnum <= Pc
%     c1 = c1;
% else
%     c1 = p1;
% end
% 
% rnum = rand();
% 
% if rnum <= Pc
%     c2 = c2;
% else
%     c2 = p2;
% end
% 
% end