 clc
 clear all
 close all
 
  
 %for #BGs>10, #Rbs per BG would be less than the threshold:2; if this is
 %the case 10 number of BGs would be randomly chosen to be served within
 %the current SCPeriod and the rest would be placed in an array to be
 %served in the next period; based on this, we can derive the measure for
 %Delay, such that the ditributino of # of SCPeriod that an arbitrary BG
 %must wait in order to be served.
 
 %we don't consider the above criteria (#BGs<10); instead, we say that, with the
 %existing # of BGs we try to serve them as orthogonal as possible and if
 %not some of them inevitable suffer from interference due to resource
 %reuse; but our algorithm keeps the number of suffering BGs as low as
 %possible.
 
 for k=1:1; %this for loop is meant for introducing k time redundancy per each lambda (i.e. "t" in the following loop)
 for t=30:30; %this for loop is meant for creating consecutive BGCs, each with a different increasing lambda, compared to the previous one.  
     
%Coordinates Cell 1
Cell1X = 3.5;
save('Cell1X.mat','Cell1X')
Cell1Y = 6;
save('Cell1Y.mat','Cell1Y')
Cell1R = 5;
save('Cell1R.mat','Cell1R')
 
 %Instead of random, we consider poisson distribution for the # of BGs at
 %each SCPeriod interval; we consider a vector of increasing lambda, where
 %in each run lambda is taken from this vector and the corresponding
 %disjoint set in Mathematica is made.
 
 %lambda = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]; 
 %numberOfBG = lambda(1,t);
 numberOfBG = t; %this is temporarily set just to test BG=30.
 
 %I'll uniformly distribute the transmitters as well; 
for a=1:numberOfBG;
    %uniformly distribute transmitters
        BGC1(a,1)=unifrnd((Cell1X-3),(Cell1X+3));
        BGC1(a,2)=unifrnd((Cell1Y-3),(Cell1Y+3));
        BGC1(a,3)=2;%note that we consider radius of a BG as 1km and not 2 as here; so check wherver it is used to be changed to 1km.
end;

%This script only executes the first part of the "createScenarioext"
%script, in order to generate the graph of BGs. The connectivity matrix of
%this graph would be exported as a text file, which later would be imported
%into a Mathematica script "IndependentSubsetGenerator", in order to
%generate the disjoint sets of independent subsets. These sets would later
%be imported into the "poolRBAllocationReuse" script and the RB allocation
%would be done based on these sets (intelligent allocation(reuse))

numberOfReceivers = 10;
save('numberOfReceivers.mat','numberOfReceivers')
textFileName = ['BGC' num2str(t) 'dynamicraterep' num2str(k) '.txt'];
dlmwrite(textFileName,BGC1);

 %--------------------------------------------------------------------------%
 %------------------------------Extension part------------------------------%
 %----This part saves the connectivity matrix of the BG transmitters in a txt file for later use to do distance-based reuse and not random------%
 %we will form independent subsets of size "LI" out of the whole complete graph of the transmitters in Mathematica, by first importing 
 %the connectivity matrix "D2D-connectivity-matrix.txt" and then use the built-in function to generate the independent subsets of size "LI"%
  
 %For this, first we create a graph, containing the BG transmitters as the nodes and
 %connect the ones that are closer than the given transmission range "0.5 km"
 
 %First we take the first two columns of "BGC1" matrix to save the (X,Y) of nodes
 M = BGC1(: , 1:2)
 Size_mat= size(M)
 
 %Now spot the ones that are closer than double the transmission range "2km"
 %matrices to save metrics of interest
 Dist_of_nodes=zeros(Size_mat(1,1),Size_mat(1,1));
 Logic_Dist_of_nodes=zeros(Size_mat(1,1),Size_mat(1,1));

 % "2" in the following "for" loop is the 2*transmission range of D2D transmitters (2km)
 for i = 1:Size_mat(1,1);
    for j = 1:Size_mat(1,1);
         dist =norm(M(i,:) - M(j,:));
         Dist_of_nodes(i,j)=dist;
            if i~=j && dist<2;
                Logic_Dist_of_nodes(i,j)=1;
            else
                 Logic_Dist_of_nodes(i,j)=0;
            end;
    end;

 end;


 %In the following we make the graph out of the "Logic_Dist_of_nodes"
 %matrix
 
 %plot the generated graph
 figure(2)
 hold on
 for i=1:Size_mat(1,1);
   plot(M(i,1), M(i,2), 'bo','MarkerFaceColor',[0 0 0],'MarkerSize',10); 
   %numbering the nodes
   text(M(i,1), M(i,2), num2str(i),'FontSize',17);
   dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
   text(M(i,1)+dx, M(i,2)+dy, num2str(i),'FontSize',17);
   %grid on
 end;
 
 
%plot lines btwn any two points, with relative distance
%less than threshold distance

 for i = 1:Size_mat(1,1);
    for j = 1:Size_mat(1,1);
         
        if Logic_Dist_of_nodes(i,j)==1;
                
           line([M(i,1) M(j,1)], [M(i,2) M(j,2)],'Color',[0 0 0],'LineStyle', '-');
        end;
    end;

 end;

%define Load Index(LI). Since we need "LI" in order to run the Mathematica code for determining the independent subsets of the graph, we get and export it here as follows
D2DresourcesSRBDefaultCell1=4;%The default number of continious RBs for a user is 5, so at each subframe we have 4 number of default resources
LI=numberOfBG/D2DresourcesSRBDefaultCell1
%save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/LI.txt','LI','-ascii');
fid = fopen('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/LI.txt', 'wt');
fprintf(fid,'% g',LI);
 
%save the plot as figure
%figure(z)
FileName=sprintf('D2D-connectivity-graph');
saveas(figure(2),FileName,'pdf');

%save the connectivity matrix corresponding to the figure in a text file to be imported in Mathematica 
fid = fopen('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/D2D-connectivity-matrix.txt', 'wt');
%fprintf(fid,'% g',Logic_Dist_of_nodes);
for i = 1:numberOfBG
    for j = 1:numberOfBG
        fprintf(fid,'% g',Logic_Dist_of_nodes(i,j));
    end
    fprintf(fid,'\n');
end
 
%save the numberOfBG in a text file to be imported in Mathematica. We use
%this number to check the presence of all BGs in the generated disjoint
%independent subset "result" in Mathematica, before importing it to Matlab
fid = fopen('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBG.txt', 'wt');
fprintf(fid,'% g',numberOfBG);

%also we create a BGlist where we save # of BGs for all rounds of the code,
%to be used later in the batch mode run
filename = ['BGlistdynamicraterep' num2str(k) '.txt'];
%fid = fopen('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BGlist' num2str(k) '.txt', 'a+');
fid =  fopen(filename,'a+');
fprintf(fid,'% g',numberOfBG);
fprintf(fid,'\n');


textFileName = ['BGC' num2str(t) 'dynamicraterep' num2str(k) '.txt'];
dlmwrite(textFileName,BGC1);

pause %this pause is to have some time to run the Mathematica code, for generating the disjoint set corresponding to the current # of BGs
 end;
pause %this pause is to have some time to change the redundancy repetition "k" in the Mathematica file, in order to generate the descriptive disjoint set file names
 end;






