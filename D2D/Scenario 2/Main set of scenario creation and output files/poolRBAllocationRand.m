
%---------------------Resource Block Allocation Intelligent Reuse mechanism---------------------------%
%Determine the users, total number of subframes, and use a random
%order for resource block allocation for each SCPeriod in order to create
%more reallistic scenarios.
%--------------------------------------------------------------------------

bitmapCell1reuse = bitmPool((randi([37 106],1)),:);
bitmapCell2reuse = bitmPool((randi([37 106],1)),:);
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/myvariables.mat','xSRB','newLCRBCell1','LCRBdefaultCell1','nrResourcesTotalCell1','LI')

nrofbm = scPeriod/8; %this gives the # of bitmaps per scPeriod. 
maxTBperScperiod = nrofbm;%Given each bitmap has 4 on bits and the fact that each TB is transmitted 4 times, we conclude that in each bitmap a single TB is transmitted. So, the # of bitmaps in a scperiod, is in fact the MAX number of TBs that can be sent in one scperiod.

%Now, we create the required part of the table 7.1.7.2.1.1, to be used,
%upon need for determining the MCS index. We saved it as a text file and
%then imported it as a matrix here
myTable1 = dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/TableRBTBS.txt');

%note that "newLCRBCell1" is always 5 for random allocation. We look at the relevant column
%(=newLCRBCell1) of "myTable1" and choose the minimum TBS (i.e. the
%storngest MCS); If with such a selection, we can fit the message within 1
%SCPeriod, it's fine; Otherwise, we'll increase it gratually in order to
%find the right match.

newLCRBCell1 = 5;%always 5 for random allocation.

for i=2:16; % 16 belongs to the TBS Index=14 in myTable1    
     TBS = myTable1(i,newLCRBCell1+1);% "+1" here is just to skip the first column (TBS index) of the table in counting
     if 8000/TBS<= maxTBperScperiod;%8000 bits (1000 byte) is the size of message;here we try to find the smallest TBS (i.e. strongest MCS) 
        numberOfPackets=ceil(8000/TBS);
        TBSIndex = myTable1(i,1);% to save the TBS index value 
        break
     end;
end;

%we also read the table TBS to MCS index (for PUSCH), in order to find the MCS index
%corresponding to the TBS index that we found above.
myTable2 = dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/TableTBSMCS.txt');
   
MCSIndex = myTable2(TBSIndex+1,3);% to save the MCS index value 
Qm = myTable2(TBSIndex+1,2);% to save the Qm (modulation order) value; Qm is the number of bits per RE (resource element)

%from Qm, we can find the modulation scheme (we have saved them in a table and we read from it)
myTable3 = dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/TableQmMod.txt');
for i=1:4;
    if myTable3(i,1)==Qm;
       modulation = myTable3(i,2);% in the second column of myTable3: "1:QPSK", "16:16QAM", "64:64QAM", "256:256QAM" 
    end;
end;


RE = 2*7*12*newLCRBCell1*0.9;
%note that we consider no coding; just modulation
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/MCSBLERSINR.mat','modulation','MCSIndex','Qm','RE')


load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBG.mat','numberOfBG')
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBGC2.mat','numberOfBGC2')
load('numberOfReceivers.mat','numberOfReceivers')%doesn't matter from which path to lada as always 10
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BGC1.mat','BGC1')

nBGreuseCell1=randperm(numberOfBG);%number of broadcast groups in Cell1

nRBpSFCell1 = 10;%we consider constant number of resources in Call 1 & Cell2; so, we don't care about LI and LIth levels.
nRBpSFCell2 = 10;%we consider constant number of resources in Call 1 & Cell2; so, we don't care about LI and LIth levels.
nBGreuseCell2=randperm(numberOfBGC2);%number of broadcast groups in Cell2

packetLevelMatrixauto=zeros(numberOfBG,numberOfPackets);
packet=1;
nmess=1;%not needed?no
numberOfMessage=1;

numberOfPackReceiver1=zeros(1,numberOfBG);%each matrix shows the packet-level condition for receiver "x" of all BGs. we can change here the number of receivers.
numberOfPackReceiver2=zeros(1,numberOfBG);
numberOfPackReceiver3=zeros(1,numberOfBG);
numberOfPackReceiver4=zeros(1,numberOfBG);
numberOfPackReceiver5=zeros(1,numberOfBG);
numberOfPackReceiver6=zeros(1,numberOfBG);
numberOfPackReceiver7=zeros(1,numberOfBG);
numberOfPackReceiver8=zeros(1,numberOfBG);
numberOfPackReceiver9=zeros(1,numberOfBG);
numberOfPackReceiver10=zeros(1,numberOfBG);

