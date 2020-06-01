function [z] = script(f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,chrom)% a

a = fis1(f1,f2,chrom);

b = fis2(f3,f4,chrom);

c = fis3(f5,f6,chrom);

d = fis4(f7,f8,chrom);

e = fis5(f9,f10,chrom);

p = fis6(a,b,chrom);

q = fis7(c,d,chrom);

r = fis8(e,f11,chrom);

one = fis9(p,q,chrom);

[z] = fis10(one,r,chrom);
end