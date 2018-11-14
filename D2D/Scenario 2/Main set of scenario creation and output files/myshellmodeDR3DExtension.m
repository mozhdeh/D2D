 clc
 clear all
 close all

%we use this script (mainly just the following for loop) both for single & double cell rate adjustment scenarios

  for k=1:20; %for introducing redundancy, as done in the "createScenarioMath" file 
   for t=1:20; %for increasing poisson arrival rate (t); each is associated with a generated (in the "createScenarioMath" file) specific #BG

               myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
               fullfilename=fullfile(myfolder,['BGC' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
               BGC1=dlmread(fullfilename); 
               save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BGC1.mat','BGC1')
                            
               createScenarioRand(size(BGC1,1),120); %"size(BGC1,1)" is #BG indeed 
  
%                %save the delivery ratio in the text file
%                if size(BGC1,1)>=5; % reuse mode
%                load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/graph1.mat','graph1')
%                DR(k,t)=graph1;
%                else %scheduled
%                load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/graph1sched.mat','graph1sched')
%                DR(k,t)=graph1sched;    
%                end;
               
               %save the BLER(BER indeed) in the text file
               load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BLER1.mat','BLER1')
               BLER(k,t)=BLER1;
               
               %save the BLERreal in the text file
               load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BLERreal1.mat','BLERreal1')
               BLERreal(k,t)=BLERreal1;
               
               %save the modulation type in the text file
               load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/ModulationType.mat','ModulationType')
               Modulation(k,t)=ModulationType;
               
               %save the BLER matrix(BG,receivers), in order to plot the
               %distance-based BLER
               %note that since RAWBLER1 is a matrix itself, we cannot save it into a corresponding matrix of dimension (k,t); so we save it immediately in the loop itself, not like the BLER and Dr outside of the loop            
               load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/RAWBLER1.mat','RAWBLER1')
               myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
               fullfilename=fullfile(myfolder,['RAWBLER' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
               dlmwrite(fullfilename,RAWBLER1);
               
               %save the BLERreal matrix(BG,receivers), in order to plot the
               %distance-based BLERreal
               %note that since RAWBLERreal1 is a matrix itself, we cannot save it into a corresponding matrix of dimension (k,t); so we save it immediately in the loop itself, not like the BLER and Dr outside of the loop            
               load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/RAWBLERreal1.mat','RAWBLERreal1')
               myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
               fullfilename=fullfile(myfolder,['RAWBLERreal' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
               dlmwrite(fullfilename,RAWBLERreal1);
               
%              load('SINR.mat','SINR'); 
%              myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
%              fullfilename=fullfile(myfolder,['SINR' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
%              dlmwrite(fullfilename,SINR);
               
               
               load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/EbN0.mat','EbN0')
               myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
               fullfilename=fullfile(myfolder,['EbN0' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
               dlmwrite(fullfilename,EbN0);
               
              
               %we load the "receiversT" matrix
               load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/receiversT.mat','receiversT')

               %here using the "receiversT" matrix we calculate the distance of each receiver from its
               %corresponding BG transmitter and save it in a matrix "DistTxRxReference"to be
               %used later for the ditance-based BLER graph
               
               DistTxRxReference=zeros(t,10);%10 is # of receivers
               
               for z=1:t;
                   for r=1:10;             
                       Xref=abs(BGC1(z,1)-receiversT(z,r,1));%for distance measure between desired X_tx and X_receiver
                       Yref=abs(BGC1(z,2)-receiversT(z,r,2));%for distance measure between desired Y_tx and Y_receiver
                       DistTxRxReference(z,r)=sqrt((Xref^2)+(Yref^2));%for the final distance measure between desired tx & receiver
                   end;
               end;
               DistTxRxReference;              
               myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
               fullfilename=fullfile(myfolder,['FinalDistTxRxReference' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
               dlmwrite(fullfilename,DistTxRxReference);
               
      
   end;
  end;
       

    %here we export the generated matrices to plot later
%     myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
%     fullfilename=fullfile(myfolder,['DRNewversion.txt']);
%     dlmwrite(fullfilename,DR,'delimiter','\t');
    
    fullfilename=fullfile(myfolder,['BLERNewversion.txt']);
    dlmwrite(fullfilename,BLER,'delimiter','\t');
    
    fullfilename=fullfile(myfolder,['BLERrealNewversion.txt']);
    dlmwrite(fullfilename,BLERreal,'delimiter','\t');
    
    fullfilename=fullfile(myfolder,['ModulationType.txt']);
    dlmwrite(fullfilename,Modulation,'delimiter','\t');
  
 
       
       
       