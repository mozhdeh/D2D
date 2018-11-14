%%%%%%%%Second graph for BLEr vs. increasing distance of the receivers
%%%%%%%%(distance bins on X axis); this can be a 3D graph with Y axis as
%%%%%%%%the increasing network load
%read the files saving the distances of receivers to their corresponding
%transmitters; also reading the BLER


%first, we create a matrix "MeanforBin", to save the mean
%BLER values of each bin; we have 4 bins as: 0-0.05, 0.05-0.1, 0.1-0.15,
%0.15-0.2[km].
MeanforBin = zeros(1,4); %4 here is # of bins

%we also create the "MeanforBinTotal" matrix to save all the "MeanforBin"
%for various increasing #BG
MeanforBinTotal = [];


   for t=1:20;%#BG
    myDistArray = zeros(t,10,20);% 20 here is max k in the following for loop
    myRAWBLERArray = zeros(t,10,20);% 20 here is max k in the following for loop
    myRAWBLERrealArray = zeros(t,10,20);% 20 here is max k in the following for loop
    
    for k=1:20;%redundancy    
    
     % if (k==3 || k==5 || k==9 || k==16 || k==18 || k==20);
            
      %    continue
           
     % else
        
    myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
    fullfilename=fullfile(myfolder,['FinalDistTxRxReference' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
    myDistArray(:,:,k)=dlmread(fullfilename);   
        
    myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
    fullfilename=fullfile(myfolder,['RAWBLER' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
    myRAWBLERArray(:,:,k)=dlmread(fullfilename);

    myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
    fullfilename=fullfile(myfolder,['RAWBLERreal' num2str(t) 'dynamicraterep' num2str(k) '.txt']);
    myRAWBLERrealArray(:,:,k)=dlmread(fullfilename);
    
     %end;
     
    end;
    
    
    %now here we find indices of all elements falling in each distance bin
    %in "myDistArray" matrix; 
    [r,c,v] = ind2sub(size(myDistArray),find(myDistArray >= 0 & myDistArray <= 0.05))% bin=1
   
    %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,1)=0;
        
    else
       
    mydimension = size(r,1); %#of indices  
       
    myBinIndices = zeros(mydimension,3);%3 here is r,c,v (row, column, page)
    %here a mini for loop to fill in the "myBinIndices" matrix
    for i=1:mydimension;
        myBinIndices(i,1)=r(i);
        myBinIndices(i,2)=c(i);
        myBinIndices(i,3)=v(i);
    end;
    
    %now that we have "myBinIndices" matrix, we average the elements of
    %"myRAWBLERrealArray" matrix, having those indices
    
    bler_sum = 0; 
    for i=1:mydimension;      
    temp = myRAWBLERArray(myBinIndices(i,1),myBinIndices(i,2),myBinIndices(i,3));
    bler_sum = bler_sum + temp; 
    end;

    %now the mean is
     MeanforBin(1,1) = bler_sum / mydimension; 
   
    end;

%%%%%%%%%%%%calculation for bin2

 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.05 & myDistArray <= 0.1));% bin=2
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,1)=0;
        
    else
       
    mydimension = size(r,1) %#of indices  
       
    myBinIndices = zeros(mydimension,3);%3 here is r,c,v (row, column, page)
    %here a mini for loop to fill in the "myBinIndices" matrix
    for i=1:mydimension;
        myBinIndices(i,1)=r(i);
        myBinIndices(i,2)=c(i);
        myBinIndices(i,3)=v(i);
    end;
    %now that we have "myBinIndices" matrix, we average the elements of
    %"myRAWBLERrealArray" matrix, having those indices


    bler_sum = 0; 
    for i=1:mydimension;      
    temp = myRAWBLERArray(myBinIndices(i,1),myBinIndices(i,2),myBinIndices(i,3));
    bler_sum = bler_sum + temp; 
    end;

    %now the mean is
     MeanforBin(1,2) = bler_sum / mydimension; 
   
    end;

