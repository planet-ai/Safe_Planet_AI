
function  Traffic=Traffic_Data

%  Path of the Folder:
   pathFolder = 'C:\Users\USUARIO\Desktop\Second Tool\Traffic_Data';

%  New Cases, Hospitalizations, Deaths:
%     Open the File of Cases (preliminary table, we need to add more info):
      T=readtable([pathFolder,'\','TLC_New_Driver_Application_Status_Count.csv']);
      Traffic=T{1:59,2};

end