
function Flights=Flight_Data

%  Path of the Folder:
   pathFolder = 'C:\Users\USUARIO\Desktop\Second Tool\Flight Data';

%  New Cases, Hospitalizations, Deaths:
%     Open the File of Cases (preliminary table, we need to add more info):
      T=readtable([pathFolder,'\','feb_mar_flight_p_Day.csv']);
      Flights=T{:,9};
      
end