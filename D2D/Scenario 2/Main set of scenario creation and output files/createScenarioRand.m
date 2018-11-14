function createScenarioRand(numberOfBG,scPeriod)

%Create the bitmap pool
bitmapPool

%Coordenates Cell 1
Cell1X = 3.5;
Cell1Y = 6;
Cell1R = 5;

load('numberOfReceivers.mat','numberOfReceivers')%always 10, no no problem in loading form various paths
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BGC1.mat','BGC1')
numberOfBG = size(BGC1,1) %we do this assignment here because of the batch mode running
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBG.mat','numberOfBG')
 %--------------------------------------------------------------------------%
 %------------------------------Extension part------------------------------%
 %--------------------------------------------------------------------------%

%Create empty receivers matrix
receiversT = zeros(numberOfBG,numberOfReceivers,2);

%note that in the following nested for loop, we change -+1 to -+0.5, in
%order to shrink the tx range of the BG and eventually decrease the
%experienced BLER by the receiver, in order to have better looking graphs.
for a=1:numberOfBG;
    %Create a matrix with X and Y for a given number of receivers per
    %broadcast group (Uniform distribution)
    for b=1:numberOfReceivers;
        receiversT(a,b,1)=unifrnd((BGC1(a,1)-2),(BGC1(a,1)+2));
        receiversT(a,b,2)=unifrnd((BGC1(a,2)-2),(BGC1(a,2)+2));
    end;
end;

save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/receiversT.mat','receiversT')

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
%numberOfBGC2=randi([15 20],1,1);
numberOfBGC2=numberOfBG;
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBGC2.mat','numberOfBGC2')
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

%I'll uniformly distribute the transmitters as well; 
% for a=1:numberOfBGC2;
%     %uniformly distribute transmitters
%         BGC2(a,1)=unifrnd((Cell2X-3),(Cell2X+3));
%         BGC2(a,2)=unifrnd((Cell2Y-3),(Cell2Y+3));
%         BGC2(a,3)=2;
% end;

%In order to make inter-cell and intra-cell interference difference more
%visible, I distribute BGC2s closer to the intersection of two cells as
%follows. here "Cell2X+3" has changed to "Cell2X+0" to keep BGs closer to
%Cell1.

for a=1:numberOfBGC2;
    %uniformly distribute transmitters
        BGC2(a,1)=unifrnd((Cell2X-3),(Cell2X+3));
        BGC2(a,2)=unifrnd((Cell2Y-3),(Cell2Y+3));
        BGC2(a,3)=2;
end;

save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BGC2.mat','BGC2')

for a=1:numberOfBGC2;
    %Create a matrix with X and Y for a given number of receivers per
    %broadcast group
    for b=1:numberOfReceiversCell2;
        receiversTCell2(a,b,1)=unifrnd((BGC2(a,1)-2),(BGC2(a,1)+2));
        receiversTCell2(a,b,2)=unifrnd((BGC2(a,2)-2),(BGC2(a,2)+2));
    end;
end;

save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/receiversTCell2.mat','receiversTCell2')


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

receiverInterfRand=ones(numberOfBG,numberOfReceivers);%not needed? it is used.
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


poolRBAllocationRand; 
         
  
average1=0;
average2=zeros(1,1500);
messageSurf=zeros(1,100);
messageSurf=vertcat(messageSurf,messageLevelMatrixauto);

%--------------------------------Final Graph 1-----------------------------

%this is for the BLER in the new version; exactly the same way as "graph1"
BLER1=0;
BLER1(1,1)=AVGBLER;
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BLER1.mat','BLER1')

%this is for BLERreal, as upposed to above which is indeed BER not BLER
BLERreal1=0;
BLERreal1(1,1)=AVGBLERreal;
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BLERreal1.mat','BLERreal1')

%We also save the RAW BLER (per receiver, not average) for the distance-based bin BLER graph
RAWBLER1=0;
RAWBLER1=BERunique;
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/RAWBLER1.mat','RAWBLER1')

%We also save the RAW BLERreal (per receiver, not average), as opposed to above which is BER indeed for the distance-based bin BLER graph
RAWBLERreal1=0;
RAWBLERreal1=BLERreal;
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/RAWBLERreal1.mat','RAWBLERreal1')

%the following line is for calculating the "Spectral Efficiency" metric
%note that in case of scheduled mode we don't need to calculate "se"
se=0;
lines=0;
templines=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For generating graphs for the schedule mode in Cell1
graph1sched=0;
graph1sched(1,1)=tbg; 
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/graph1sched.mat','graph1sched')
% graph1sched=horzcat(graph1sched,tbg);

%we consider RAWgraph1 for individual receiver-based delivery ratio measure
RAWgraph1sched=0;
RAWgraph1sched(1,1)=tbg;
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/RAWgraph1sched.mat','RAWgraph1sched')


%we consider also SINR
% % SINR=0;
% % SINR=SINRTotal;
% % save('SINR.mat','SINR');

%we consider also EbN0
EbN0=0;
EbN0=EbNo;
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/EbN0.mat','EbN0')

%in order to make the Modulation usage % graph, we defien the following
%matrix to save the modulation types; we have 1-20 BGs and 6 redundancy for
%each (20*6=120)
ModulationType=0;
ModulationType(1,1)=modulation;
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/ModulationType.mat','ModulationType')

  activeReceiversRandperBG=activeReceiversRandSum;
  activeReceiversRandperBG=[activeReceiversRandperBG,activeReceiversRandSum];
  activeReceiversRandperBG(1)=activeReceiversRandSum;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end %this is for the argument function

