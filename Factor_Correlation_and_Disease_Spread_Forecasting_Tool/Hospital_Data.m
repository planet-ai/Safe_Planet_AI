function [Cases, Hospitalizations,Em_Visits_0_17, Em_Visits_18_44, Em_Visits_45_64, Em_Visits_65_74, Em_Visits_75_On] = Hospital_Data

%  Path of the Folder:
   pathFolder = 'C:\Users\USUARIO\Desktop\Second Tool\Hospital Data';

%  New Cases, Hospitalizations, Deaths:
%     Open the File of Cases (preliminary table, we need to add more info):
      T_PreCases=readtable([pathFolder,'\','Daily Counts.csv']);
%     Erase first row:
      T_PreCases(1,:)=[];
%     Add the null cases from Feb 01 till Feb 28:
%        Date:
         for i=1:28
             Date(i,1)=datetime(2020,2,i,'InputFormat','dd/MM/yyyy');
         end
%        Cases
         Cases=zeros(28,1);
%        Hospitalizations:
         Hospitalizations=zeros(28,1);
%        Deaths:        
         Deaths=zeros(28,1);
%        Build the Table:
         T_Cases=table(Date,Cases,Hospitalizations,Deaths);
   
%        Complete the Table with the important information:
         for i=29:size(T_PreCases,1)
             T_Cases(i,:)=T_PreCases(i-28,:);
         end
%     Erase the months that are not February and March:
      T_Cases(60:end,:)=[];
%     Display:
      disp(T_Cases);

%     Store the Output Variables:
      Cases=T_Cases{:,2};
      
%     Store the Input Variables:
      Hospitalizations=T_Cases{:,3};
      

      

%  Emergencies:
%     Read the table:
      T_Emergency=readtable([pathFolder,'\','Emergency Visits.csv']);   
%     Erase first row:
      T_Emergency(29,:)=[];  
%     Erase the months that are not February and March:
      T_Emergency(60:end,:)=[];
%     Display:
      disp(T_Emergency);     
     
%     Store the Input Variables:
      Em_Visits_0_17=T_Emergency{:,2};
      Em_Visits_18_44=T_Emergency{:,3};
      Em_Visits_45_64=T_Emergency{:,2};
      Em_Visits_65_74=T_Emergency{:,2};
      Em_Visits_75_On=T_Emergency{:,2};
     
end



