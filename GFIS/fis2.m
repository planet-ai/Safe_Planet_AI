function [output] = fis2(x,y,chrom)

%membership of x
mu_x(1,:)=chrom(19:21);
mu_x(2,:)=chrom(22:24);
mu_x(3,:)=chrom(25:27);
% mu_x(4,:)=chrom(10:12);
% mu_x(5,:)=chrom(13:15);

%membership of y
mu_y(1,:)=chrom(28:30);
mu_y(2,:)=chrom(31:33);
mu_y(3,:)=chrom(34:36);
% mu_y(4,:)=chrom(25:27);
% mu_y(5,:)=chrom(28:30);

%membership of output
mu_output(1,:)=chrom(100:102);
mu_output(2,:)=chrom(103:105);
mu_output(3,:)=chrom(106:108);






for i=1:3
    row=mu_x(i,:);
    mv_x(i)=get_membership_value(x,2,row);
end

for i=1:3
    row=mu_y(i,:);
    mv_y(i)=get_membership_value(y,2,row);
end

%rule base

for i=1:3
    for j=1:3
        xf(i,j) = max(mv_x(i),mv_y(j));        
    end
end
xr=xf(:)';
mv_output=zeros(1,3);



rule = round(chrom(199:207));


for i=1:9  
    switch rule(i)
        case 1
            mv_output(1) = mv_output(1) + xr(i);
        case 2
            mv_output(2) = mv_output(2) + xr(i);
        case 3
            mv_output(3) = mv_output(3) + xr(i);
%         case 4
%             mv_output(4) = mv_output(4) + xr(i);
%         case 5
%             mv_output(5) = mv_output(5) + xr(i);
        otherwise
    end
end

%defuz
num=0;
a=[];
for i=1:3
    a(i) = 0.5*mv_output(i)*(mu_output(i,3)-mu_output(i,1));
    num=num + a(i)*((mu_output(i,1)+mu_output(i,2)+mu_output(i,3))/3);
end
den=sum(a);
if den == 0
    den=0.0001;
end

output=num/den;

end