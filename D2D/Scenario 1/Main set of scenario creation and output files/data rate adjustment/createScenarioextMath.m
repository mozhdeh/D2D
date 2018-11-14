 clc
 clear all
 close all
 
 for t=1:1;

%This script only executes the first part of the "createScenarioext"
%script, in order to generate the graph of BGs. The connectivity matrix of
%this graph would be exported as a text file, which later would be imported
%into a Mathematica script "IndependentSubsetGenerator", in order to
%generate the disjoint sets of independent subsets. These sets would later
%be imported into the "poolRBAllocationReuse" script and the RB allocation
%would be done based on these sets (intelligent allocation(reuse))

%Coordinates Cell 1
Cell1X = 3.5;
Cell1Y = 6;
Cell1R = 5;

%Create 3 transmitters (Broadcast groups) (X & Y parameters and radius)
%inside the cell 1
numberOfBG = t; %--------------------CHANGE NUMBER OF BG'S----------------
save('numberOfBG.mat','numberOfBG')

numberOfReceivers = 10;
save('numberOfReceivers.mat','numberOfReceivers')

BGC1=zeros(numberOfBG,3);

%I'll uniformly distribute the transmitters as well; for now, I've
%commented it and use the previous fix coordinates.
for a=1:numberOfBG;
    %uniformly distribute transmitters
        BGC1(a,1)=unifrnd((Cell1X-3),(Cell1X+3));
        BGC1(a,2)=unifrnd((Cell1Y-3),(Cell1Y+3));
        BGC1(a,3)=2;
end;


textFileName = ['BGC' num2str(t) 'raterep1skip.txt'];
%textFileName ='BGCadjust.txt';
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
%save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustment/LI.txt','LI','-ascii');
fid = fopen('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustment/LI.txt', 'wt');
fprintf(fid,'% g',LI);
 
%save the plot as figure
%figure(z)
FileName=sprintf('D2D-connectivity-graph');
saveas(figure(2),FileName,'pdf');

%save the connectivity matrix corresponding to the figure in a text file to be imported in Mathematica 
fid = fopen('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustment/D2D-connectivity-matrix.txt', 'wt');
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
fid = fopen('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustment/numberOfBG.txt', 'wt');
fprintf(fid,'% g',numberOfBG);

pause %this pause here is to run the Mathematica script, in order to generate the Max independent subsets; then we run the "createScenarioext" as a function with input arguments in abtch mode

end;




