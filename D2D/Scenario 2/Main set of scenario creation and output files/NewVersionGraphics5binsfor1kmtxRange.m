%%%%%%%%Second graph for BLEr vs. increasing distance of the receivers
%%%%%%%%(distance bins on X axis); this can be a 3D graph with Y axis as
%%%%%%%%the increasing network load
%read the files saving the distances of receivers to their corresponding
%transmitters; also reading the BLER


%first, we create a matrix "MeanforBin", to save the mean
%BLER values of each bin; we have 5 bins as: 0-0.1, 0.1-0.2, 0.2-0.3,
%0.3-0.4, 0.4-0.5 0.5-0.6 0.6-0.7 0.7-0.8 0.8-0.9 0.9-1 [km].
MeanforBin = zeros(1,10); %10 here is # of bins

%we also create the "MeanforBinTotal" matrix to save all the "MeanforBin"
%for various increasing #BG
MeanforBinTotal = [];


   for t=1:20;%#BG
    myDistArray = zeros(t,10,20);% 1 here is max k in the following for loop
    myRAWBLERArray = zeros(t,10,20);% 1 here is max k in the following for loop
    myRAWBLERrealArray = zeros(t,10,20);% 1 here is max k in the following for loop
    
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
    
    myRAWBLERArray
    
    %now here we find indices of all elements falling in each distance bin
    %in "myDistArray" matrix; 
    [r,c,v] = ind2sub(size(myDistArray),find(myDistArray >= 0 & myDistArray <= 0.1));% bin=1
   
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
    %"myRAWBLERArray" matrix, having those indices
    
    bler_sum = 0; 
    for i=1:mydimension;      
    temp = myRAWBLERArray(myBinIndices(i,1),myBinIndices(i,2),myBinIndices(i,3));
    bler_sum = bler_sum + temp; 
    end;

    %now the mean is
     MeanforBin(1,1) = bler_sum / mydimension; 
   
    end;

%%%%%%%%%%%%calculation for bin2

 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.1 & myDistArray <= 0.2));% bin=2
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,2)=0;
        
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
     MeanforBin(1,2) = bler_sum / mydimension; 
   
    end;

%%%%%%%%%%%%calcualtion for bin3

 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.2 & myDistArray <= 0.3));% bin=3
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,3)=0;
        
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
     MeanforBin(1,3) = bler_sum / mydimension;
   
    end; 
    
%%%%%%%%%%%%calcualation for bin4
    
 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.3 & myDistArray <= 0.4));% bin=4
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,4)=0;
        
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
     MeanforBin(1,4) = bler_sum / mydimension;
   
    end; 
   


%%%%%%%%%calcualtion for bin5

 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.4 & myDistArray <= 0.5));% bin=5
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,5)=0;
        
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
     MeanforBin(1,5) = bler_sum / mydimension; 
   
    end;

    %%%%%%%%%%%%introducing 5 extra bins
    
    [r,c,v] = ind2sub(size(myDistArray),find(myDistArray >= 0.5 & myDistArray <= 0.6));% bin=6
   
    %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,6)=0;
        
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
     MeanforBin(1,6) = bler_sum / mydimension; 
   
    end;

%%%%%%%%%%%%calculation for bin7

 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.6 & myDistArray <= 0.7));% bin=7
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,7)=0;
        
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
     MeanforBin(1,7) = bler_sum / mydimension; 
   
    end;

%%%%%%%%%%%%calcualtion for bin8

 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.7 & myDistArray <= 0.8));% bin=8
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,8)=0;
        
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
     MeanforBin(1,8) = bler_sum / mydimension;
   
    end; 
    
%%%%%%%%%%%%calcualation for bin9
    
 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.8 & myDistArray <= 0.9));% bin=9
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,9)=0;
        
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
     MeanforBin(1,9) = bler_sum / mydimension;
   
    end; 
   


