%{
THIS CODE HAS BEEN PREPARED BY
******ANIRUDH CHHABRA******
AS PARTIAL FULFILMENT FOR THE COURSE 
******SOFT COMPUTING BASED AI (AEEM 7010) ******
AS A STUDENT OF MS AEROSPACE ENGINEERING
AT THE UNIVERSITY OF CINCINNATI

SEPTEMBER 2019

TAKE HOME TEST #1

%}

function mvalue = get_membership_value(x, k, row)

l=row(1);
c=row(2);
r=row(3);

if k == 1
    if x>=l && x<c
        mvalue=1;
    elseif x>=c && x<=r
        mvalue=(r-x)/(r-c);
    else
        mvalue=0;
    end
elseif k == 2
    if x>=l && x<c
        mvalue=(x-l)/(c-l);
    elseif x>=c && x<=r
        mvalue=(r-x)/(r-c);
    else
        mvalue=0;
    end
elseif k == 3
    if x>=l && x<c
        mvalue=(x-l)/(c-l);
    elseif x>=c && x<=r
        mvalue=1;
    else
        mvalue=0;
    end

end

end