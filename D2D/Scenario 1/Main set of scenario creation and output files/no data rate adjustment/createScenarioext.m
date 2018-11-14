function createScenarioext(numberOfBG,scPeriod,messizeinpackets)
%Create the bitmap pool
bitmapPool

%Coordenates Cell 1
Cell1X = 3.5;
Cell1Y = 6;
Cell1R = 5;

save('numberOfBG.mat','numberOfBG')
numberOfReceivers = 10;
save('numberOfReceivers.mat','numberOfReceivers')
load('BGC1Coordinates.mat','BGC1')

 %--------------------------------------------------------------------------%
 %------------------------------Extension part------------------------------%
 %--------------------------------------------------------------------------%

%Create empty receivers matrix
receiversT = zeros(numberOfBG,numberOfReceivers,2);

for a=1:numberOfBG;
    %Create a matrix with X and Y for a given number of receivers per
    %broadcast group (Uniform distribution)
    for b=1:numberOfReceivers;
        receiversT(a,b,1)=unifrnd((BGC1(a,1)-1),(BGC1(a,1)+1));
        receiversT(a,b,2)=unifrnd((BGC1(a,2)-1),(BGC1(a,2)+1));
    end;
end;

%Show a graffic with the distribution of the elements
figure(1);
color = [0.2 0.6 0.8];
scatter(BGC1(:,1),BGC1(:,2),20000,color)
title('Scenario')
axis([0 12 0 12])
hold on
plot(BGC1(:,1),BGC1(:,2), '.b', 'MarkerSize',30)
hold on
for recbg=1:numberOfBG;
    color = [0 0.1 0.4];
    scatter(receiversT(recbg,:,1),receiversT(recbg,:,2),[],color)
    hold on
end;


%--------------------------------------------------------------------------%
%-----------------------------------Cell 2---------------------------------%
%--------------------------------------------------------------------------%

%Coordenates Cell 2
Cell2X = 9;
Cell2Y = 6;
Cell2R = 5;

%We consider a different number of BGs in Cell2
numberOfBGC2=randi([1 10],1,1);
save('numberOfBGC2.mat','numberOfBGC2')
%Determine basic parameters
BGC2=zeros(numberOfBGC2,3);
numberOfReceiversCell2 = 10;
numberOfCellularUsersCell2 = 20;
%Create matrix for cellular users
cellularUsersCell2=zeros(numberOfCellularUsersCell2,3);
id=21; %ID for cellular users

%I've changed the way of distribution of CUEs, for test
for a=1:numberOfCellularUsersCell2;
    cellularUsersCell2(a,1)=unifrnd((Cell2X-3),(Cell2X+3));
    cellularUsersCell2(a,2)=unifrnd((Cell2Y-3),(Cell2Y+3));
    cellularUsersCell2(a,3)=id;
    id=id+1;
end;

%Create matrix for receivers of cell 2
receiversTCell2 = zeros(numberOfBGC2,numberOfReceiversCell2,2);

%Create 3 transmitters (Broadcast groups) (X & Y parameters and radius)
%inside the cell 2; why not uniformly? like CUEs. yes, I'll do that:

%I'll uniformly distribute the transmitters as well; for now, I've
%commented it and use the previous fix coordinates. 
for a=1:numberOfBGC2;
    %uniformly distribute transmitters
        BGC2(a,1)=unifrnd((Cell2X-3),(Cell2X+3));
        BGC2(a,2)=unifrnd((Cell2Y-3),(Cell2Y+3));
        BGC2(a,3)=2;
end;

for a=1:numberOfBGC2;
    %Create a matrix with X and Y for a given number of receivers per
    %broadcast group
    for b=1:numberOfReceiversCell2;
        receiversTCell2(a,b,1)=unifrnd((BGC2(a,1)-1),(BGC2(a,1)+1));
        receiversTCell2(a,b,2)=unifrnd((BGC2(a,2)-1),(BGC2(a,2)+1));
    end;
end;