%%%%%%%%%%%%calcualtion for bin3

 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.1 & myDistArray <= 0.15));% bin=3
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,1)=0;
        
    else
       
    mydimension = size(r,1) %#of indices  
       
    myBinIndices = zeros(mydimension,3);%3 here is r,c,v (row, column, page)
    %here a mini for loop to fill in the "myBinIndices" matrix
    for i=1:mydimension;
        myBinIndices(i,1)=r(i);
        myBinIndices(i,2)=c(i);
        myBinIndices(i,3)=v(i);
    end;
    %now that we have "myBinIndices" matrix, we average the elements of
    %"myRAWBLERrealArray" matrix, having those indices


    bler_sum = 0; 
    for i=1:mydimension;      
    temp = myRAWBLERArray(myBinIndices(i,1),myBinIndices(i,2),myBinIndices(i,3));
    bler_sum = bler_sum + temp; 
    end;

    %now the mean is
     MeanforBin(1,3) = bler_sum / mydimension;
   
    end; 
    
%%%%%%%%%%%%calcualation for bin4
    
 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.15 & myDistArray <= 0.2));% bin=4
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,1)=0;
        
    else
       
    mydimension = size(r,1) %#of indices  
       
    myBinIndices = zeros(mydimension,3);%3 here is r,c,v (row, column, page)
    %here a mini for loop to fill in the "myBinIndices" matrix
    for i=1:mydimension;
        myBinIndices(i,1)=r(i);
        myBinIndices(i,2)=c(i);
        myBinIndices(i,3)=v(i);
    end;
    %now that we have "myBinIndices" matrix, we average the elements of
    %"myRAWBLERrealArray" matrix, having those indices


    bler_sum = 0; 
    for i=1:mydimension;      
    temp = myRAWBLERArray(myBinIndices(i,1),myBinIndices(i,2),myBinIndices(i,3));
    bler_sum = bler_sum + temp; 
    end;

    %now the mean is
     MeanforBin(1,4) = bler_sum / mydimension;
   
    end; 
       
   MeanforBinTotal = vertcat(MeanforBinTotal,MeanforBin);
    
   end;


%plot making
width1 = 0.5;
figure
p=bar3(MeanforBinTotal,width1);
set(gca,'ZScale','log')
set(p,'FaceColor',[1 0.4 1])%light magneta
%reversing the BG arrival rate axis in the plot
set(gca,'XDir','reverse','YDir','reverse')
xlabel('RX-TX distance','FontSize',10)
ylabel('BG activation rate','FontSize',10)

zlabel('BER','FontSize',10)
pbaspect([1.5 2 1.5])
%daspect([2 6 1])
%set(gca,'ZScale','log') % logarithmic scale for Z axis


% figure
% h1 = axes
% set(h1, 'Ydir', 'reverse')
% set(h1, 'YAxisLocation', 'Right')
% h2 = axes
% set(h2, 'XLim', get(h1, 'XLim'))
% set(h2, 'Color', 'None')
% set(h2, 'Xtick', [])


%graph for modulation usage %
% width1 = 0.07;
% names = {'4QAM'; '16QAM'};
% x = [4 16];%modulation type
% y = [78.3 21.67];
% bar(x,y,width1)
% xlabel('Modulation type') % x-axis label
% ylabel('% Usage') % y-axis label
%set(gca,'xtick',[1:1],'xticklabel',names)


% lgd=legend({'spatial reuse','random'},'FontSize',20);
% set(lgd,'FontSize',30);
% set(gca,'FontSize',18)
% xlabel('Distance','FontSize',22)
% ylabel('BG activation rate','FontSize',22)
% zlabel('BLER(%)','FontSize',22) 
% axis([1 6 1 20 0 70])
% x1=[1,2,3,4,5,6];
% x2=[5,7,9,11,13,15];
% set(gca,'XTick',x1)
% set(gca,'XTickLabel',x2)
% %set(get(gca,'XLabel'),'Rotation',18);
% %set(get(gca,'YLabel'),'Rotation',-35);
% daspect([2 5 30])
% grid on 
%         

    
