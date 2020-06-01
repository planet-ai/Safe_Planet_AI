function Main_Script

%  Specify the Method For the Prediction:
   Method='SVM_Regression'; %  'SVM_Regression'  or 'Regression' or 'Cascade_NN' 
   
%  Select the Number of PCA components Desired:
   C=3;
   
%  --------------------------------------------------------------------------------------------------------------

%  Get the Climate Date:
   Climate_Matrix=Climate_Data;
   
%  Get the Hospital Data:
   [Cases, Hospitalizations,Em_Visits_0_17, Em_Visits_18_44, Em_Visits_45_64, Em_Visits_65_74, Em_Visits_75_On] = Hospital_Data;

%  Get the Flight Data:
   Flights=Flight_Data;

%  Get the Traffic Data:
   Traffic=Traffic_Data;
   
%  Create the Matrix:
   Feature_Matrix(:,1)=Cases;
   Feature_Matrix(:,2)=Climate_Matrix(1,:);
   Feature_Matrix(:,3)=Climate_Matrix(2,:);
   Feature_Matrix(:,4)=Climate_Matrix(3,:);
   Feature_Matrix(:,5)=Climate_Matrix(4,:);
   Feature_Matrix(:,6)=Hospitalizations;
   Feature_Matrix(:,7)=Em_Visits_0_17;
   Feature_Matrix(:,8)=Em_Visits_18_44;
   Feature_Matrix(:,9)=Em_Visits_45_64;
   Feature_Matrix(:,10)=Em_Visits_65_74;
   Feature_Matrix(:,11)=Em_Visits_75_On;
   Feature_Matrix(:,12)=Flights;
   Feature_Matrix(:,13)=Traffic;
   
%  Store the Matrix:
   xlswrite('Feature_Matrix_File.xlsx',Feature_Matrix);
   
%  Correlation Matrix:
%     Correlation:
      Corr=corrcoef(Feature_Matrix);
%     Display the correlation matrix:
      SeaSaltMap = Use_SeaSaltMap;
      figure; imagesc(Corr); colormap(SeaSaltMap); colorbar; 
      title('Correlation Matrix'); set(gcf,'color','w');
      
%  Correlation Chart:
   t_vec = Corr(1,2:end);
   x_vec = 1:length(t_vec);
   figure; stem(x_vec,t_vec,'LineStyle','-.','MarkerFaceColor','red','MarkerEdgeColor','green')
   title('Correlation of Input Vars. vs Output Var.'); set(gcf,'color','w');
   xlim([0,length(t_vec)+1]); 

%  Training:
   Fr_tr=0.8;
   N=size(Feature_Matrix,1);
   N_tr=round(Fr_tr*N);
   
%  Matrices:   
   X_tr=Feature_Matrix(1:N_tr,2:end);
   y_tr=Feature_Matrix(1:N_tr,1);
   X_ts=Feature_Matrix(N_tr+1:end,2:end);
   y_ts=Feature_Matrix(N_tr+1:end,1);
   
%  Perform PCA:
   Coeffs=pca(X_tr);
   Xcentered_tr = X_tr*Coeffs';
   figure; imagesc(Coeffs); colormap(cool); colorbar; 
   
%  Apply the same transformation to the Testing Dataset:
   Xcentered_ts= X_ts*Coeffs';
   

%  Select the Method for the Prediction:
   switch Method
       case 'Cascade_NN'
%            Cascade Fordward Network:
             net = cascadeforwardnet(10);
             net = train(net,Xcentered_tr(:,1:C),y_tr);
             view(net)
             disp('y_testing'); disp(y_ts);
             y_pred = net(Xcentered_ts(:,1:C))*0.5;
             disp('y_predicted'); disp(round(y_pred));
             Perf = perform(net,y_pred,y_tr);
             
       case 'SVM_Regression'
%            SVM Regression Model:
             Model = fitrsvm(Xcentered_tr(:,1:C),y_tr);
             y_pred = predict(Model,Xcentered_ts(:,1:C))*0.5;
             disp('y_testing'); disp(y_ts);
             disp('y_predicted'); disp(round(y_pred));
             RMSE=sqrt(mean((y_pred - y_ts).^2));  
             
       case 'Regression'
%            Regression Model:
             Model = fitlm(Xcentered_tr(:,1:C),y_tr,'linear');        
             y_pred = predict(Model,Xcentered_ts(:,1:C))*0.5;
             disp('y_testing'); disp(y_ts);
             disp('y_predicted'); disp(round(y_pred));
             RMSE=sqrt(mean((y_pred - y_ts).^2));

   end
   
%  Final Plot:
   figure; hold on; set(gcf,'color','w');
   plot(y_pred,'LineWidth',2,'color',[226, 73,29]/256);
   plot(y_ts,'LineWidth',2,'color',[73,134,226]/256);
   ylim([0,7000]); legend('Predicted','Real','Location','northwest');
   title('Evolution of Cases in New York City');
   xlabel('Days'); ylabel('Number of COVID-19 Cases');
   
   
end