%Show a graffic with the distribution of the elements
color = [0.5 0.5 0.5];
scatter(Cell2X,Cell2Y,200000,color)
%set(gca,'XTick',[0 1 2 3 4 5 6 7 8 9 10 11 12] );
%set(gca,'XTickLabel',[0 2 4 6 8 10 12 14 16 18 20 22 24] );
hold on
color = [0.5 0.5 0.5];
scatter(Cell1X,Cell1Y,200000,color)
hold on
plot(Cell1X,Cell1Y, '.r', 'MarkerSize',30)
hold on
plot(Cell2X,Cell2Y, '.r', 'MarkerSize',30)
hold on
color = [0.5 0.8 0.4];
scatter(BGC2(:,1),BGC2(:,2),20000,color)
hold on
plot(BGC2(:,1),BGC2(:,2), '.g', 'MarkerSize',30)
hold on
plot(cellularUsersCell2(:,1),cellularUsersCell2(:,2), '.c', 'MarkerSize',25)
hold on
for recbg=1:numberOfBGC2;
    color = [0.5 0.1 0.4];
    scatter(receiversTCell2(recbg,:,1),receiversTCell2(recbg,:,2),[],color)
    hold on
end;

hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%variables for the scheduled mode in Cell1
packetLevelMatrixsched=zeros(numberOfBG,1500);
messageLevelMatrixsched=zeros(numberOfBG,100);
contSCPeriods=0;
contSCPeriodsMedian=0;
contSCPeriodsAuto=0;
contCUsersAllocMedian=0;
contCUsersAlloc=0;
bigMatrixCell1=[];
bigMatrixCell2=[];
bigBitmapCell1=[];
bigBitmapCell2=[];
successful=[];
receiverInterfScheduled=ones(numberOfBG,numberOfReceivers);
bigReceptionMatrixSched2=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%


%variable definition for later use
packetLevelMatrix=zeros(numberOfBG,1500);%not needed?no 
messageLevelMatrix=zeros(numberOfBG,100);%not needed?no 
packetLevelMatrixauto=zeros(numberOfBG,1500);
messageLevelMatrixauto=zeros(numberOfBG,100);
contSCPeriods=0;%not needed?no
contSCPeriodsMedian=0;%not needed?no
contSCPeriodsAuto=0;%not needed?no
contCUsersAllocMedian=0;%not needed?no
contCUsersAlloc=0;%this one is used for CUEs

bigBitmapCell1autonomous=[];
bigBitmapCell2autonomous=[];


bigMatrixCell1autonomous=[];
bigMatrixCell2autonomous=[];


successfulgraph=[];%not needed? it is needed.

contIntraCellInterfgraph=[];%not needed? it is needed.

receiverInterfreuse=ones(numberOfBG,numberOfReceivers);%not needed? it is used.
bigReceptionMatrixAuto2=[];%not needed?it is used.


%--------------------------------------------------------------------------%
%-------------------Extension starts for new RB allocation-----------------%
%--------------------------------------------------------------------------%
%nr of continuously allocated RBs, by default
LCRBdefaultCell1=5;
%system BW in terms of RBs
BW=50;
%determine total nr of default resources;in this case D2D and CUE have the
%same LCRB
nrResourcesdefaultCell1=BW/LCRBdefaultCell1;

%determine nr of resources for D2Ds in "on" bits; in terms of RBs;
%D2Dresources is constant:20 RBs in total; at each side(bottom/top):10
D2DresourcesRBCell1=20;

%determine nr of resources for D2Ds in "on" bits; in terms of SRBs
D2DresourcesSRBDefaultCell1=D2DresourcesRBCell1/LCRBdefaultCell1;

%determine nr of resources for CUEs in "on" bits; in terms of RBs:always
%50-20=30 RBs. so, 30/5=6SRBs for CUEs.
CUEresourceson=BW-(D2DresourcesRBCell1);

%determine nr of resources for CUEs in "off" bits; in terms of RBs
CUEresourcesoff=BW;

%Also define Load Index(LI) here, because we need it for calculations
LI=numberOfBG/D2DresourcesSRBDefaultCell1;

%determine LIth; the threshold LI of the system, using the circle packing
%problem; I'll put a precise formula here; Note that I've changed the radius of D2D
%transmitters from 0.5km to 2km, in order to have more reasonable "LIth"
LIth=0.83*((Cell1R/2)^2)-1.9;
LIth=floor(LIth);