numberOfMessageReceiver1=zeros(1,numberOfBG);%each matrix shows the message-level condition for receiver "x" of all BGs. we can change here the number of receivers.
numberOfMessageReceiver2=zeros(1,numberOfBG);
numberOfMessageReceiver3=zeros(1,numberOfBG);
numberOfMessageReceiver4=zeros(1,numberOfBG);
numberOfMessageReceiver5=zeros(1,numberOfBG);
numberOfMessageReceiver6=zeros(1,numberOfBG);
numberOfMessageReceiver7=zeros(1,numberOfBG);
numberOfMessageReceiver8=zeros(1,numberOfBG);
numberOfMessageReceiver9=zeros(1,numberOfBG);
numberOfMessageReceiver10=zeros(1,numberOfBG);


%Create the resource block matrix (box) for cell 1 and 2. In case "nRBpSFCell1" & "nRBpSFCell2" are not the same, they will have different
%first dimensions and this causes problem in later calculations (for inter-cell interference check)! for this, we use "kron" to adjust the sizes of two boxes
%"autonomousRBCell1" & "autonomousRBCell2", such that they both have "50" RBs.
%This means that, we expand each row element(SRB) of these matrices, by the size
%of "LCRB". For example, if "LCRB=5" (like in the default case that we
%considered), each SRB contains 5 RBs; So, we expand each SRB to its 5RBs.
%Doing that for both cells, they would have equal dimensions and the
%calculations would be ok. So, at first, we fill in the matrices,
%separately for Cell1 and Cell2 and then if "nRBpSFCell1" & "nRBpSFCell2"
%are not equal, we do the expansion.

autonomousRBCell1 = zeros(nRBpSFCell1,length(bitmapCell1reuse),20);%temporarily set to 30 instead of 20, just for test purpose
autonomousRBCell2 = zeros(nRBpSFCell2,length(bitmapCell2reuse),20);%temporarily set to 30 instead of 20, just for test purpose

%Execution for 1 message
 for countMsgraph=0:(numberOfPackets-1);
 %Repeat every 120 ms or 1 SCPeriod: note that in the new version we only
 %have 1 SCPeriod
     if mod(countMsgraph,scPeriod)==0;
contIntraC=0;
contIntraCell2=0;
autonomousRBCell1 = zeros(nRBpSFCell1,length(bitmapCell1reuse),20);%temporarily set to 30 instead of 20, just for test purpose
autonomousRBCell2 = zeros(nRBpSFCell2,length(bitmapCell2reuse),20);%temporarily set to 30 instead of 20, just for test purpose
receiverInterfRand=ones(numberOfBG,numberOfReceivers); %note that in the previosu version it was "ones" instead of "zeros", because before we considered all receivers successfull by default (having the packet "1"), and in case of interference and SINR lower than the threshold, we set their value to "0", but now the elements of this matrix show the BLER, so by defualt we consider all receivers successful by putting "0" for their BLER value.
        