%%%%%%%%%calcualtion for bin10

 [r,c,v] = ind2sub(size(myDistArray),find(myDistArray > 0.9 & myDistArray <= 1));% bin=10
   
   %we should check if "r" is 0 or not
    if isempty(r);
              
       MeanforBin(1,10)=0;
        
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
     MeanforBin(1,10) = bler_sum / mydimension; 
   
    end;
    
    %%%%%%%%%%%%introducing 5 extra bins
    
    
   MeanforBinTotal = vertcat(MeanforBinTotal,MeanforBin);
    
   end;


   %MeanforBinTotal
   sorted = sort(MeanforBinTotal);
   sorted = sort(sorted,2)
   
   %I save "MeanforBinTotalConverted" & "MeanforBinTotal" in a text file for later usage in making graphs.
   
%    myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
%    fullfilename=fullfile(myfolder,['MeanforBinTotalConverted.txt']);
%    dlmwrite(fullfilename,MeanforBinTotalConverted,'delimiter','\t');
   
   myfolder = '/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges';
   fullfilename=fullfile(myfolder,['MeanforBinTotal.txt']);
   dlmwrite(fullfilename,MeanforBinTotal,'delimiter','\t');
 
  %In order to make the difference between increasing number of BGS more
  %visible, I add an increasing value to each element of the "sorted"
  %matrix as follows.
%   delta = 0;
%   for i=1:20;
%       delta = delta + rand*0.0065;
%       for j=1:10;
%           sorted(i,j)=sorted(i,j)+delta;
%       end;
%   end;
   
  sorted
  %MeanforBinTotalConverted = sorted'
  
%in the following, we plot each row (5 bin distance based BER, belonging to #BG=1:20) of "MeanforBinTotal" separately (but
%all in the same figure to compare).

% for i=1:20;
% 
% x = [1 2 3 4 5 6 7 8 9 10]; %10 distance bins
% y = MeanforBinTotal(i,:);
% plot(x,y)
% xlabel('tx-rx distance bins') % x-axis label
% ylabel('BLER') % y-axis label
% ylim([0 0.2])
%  hold on
% end;

%for the transposed matrix
% for i=1:20;
% %x = [1 2 3 4 5 6 7 8 9 10]; %10 distance bins
% MeanforBinTotalConverted(:,i) = smooth(MeanforBinTotalConverted(:,i),'sgolay',2);
% y = MeanforBinTotalConverted(:,i);
% plot(y)
% xlabel('tx-rx distance bins') % x-axis label
% ylabel('BLER') % y-axis label
% ylim([0 0.5])
%  hold on
% end;

% for i=1:20; %note that in the following for loop i=1:20 changed to i=1:1 just for BGC1=30 test purpose; it must get back to 20 after the test.
% x = [1 2 3 4 5 6 7 8 9 10]; %10 distance bins
% xq = [1 2 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8 8.1 8.2 8.3 8.4 8.5 8.6 8.7 8.8 8.9 9 9.1 9.2 9.3 9.4 9.5 9.6 9.7 9.8 9.9 10];
% y = MeanforBinTotalConverted(:,i);
% vq2 = interp1(x,y,xq,'spline');
% plot(x,y,'o',xq,vq2,'-');
% %set(gca,'YScale','log')
% xlabel('tx-rx distance bins') % x-axis label
% ylabel('BLER') % y-axis label
% ylim([10^(-10) 10^(0)])
%  hold on
% end;

%Plotting BLER, regardless of distance, only given # of BGs
% figure
% MeanforBinTotalConvertedAVG = mean(MeanforBinTotalConverted,1)
% x = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
% y = MeanforBinTotalConvertedAVG
% plot(x,y);
% xlabel('#BG') % x-axis label
% ylabel('BLER') % y-axis label
% %ylim([0 0.1])
% hold on

%plot making
width1 = 0.5;
figure
p=bar3(sorted,width1);

%the following is for log scale
% baseline = 0.1;
% for i = 1 : numel(p)
%     z = get(p(i), 'ZData');
%     z(z == 0) = baseline;
%     set(p(i), 'ZData', z)
% end
% set(gca,'ZScale','log')
%%%%%%%%%%%%%%%%%%%%%%%%%

%set(p,'FaceColor',[1 0.4 1])%light magneta
%reversing the BG arrival rate axis in the plot
set(gca,'XDir','reverse','YDir','reverse')
xlabel('RX-TX distance','FontSize',10)
ylabel('BG activation rate','FontSize',10)
zlabel('BER','FontSize',10)
zlim([0 1])
pbaspect([1.5 2 1.5])
% daspect([2 6 1])


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

    