%   if LI<=1;
%       poolRBAllocationScheduledext;
%   elseif (1<LI && LI<=LIth) || (LIth<LI && LI<LIth+1);%no need for rate adaptation yet
%       %consider the same default setting as the new ones; we do this rename
%       %to avoid errors while loading variables in "poolRBAllocationReuse".
%       
%       newD2DresourcesSRBCell1=D2DresourcesSRBDefaultCell1;
%       xSRB=newD2DresourcesSRBCell1/2; 
%       xSRB=floor(xSRB);
%       newLCRBCell1=10/xSRB;   
%       newLCRBCell1=floor(newLCRBCell1);
%       nrResourcesTotalCell1=(2*xSRB)+6;
%       %pass the required variables to other files as needed. here all these
%       %variables are the default ones. just their name is changed to avoid
%       %error while loading them with new names in "poolRBAllocationReuse".
%       save('myvariables.mat','xSRB','newLCRBCell1','LCRBdefaultCell1','nrResourcesTotalCell1','LI')
%       %dlmwrite('LI.txt',LI)
%       poolRBAllocationReuse;
%   else
%       %adjust the data rate, i.e. LCRB, such that LI=LIth
%       LI=LIth;
%       newD2DresourcesSRBCell1=numberOfBG/LIth;
%       newD2DresourcesSRBCell1=ceil(newD2DresourcesSRBCell1);
%       %find the nr of resources at bottom and top of 1 subframe, with 50
%       %RBs. we'll have "xSRB" resources at bottom and "xSRB" resources at top.
%       xSRB=newD2DresourcesSRBCell1/2; 
%       %xSRB=floor(xSRB);
%       xSRB=ceil(xSRB);
%       newD2DresourcesSRBCell1=2*(xSRB);
%       %since D2Dresources (at each side(bottom/top):10 in terms of RBs) is constant, we have newLCRBD2D as:
%       newLCRBCell1=10/xSRB;   
%       newLCRBCell1=floor(newLCRBCell1);
%       %determine the NEW total nr of resources, in terms of SRBs: resources for D2D(2*xSRB) + resources for CUEs(6).
%       nrResourcesTotalCell1=(2*xSRB)+6;
%       %pass the required variables to other files as needed.
%       save('myvariables.mat','xSRB','newLCRBCell1','LCRBdefaultCell1','nrResourcesTotalCell1','LI') 
%       %we export "LI" to be imported in Mathematica, in order to make the
%       %independent subsets of size "LI"
%       dlmwrite('LI.txt',LI)
%       poolRBAllocationReuse;
%   end;

%the following for loop is without rate adjustment
if LI<=1;
      poolRBAllocationScheduledext;
else 
      %consider the same default setting as the new ones; we do this rename
      %to avoid errors while loading variables in "poolRBAllocationReuse".
      
      newD2DresourcesSRBCell1=D2DresourcesSRBDefaultCell1;
      xSRB=newD2DresourcesSRBCell1/2; 
      xSRB=floor(xSRB);
      newLCRBCell1=10/xSRB;   
      newLCRBCell1=floor(newLCRBCell1);
      nrResourcesTotalCell1=(2*xSRB)+6;
      %pass the required variables to other files as needed. here all these
      %variables are the default ones. just their name is changed to avoid
      %error while loading them with new names in "poolRBAllocationReuse".
      save('myvariables.mat','xSRB','newLCRBCell1','LCRBdefaultCell1','nrResourcesTotalCell1','LI')
      %dlmwrite('LI.txt',LI)
      poolRBAllocationReuse;
 end;

%--------------------------------------------------------------------------%
%--------------------Extension ends for new RB allocation------------------%
%--------------------------------------------------------------------------%

%--------------------------------------------------------------------------%
%--------------------------Resource efficiency graph-----------------------%
%--------------------------------------------------------------------------%

%--------------------------------------------------------------------------%
%--------------here's the line that must be uncommented--------------------%
%--------------------------------------------------------------------------%

average1=0;
average2=zeros(1,1500);
messageSurf=zeros(1,100);
%average1=horzcat(average1,mean(successfulgraph));
%graph 1
%average2=vertcat(average2,successfulgraph);
%graph 2
messageSurf=vertcat(messageSurf,messageLevelMatrixauto);

%--------------------------------Final Graph 1-----------------------------
numberOfTTItoConsider=5;
maxBG=20;%I have changed this from "10", because I wanted to generate results for #BG:5-10, which is 6
%"graph1" & ..., "graph5", each contain values for 10 BGs for a certain SC_Period. 
%graph1=zeros(maxBG,numberOfTTItoConsider);
% % graph1=0;
% % graph1(1,1)=tbg;
% % save('graph1.mat','graph1');
%graph1=horzcat(graph1,tbg);
%graph1

