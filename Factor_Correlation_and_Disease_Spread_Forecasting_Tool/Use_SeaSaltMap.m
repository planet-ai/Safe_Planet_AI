
function SeaSaltMap = Use_SeaSaltMap


    Three_Colors=[85,72,193;
                  221, 221, 221;
                  177,1,39];

    Three_Colors=Three_Colors/255;


    for i=1:128
        SeaSaltMap(i,1)= Three_Colors(1,1) *(1- (i-1)/127) + Three_Colors(2,1) *(i-1)/127;
        SeaSaltMap(i,2)= Three_Colors(1,2) *(1- (i-1)/127) + Three_Colors(2,2) *(i-1)/127;
        SeaSaltMap(i,3)= Three_Colors(1,3) *(1- (i-1)/127) + Three_Colors(2,3) *(i-1)/127;
    end
  
    for i=129:255
        SeaSaltMap(i,1)= Three_Colors(2,1) *(1- (i-129)/127) + Three_Colors(3,1) *(i-129)/127;
        SeaSaltMap(i,2)= Three_Colors(2,2) *(1- (i-129)/127) + Three_Colors(3,2) *(i-129)/127;
        SeaSaltMap(i,3)= Three_Colors(2,3) *(1- (i-129)/127) + Three_Colors(3,3) *(i-129)/127;                      
    end
    
    
end