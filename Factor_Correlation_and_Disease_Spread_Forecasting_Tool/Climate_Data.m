
function Climate_Matrix=Climate_Data

%   Close and clear:
    clc; close all;
    
%   Parameters:
    pathFolder = 'C:\Users\USUARIO\Desktop\Second Tool\Climate Data';
    Counties={'NY_Bronx'};   % OH_Hamilton
    Pollutants={'CO';'NO2';'Ozone';'SO2'};  % ; 'NO2'; 'Ozone'
    Str_Date='02/01';  % mm/dd
    End_Date='03/31';  % mm/dd
    Days_Between=59;
    Number_of_Years=5; % 2016, 2017, 2018, 2019 and 2020 in this order.

    
%   Conver to Numbers:
    Str_mm=str2num(Str_Date(1:2));
    Str_dd=str2num(Str_Date(4:5));
    End_mm=str2num(End_Date(1:2));
    End_dd=str2num(End_Date(4:5));
    
%   Go through all the Counties:
    for c=1:length(Counties)
%       Go through all the Pollutants:
        for p=1:length(Pollutants)
%       Get all the files of that folder:
            Files = dir([pathFolder,'\',Counties{c},'\',Pollutants{p}]);
%           Go through each file (Start from the third, since the first two are . and ..:
            for f=3:length(Files)

%               Initialize the Column vector:
                ColVector=[];
%               Open the File:
                T=readtable([Files(f).folder,'\',Files(f).name]);
%               Query the information of the dates needed: 
                for e=1:size(T,1)
%                   Check if the date belongs:
%                      Reinitialize the Date Flags (to know if it is between those two dates):
                       flag_Str=0;
                       flag_End=0;
%                      Get the date:
                       Date=T{e,1};           
                       
%                      Bigger than the Start date:
%                         Bigger month:
                          if Date.Month>Str_mm
                             flag_Str=1; 
%                         Same month                              
                          elseif Date.Month==Str_mm
%                            Compare Day:
                             if Date.Day>=Str_dd
                                flag_Str=1;
                             end
                          end
                             
%                      Smaller than the End date:
%                         Smaller month
                          if Date.Month<End_mm
                             flag_End=1; 
%                         Same month                              
                          elseif Date.Month==End_mm
%                            Compare Day:
                             if Date.Day<=End_dd
                                flag_End=1;
                             end
                          end
                         
%                      Only if the date is in between the desired dates:
                       if flag_Str && flag_End && (Date.Day~=29 || Date.Month~=2)

                          ColVector=[ColVector;
                                     str2num(cell2mat(T{e,5}))];
                           
                                 
                                 
                       end
                end
                
%               Display if needed:
%               disp(size(ColVector));

%               Put the information in the corresponding year:
                County{c}.Pollutant{p}.Year{f-2}= ColVector;     % f-2 due to the first two objects . and ..
                
            end
        end
    end

    
%   Plotting 1:
%      Go through all the Counties:
       for c=1:length(Counties)
%          Go through all the Pollutants:
           for p=1:length(Pollutants)
%              Create the figure:
               figure; hold on; set(gcf,'color','w');
               
%              Go through all the past Years:    
               for y=1:(length(County{c}.Pollutant{p}.Year))
                   plot(County{c}.Pollutant{p}.Year{y}, 'color', [0.8, 0.8, 0.8]);
               end
               
%              Go through the current Year:                
               plot(County{c}.Pollutant{p}.Year{end}, 'b');

%              Information:
               xlabel('Days');
               ylabel(['ppm of ',Pollutants{p}]);
               title(['Evolution of the concentration of ', Pollutants{p}, ' in ', Counties{c}(1:2),'-',Counties{c}(4:end)]);
               
           end
       end  
       
       
%   Plotting 2:
%      Go through all the Counties:
       for c=1:length(Counties)
%          Go through all the Pollutants:
           for p=1:length(Pollutants)
               
%              Initialize CumSum:
               CumSum=zeros(Days_Between,1);  
               count=0;
               
%              Go through all the past Years:    
               for y=1:(length(County{c}.Pollutant{p}.Year)-1)
%                  Make sure that the one we are looking at has exactly Days_Between entries:                    
                   if size(County{c}.Pollutant{p}.Year{y},1)==Days_Between 
                      CumSum=County{c}.Pollutant{p}.Year{y}+CumSum;
                      count=count+1;
                   end
               end
               
%              Take the average:
               AvgPast=CumSum./count;
               
%              Smoothing of the Averaged Past Years Data:           
               SmPast=smooth(AvgPast, 0.3);
%              Smoothing of the Current Year Data:           
               SmCurr=smooth(County{c}.Pollutant{p}.Year{end}, 0.3);               
               
%              Difference:
               Diff{c}{p}=SmPast-SmCurr;
               
%              Plotting of the Smoothed Charts:  
%                 Create the figure:
                  figure; hold on; set(gcf,'color','w');
%                 Plot the Average of the Past:                
                  plot(SmPast, 'color', [0.8, 0.8, 0.8]);
%                 Go through the current Year:                
                  plot(SmCurr, 'b');                             
%                 Labels:
                  xlabel('Days');
                  ylabel(['ppm of ',Pollutants{p}]);
                  title(['Smoothed Evolution of the concentration of ', Pollutants{p}, ' in ', Counties{c}(1:2),'-',Counties{c}(4:end)]);
            
%              Plotting of the Difference Charts:    
%                 Create the figure:
                  figure; set(gcf,'color','w');
%                 Plot the Average of the Past:                
                  plot(Diff{c}{p}, 'g');                            
%                 Labels:
                  xlabel('Days');
                  ylabel(['Difference of ppm of ',Pollutants{p}]);
                  title(['Difference of the Smoothed Evolution of the concentration of ', Pollutants{p}, ' in ', Counties{c}(1:2),'-',Counties{c}(4:end)]);
                        
           end
       end         
       
%   Finally write the information in an execell file to use it in the prediction tool:
%      Use a counter:
       inc=0;
%      Go through all the Counties:
       for c=1:length(Counties)
%          Go through all the Pollutants:
           for p=1:length(Pollutants)
%              Vector:
               inc=inc+1;
               Climate_Matrix(inc,:)=Diff{c}{p};
           end
       end

end