%the following line is for calculating the "Spectral Efficiency" metric
% % se=0;
% % lines=0;
% % templines=0;
%"lines" in the following equation is the number of utilized resources,
%to be imported from Mathematica (in the reuse mode)
% % load('MySubsets.mat','MySubsets')
% % mysetsize=size(MySubsets);
% % templines=mysetsize(1,1);
% % lines=templines;
% % save('lines.mat','lines');
% % se=(numberOfBG*graph1)/templines;
% % save('se.mat','se')
%lines=templines;
%se=horzcat(se,se);
%lines=horzcat(lines,templines);
 
%%%%%%%%%%%%%%%%%%%%%
%graph2=0;
%graph2(1,1)=tbg;
%graph2=horzcat(graph2,tbg);
% graph3=0;
% graph3(1,1)=tbg;
% graph3=horzcat(graph3,tbg);
% graph4=0;
% graph4(1,1)=tbg;
% graph4=horzcat(graph4,tbg);
% graph5=0;
% graph5(1,1)=tbg;
% graph5=horzcat(graph5,tbg);


%this part belongs to "different message size". for each of the following
%instances, we should change "numberOfPackets & messizeinpackets" and then
%run. It's exactly like the previous set (graph1, ...graph5) + different
%message size
% graph11=0;
% graph11(1,1)=tbg;
% graph11=horzcat(graph11,tbg);
% graph12=0;
% graph12(1,1)=tbg;
% graph12=horzcat(graph12,tbg);
% graph13=0;
% graph13(1,1)=tbg;
% graph13=horzcat(graph13,tbg);
% graph14=0;
% graph14(1,1)=tbg;
% graph14=horzcat(graph14,tbg);
% graph15=0;
% graph15(1,1)=tbg;
% graph15=horzcat(graph15,tbg);


%%%%The following 3 lines must be uncommented for the "reuse" mode
% % activeReceiversAutonomousperBG=activeReceiversAutonomousSum;
% % activeReceiversAutonomousperBG=[activeReceiversAutonomousperBG,activeReceiversAutonomousSum];
% % activeReceiversAutonomousperBG(1)=activeReceiversAutonomousSum;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For generating graphs for the schedule mode in Cell1
graph1sched=0;
graph1sched(1,1)=tbg; 
save('graph1sched.mat','graph1sched');
% graph1sched=horzcat(graph1sched,tbg);
 
%%%%%%%%%%%%%%%%%%%%%For exporting metric values to the excel files in the
%%%%%%%%%%%%%%%%%%%%%"scheduled mode"; we comment these lines in the reuse
%%%%%%%%%%%%%%%%%%%%%mode
% filename = '/Users/toor/Desktop/Script_Files/Matlab/D2D/extended version5RANDC2/Numericals-norateadjustment/deliveryratio-simulation-numericals-inter-intra-extension.csv';
% %xlswrite(filename,graph1sched,'AA2:AA2');
% csvwrite(filename,graph1sched);

%the following line is for calculating the "Spectral Efficiency" metric
%se=0;
%instead of "lines" in the following equation which is the number of utilized resources,
%to be imported from Mathematica (in the reuse mode), here for the
%scheduled mode, we use the "numberOfBG" as the number of used resources.
%In this case, the spectrum efficiency is equal to the delivery ratio
% MySubsets = dlmread('DisjointIndependentSubsets.txt');
% mysetsize=size(MySubsets);
% lines=mysetsize(1,1);
% se=(numberOfBG*graph1sched)/numberOfBG;
% se=horzcat(se,se);
% filename = '/Users/toor/Desktop/Script_Files/Matlab/D2D/extended version5RANDC2/Numericals-norateadjustment/efficiency-simulation-numericals-inter-intra-extension.csv';
% %xlswrite(filename,se,'P2:P2');
% csvwrite(filename,se);
 
 %%%%%%%%%%%%%%%%%%%%%
 