%---------------------------Cell1-----------------------------------------%
        %Allocate the BG
        nBGautonomous=randperm(numberOfBG);
        resblock=[1,2,9,10];%# of RB that can be assigned. can this be variable?yes.
        bitmapCell1reuse = bitmPool((randi([37 106],1)),:);
        %assign randomly a resource block to each BG (they can be repeated)
        brodg1autonomous=resblock(randi([1 4],1));
        brodg2autonomous=resblock(randi([1 4],1));
        brodg3autonomous=resblock(randi([1 4],1));
        brodg4autonomous=resblock(randi([1 4],1));
        brodg5autonomous=resblock(randi([1 4],1));
        brodg6autonomous=resblock(randi([1 4],1));
        brodg7autonomous=resblock(randi([1 4],1));
        brodg8autonomous=resblock(randi([1 4],1));
        brodg9autonomous=resblock(randi([1 4],1));
        brodg10autonomous=resblock(randi([1 4],1));
        brodg11autonomous=resblock(randi([1 4],1));
        brodg12autonomous=resblock(randi([1 4],1));
        brodg13autonomous=resblock(randi([1 4],1));
        brodg14autonomous=resblock(randi([1 4],1));
        brodg15autonomous=resblock(randi([1 4],1));
        brodg16autonomous=resblock(randi([1 4],1));
        brodg17autonomous=resblock(randi([1 4],1));
        brodg18autonomous=resblock(randi([1 4],1));
        brodg19autonomous=resblock(randi([1 4],1));
        brodg20autonomous=resblock(randi([1 4],1));
        brodgAutonomous=[brodg1autonomous,brodg2autonomous,brodg3autonomous,brodg4autonomous,brodg5autonomous,brodg6autonomous,brodg7autonomous,brodg8autonomous,brodg9autonomous,brodg10autonomous,brodg11autonomous,brodg12autonomous,brodg13autonomous,brodg14autonomous,brodg15autonomous,brodg16autonomous,brodg17autonomous,brodg18autonomous,brodg19autonomous,brodg20autonomous];
              

        for a=1:length(bitmapCell1reuse);
            %Fill the first resource blocks with D2D users
            for b=1:nRBpSFCell1;
                for c=1:numberOfBG;
                    if bitmapCell1reuse(a) == 1;
                        if b<=2 || b>=9;
                            if nBGautonomous(c)==1;
                                autonomousRBCell1(brodg1autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==2;
                                autonomousRBCell1(brodg2autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==3;
                                autonomousRBCell1(brodg3autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==4;
                                autonomousRBCell1(brodg4autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==5;
                                autonomousRBCell1(brodg5autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==6;
                                autonomousRBCell1(brodg6autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==7;
                                autonomousRBCell1(brodg7autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==8;
                                autonomousRBCell1(brodg8autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==9;
                                autonomousRBCell1(brodg9autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==10;
                                autonomousRBCell1(brodg10autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==11;
                                autonomousRBCell1(brodg11autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==12;
                                autonomousRBCell1(brodg12autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==13;
                                autonomousRBCell1(brodg13autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==14;
                                autonomousRBCell1(brodg14autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==15;
                                autonomousRBCell1(brodg15autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==16;
                                autonomousRBCell1(brodg16autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==17;
                                autonomousRBCell1(brodg17autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==18;
                                autonomousRBCell1(brodg18autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==19;
                                autonomousRBCell1(brodg19autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                            if nBGautonomous(c)==20;
                                autonomousRBCell1(brodg20autonomous,a,nBGautonomous(c))= nBGautonomous(c);
                            end;
                        end;
                    end;
                end;
            end;
        end;
      
        
   autonomousRBCell1     
 %---------------------------Cell2-----------------------------------------%
        
        nBGreuse=randperm(numberOfBGC2);
        resblockCell2=[1,2,9,10]; %# of RB that can be assigned
        %assign randomly a resource block to each BG (they can be repeated)
        brodg1autonomousCell2=resblockCell2(randi([1 4],1));
        brodg2autonomousCell2=resblockCell2(randi([1 4],1));
        brodg3autonomousCell2=resblockCell2(randi([1 4],1));
        brodg4autonomousCell2=resblockCell2(randi([1 4],1));
        brodg5autonomousCell2=resblockCell2(randi([1 4],1));
        brodg6autonomousCell2=resblockCell2(randi([1 4],1));
        brodg7autonomousCell2=resblockCell2(randi([1 4],1));
        brodg8autonomousCell2=resblockCell2(randi([1 4],1));
        brodg9autonomousCell2=resblockCell2(randi([1 4],1));
        brodg10autonomousCell2=resblockCell2(randi([1 4],1));
        brodg11autonomousCell2=resblockCell2(randi([1 4],1));
        brodg12autonomousCell2=resblockCell2(randi([1 4],1));
        brodg13autonomousCell2=resblockCell2(randi([1 4],1));
        brodg14autonomousCell2=resblockCell2(randi([1 4],1));
        brodg15autonomousCell2=resblockCell2(randi([1 4],1));
        brodg16autonomousCell2=resblockCell2(randi([1 4],1));
        brodg17autonomousCell2=resblockCell2(randi([1 4],1));
        brodg18autonomousCell2=resblockCell2(randi([1 4],1));
        brodg19autonomousCell2=resblockCell2(randi([1 4],1));
        brodg20autonomousCell2=resblockCell2(randi([1 4],1));
        bitmapCell2reuse = bitmPool((randi([37 106],1)),:);
        for a=1:length(bitmapCell2reuse);
            %Fill the first resource blocks with D2D users
            for b=1:nRBpSFCell2;
                for c=1:numberOfBGC2;
                    if bitmapCell2reuse(a)== 1;
                        if b<=2 || b>=9;
                            if nBGreuse(c)==1;
                                autonomousRBCell2(brodg1autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==2;
                                autonomousRBCell2(brodg2autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==3;
                                autonomousRBCell2(brodg3autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==4;
                                autonomousRBCell2(brodg4autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==5;
                                autonomousRBCell2(brodg5autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==6;
                                autonomousRBCell2(brodg6autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==7;
                                autonomousRBCell2(brodg7autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==8;
                                autonomousRBCell2(brodg8autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==9;
                                autonomousRBCell2(brodg9autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==10;
                                autonomousRBCell2(brodg10autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                                                     
                             if nBGreuse(c)==11;
                                autonomousRBCell2(brodg1autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==12;
                                autonomousRBCell2(brodg2autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==13;
                                autonomousRBCell2(brodg3autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==14;
                                autonomousRBCell2(brodg4autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==15;
                                autonomousRBCell2(brodg5autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==16;
                                autonomousRBCell2(brodg6autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==17;
                                autonomousRBCell2(brodg7autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==18;
                                autonomousRBCell2(brodg8autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==19;
                                autonomousRBCell2(brodg9autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                            if nBGreuse(c)==20;
                                autonomousRBCell2(brodg10autonomousCell2,a,nBGreuse(c))= nBGreuse(c);
                            end;
                       
                        end;
                    end;
                end;
            end;
        end;

  autonomousRBCell2
  
%--------------Check if there is any INTRA cell interference (maybe, no longer would be needed for extended code)---------------
poolIntraCellRand; 

%"contIntraC" is the output from this file. this file must be changed, according to the extension! 
%Actually, this file maybe no longer needed for extended version of the code, 
%since due to intelligent resource allocation, there would be no more
%intra-cel interference. However, may be due to topology limitation we have to populate independent subsets with 
%left over isolated elements and these subsets would be no longer
%independent. In such a case, we may have intra-cell interference.

contIntraCellInterfgraph=horzcat(contIntraCellInterfgraph, contIntraC);
        
     end; %of Repeat every 120 ms or 1 SCPeriod
        
  %Repeat every 8ms or every bitmap for CUEs
    if mod(countMsgraph,8)==0;
        for bt=1:8;
            for sf=1:nRBpSFCell2;%I've chenged to nRBpSF from 10!
                %erase cellular users for reallocation
                if autonomousRBCell2(sf,bt)~=1;
                    autonomousRBCell2(sf,bt)=0;
                end;
            end;
        end;
        %every 8ms
        contCUsersAlloc=contCUsersAlloc+1;
        cellularRBMatrixgraph = zeros(nRBpSFCell2,8);%I've chenged to nRBpSF from 10!
        cont=0;
        idCellUser=21;
        bitInd=1;
        %Cellular user's matrix
        for f=1:length(bitmapCell2reuse);
            for g=1:nRBpSFCell2;
                %Create positions for CUE in the matrix
                %if the current bit in the bitmap is 0, it means we have
                %all RBs from 1 to 10 available for x
                if bitmapCell2reuse(bitInd)== 0;
                    coorx=randi([1 10],1,10);
                    coory=randi([1 8],1,8);
                    %otherwise if bitmap 1, x from 3 to 10
                else
                    coorx=randi([3 8],1,10);
                    coory=randi([1 8],1,8);
                end;
                bitInd=bitInd+1;
                if cont<numberOfCellularUsersCell2;
                    if autonomousRBCell2(coorx(1),coory(1),1)== 0;
                         %unused RB's can be for cellular users.
                        autonomousRBCell2(coorx(1),coory(1),1)=idCellUser;
                        %copy the id in the same position of the separate cellularRBMatrix
                        cellularRBMatrixgraph(coorx(1),coory(1))=idCellUser;
                        cont=cont+1;
                        idCellUser=idCellUser+1;
                    end;
                end;
                bitInd=1;
            end;
        end;
        
        
        poolInterCellRand; %commented out for single-cell
        %scenario
          
    end; %of Repeat every 8ms or every bitmap for CUEs
  
        
    
    %The following "for" loop is changed accroding to extension.
    for rb=1:nRBpSFCell1;%I've chenged to nRBpSFCell1 from 10!
        for f=1:8;
            if autonomousRBCell1(rb,f,1)==1;
                packetLevelMatrixauto(1,packet)=1;
            end;
            if autonomousRBCell1(rb,f,2)==2;
                packetLevelMatrixauto(2,packet)=1;
            end;
            if autonomousRBCell1(rb,f,3)==3;
                packetLevelMatrixauto(3,packet)=1;
            end;
            if autonomousRBCell1(rb,f,4)==4;
                packetLevelMatrixauto(4,packet)=1;
            end;
            if autonomousRBCell1(rb,f,5)==5;
                packetLevelMatrixauto(5,packet)=1;
            end;
            if autonomousRBCell1(rb,f,6)==6;
                packetLevelMatrixauto(6,packet)=1;
            end;
            if autonomousRBCell1(rb,f,7)==7;
                packetLevelMatrixauto(7,packet)=1;
            end;
            if autonomousRBCell1(rb,f,8)==8;
                packetLevelMatrixauto(8,packet)=1;
            end;
            if autonomousRBCell1(rb,f,9)==9;
                packetLevelMatrixauto(9,packet)=1;
            end;
            if autonomousRBCell1(rb,f,10)==10;
                packetLevelMatrixauto(10,packet)=1;
            end;
            if autonomousRBCell1(rb,f,11)==11;
                packetLevelMatrixauto(11,packet)=1;
            end;
            if autonomousRBCell1(rb,f,12)==12;
                packetLevelMatrixauto(12,packet)=1;
            end;
            if autonomousRBCell1(rb,f,13)==13;
                packetLevelMatrixauto(13,packet)=1;
            end;
            if autonomousRBCell1(rb,f,14)==14;
                packetLevelMatrixauto(14,packet)=1;
            end;
            if autonomousRBCell1(rb,f,15)==15;
                packetLevelMatrixauto(15,packet)=1;
            end;
            if autonomousRBCell1(rb,f,16)==16;
                packetLevelMatrixauto(16,packet)=1;
            end;
            if autonomousRBCell1(rb,f,17)==17;
                packetLevelMatrixauto(17,packet)=1;
            end;
            if autonomousRBCell1(rb,f,18)==18;
                packetLevelMatrixauto(18,packet)=1;
            end;
            if autonomousRBCell1(rb,f,19)==19;
                packetLevelMatrixauto(19,packet)=1;
            end;
            if autonomousRBCell1(rb,f,20)==20;
                packetLevelMatrixauto(20,packet)=1;
            end;
       end;
    end;
    packet=packet+1;
    
    %Create the big Matrix for all the allocations (Cell 1=D2D)(Cell2=D2D + Cellular)
    bigMatrixCell1autonomous=horzcat(bigMatrixCell1autonomous, autonomousRBCell1);
    %Note that we put expanded matrix "autonomousRBCell2new", instead of
    %the previous matrix "autonomousRBCell2"
    bigMatrixCell2autonomous=horzcat(bigMatrixCell2autonomous, autonomousRBCell2);         
    bigReceptionMatrixAuto2=horzcat(bigReceptionMatrixAuto2,receiverInterfRand);

  end; %of execution for one message
 
  
  autonomousRBCell1;
  
  packetLevelMatrixauto;
  bigReceptionMatrixAuto2;

numpack=0;
numpack2=0;
numpack3=0;
numpack4=0;
numpack5=0;
numpack6=0;
numpack7=0;
numpack8=0;
numpack9=0;
numpack10=0;


%--------------------------------------------------------------------------
%-HERE THE CALCULATIONS FOR THE PACKETS AND MESSAGES PER RECEIVER ARE DONE-
%--------------------------------------------------------------------------
%note that in the new version, we no longer need the following for loop
for nbgroup=1:numberOfBG;
    for pcktreceiver=1:length(bigReceptionMatrixAuto2);%All packets of each BG (nbgroup): example:10(receivers)*15(packet/message)*100(messages)
        if mod(pcktreceiver,10)==1;%to spot the position of all the packets of receiver "1" of BG:nbgroup. note that "10" must be changed based on the nr of receivers!
            numpack=numpack+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;%the matrix bigReceptionMatrixAuto2 is filled after interference check
                numberOfPackReceiver1(1,nbgroup)=numberOfPackReceiver1(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack,numberOfPackets)==0);%the condition for this "if" changes after the neccessary number of iterations for the above "for" loop.
            if(numberOfPackReceiver1(1,nbgroup)==numberOfPackets);
                numberOfMessageReceiver1(1,nbgroup)=numberOfMessageReceiver1(1,nbgroup)+1;
                numberOfPackReceiver1(1,nbgroup)=0;
            end;
        end; 
        if mod(pcktreceiver,10)==2;%to spot the position of all the packets of receiver "2" of BG:nbgroup 
            numpack2=numpack2+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver2(1,nbgroup)=numberOfPackReceiver2(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack2,numberOfPackets)==0)&&(numberOfPackReceiver2(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver2(1,nbgroup)=numberOfMessageReceiver2(1,nbgroup)+1;
            numberOfPackReceiver2(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==3;%to spot the position of all the packets of receiver "3" of BG:nbgroup 
            numpack3=numpack3+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver3(1,nbgroup)=numberOfPackReceiver3(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack3,numberOfPackets)==0)&&(numberOfPackReceiver3(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver3(1,nbgroup)=numberOfMessageReceiver3(1,nbgroup)+1;
            numberOfPackReceiver3(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==4;%to spot the position of all the packets of receiver "4" of BG:nbgroup
            numpack4=numpack4+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver4(1,nbgroup)=numberOfPackReceiver4(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack4,numberOfPackets)==0)&&(numberOfPackReceiver4(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver4(1,nbgroup)=numberOfMessageReceiver4(1,nbgroup)+1;
            numberOfPackReceiver4(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==5;%to spot the position of all the packets of receiver "5" of BG:nbgroup
            numpack5=numpack5+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver5(1,nbgroup)=numberOfPackReceiver5(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack5,numberOfPackets)==0)&&(numberOfPackReceiver5(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver5(1,nbgroup)=numberOfMessageReceiver5(1,nbgroup)+1;
            numberOfPackReceiver5(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==6;
            numpack6=numpack6+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver6(1,nbgroup)=numberOfPackReceiver6(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack6,numberOfPackets)==0)&&(numberOfPackReceiver6(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver6(1,nbgroup)=numberOfMessageReceiver6(1,nbgroup)+1;
            numberOfPackReceiver6(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==7;
            numpack7=numpack7+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver7(1,nbgroup)=numberOfPackReceiver7(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack7,numberOfPackets)==0)&&(numberOfPackReceiver7(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver7(1,nbgroup)=numberOfMessageReceiver7(1,nbgroup)+1;
            numberOfPackReceiver7(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==8;
            numpack8=numpack8+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver8(1,nbgroup)=numberOfPackReceiver8(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack8,numberOfPackets)==0)&&(numberOfPackReceiver8(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver8(1,nbgroup)=numberOfMessageReceiver8(1,nbgroup)+1;
            numberOfPackReceiver8(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==9;
            numpack9=numpack9+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver9(1,nbgroup)=numberOfPackReceiver9(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack9,numberOfPackets)==0)&&(numberOfPackReceiver9(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver9(1,nbgroup)=numberOfMessageReceiver9(1,nbgroup)+1;
            numberOfPackReceiver9(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==0;
            numpack10=numpack10+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver10(1,nbgroup)=numberOfPackReceiver10(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack10,numberOfPackets)==0)&&(numberOfPackReceiver10(1,nbgroup)==numberOfPackets);
            numberOfMessageReceiver10(1,nbgroup)=numberOfMessageReceiver10(1,nbgroup)+1;
            numberOfPackReceiver10(1,nbgroup)=0;
        end;
    end;
    numberOfMessage=1;
end;

%in the new version, we no longer need the following calculations; we only
%need to read the BLER from the "bigReceptionMatrixAuto2"

% %integrating all the output from the above big "for" loop
 totalnMessage=[numberOfMessageReceiver1;numberOfMessageReceiver2;numberOfMessageReceiver3;numberOfMessageReceiver4;numberOfMessageReceiver5;numberOfMessageReceiver6;numberOfMessageReceiver7;numberOfMessageReceiver8;numberOfMessageReceiver9;numberOfMessageReceiver10];

 totBG=mean(totalnMessage);%averaging the result of all receivers of each BGS (within each BG). for which BG? it is not specified?
 tbg=mean(totBG);%averaging the results of each BG (among all BGs)
 
 activeReceiversRand=receiverInterfRand;
 activeReceiversRandSum=sum(activeReceiversRand(:));

 %new parts for the new version
 AVGBLER = sum(BERunique(:))/numel(BERunique); %this is the average of all BLER(BER indeed) for all receivers of all BGs
 AVGBLERreal = sum(BLERreal(:))/10*numberOfBG; %this is the average of all BLERreal for all receivers of all BGs
 

        