% graph2sched=0;
% graph2sched(1,1)=tbg;
% graph2sched=horzcat(graph2sched,tbg);
% graph3sched=0;
% graph3sched(1,1)=tbg;
% graph3sched=horzcat(graph3sched,tbg);
% graph4sched=0;
% graph4sched(1,1)=tbg;
% graph4sched=horzcat(graph4sched,tbg);
% graph5sched=0;
% graph5sched(1,1)=tbg;
% graph5sched=horzcat(graph5sched,tbg);


% graph11sched=0;
% graph11sched(1,1)=tbg;
% graph11sched=horzcat(graph11sched,tbg);
% graph12sched=0;
% graph12sched(1,1)=tbg;
% graph12sched=horzcat(graph12sched,tbg);
% graph13sched=0;
% graph13sched(1,1)=tbg;
% graph13sched=horzcat(graph13sched,tbg);
% graph14sched=0;
% graph14sched(1,1)=tbg;
% graph14sched=horzcat(graph14sched,tbg);
% graph15sched=0;
% graph15sched(1,1)=tbg;
% graph15sched=horzcat(graph15sched,tbg);

%%%%%%%%%%%%%We comment these 3 lines for the reuse mode and uncomment for
%%%%%%%%%%%%%the scheduled mode
  activeReceiversScheduledperBG=activeReceiversScheduledSum;
  activeReceiversScheduledperBG=[activeReceiversScheduledperBG,activeReceiversScheduledSum];
  activeReceiversScheduledperBG(1)=activeReceiversScheduledSum;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------------------------------
%-----------------------------------Graphs---------------------------------
%--------------------------------------------------------------------------


% subplot(1, 2, 2);
% figure(2);
% plot(contWastedRBtransmission);
% axis([0 225 0 12])
% title('Interference by D2D Users')
% xlabel('Time')
% ylabel('# of wasted RBs')
% set(gca,'XTick',[1 75 150 225] );
% set(gca,'XTickLabel',[0 5 10 15] );
% figure(3);
% plot(contWRBCellular);
% axis([0 225 0 12])
% title('Interference by Cellular Users')
% xlabel('Time')
% ylabel('# of wasted RBs')
% set(gca,'XTick',[1 75 150 225] );
% set(gca,'XTickLabel',[0 5 10 15] );
% figure(4);
% plot(contIntraCellInterf);
% axis([0 15 0 160])
% title('In Conflict BG')
% xlabel('Time')
% ylabel('# of in conflict BGs')
% set(gca,'YTick',[0 80 160] );
% set(gca,'YTickLabel',[0 2 3] );
% set(gca,'XTick',[1 5 10 15] );
% set(gca,'XTickLabel',[0 5 10 15] );
% figure(5);
% plot(successful);
% axis([0 225 0 12])
% title('Successfuly alocated RBs')
% xlabel('Time')
% ylabel('# of allocated RBs')
% set(gca,'XTick',[1 75 150 225] );
% set(gca,'XTickLabel',[0 5 10 15] );
% set(gca,'YTick',[1 4 8 12] );
% set(gca,'YTickLabel',[1 4 8 12] );
% figure(6);
% plot(average1);
% % axis([1 10 0 5])
% title('Resource Efficiency')
% xlabel('BGs')
% ylabel('Resource Efficiency')
% set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11] );
% set(gca,'XTickLabel',[0 1 2 3 4 5 6 7 8 9 10] );
% set(gca,'YTick',[1 2 3 4 5 6 7 8 9 10] );
% set(gca,'YTickLabel',[1 2 3 4 5 6 7 8 9 10] );
% 
% subplot(1,2,1);
% surf(average2);
% title('BG')
% subplot(1,2,2);
% surf(totalnMessage);
% title('Success rate per BG')
% 
% receiverInterfautonomous

%the following for loop is to generate the average bit error ratio; note
%that for the first 4 BGs that we have the scheduled mode, we need to
%use"bigReceptionMatrixSched2", for the rest we use "bigReceptionMatrixAuto2"

% % %   final=0;
% % %   finaltemp1=0;
% % %   finaltemp2=0;
% % % for i=1:numberOfBG;
% % %     temp=sum(bigReceptionMatrixAuto2(i,:)==0)/(numberOfPackets*numberOfReceivers);
% % %     finaltemp1=horzcat(finaltemp1,temp);
% % % end;

% % % finaltemp2=mean(finaltemp1);
% % % final=finaltemp2;
% % % %final=horzcat(final,finaltemp2);
% % % save('final.mat','final');


end %this is for the argument function

