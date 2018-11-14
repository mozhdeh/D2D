
%Here we load the "BGC1"
load('BGC1Coordinates.mat','BGC1')

%Create 3 transmitters (Broadcast groups) (X & Y parameters and radius)
%inside the cell 1
%numberOfBG = 6; %--------------------CHANGE NUMBER OF BG'S----------------
load('numberOfBG.mat','numberOfBG')
load('numberOfBGC2.mat','numberOfBGC2')
load('numberOfReceivers.mat','numberOfReceivers')
%numberOfReceivers = 10;
%---------------------Resource Block Allocation---------------------------%
%Determine the users, total number of subframes (50/10), and use a random
%order for resource block allocation for each SCPeriod in order to create
%more reallistic scenarios.
%--------------------------------------------------------------------------
%------------------FOR CHANGING THE MESSAGE SIZE---------------------------
%messizeinpackets=15;
numberOfPackets= messizeinpackets*100; %note that I've changed the number of messages from 100 to 10, to have shorter running time
%--------------------------------------------------------------------------
%------------------FOR CHANGING THE SC PERIOD------------------------------
%scPeriod=40;
%--------------------------------------------------------------------------
bitmapCell1scheduled = bitmPool((randi([37 106],1)),:);
bitmapCell2reuse = bitmPool((randi([37 106],1)),:);
nRBpSF = 10; %number of resource blocks per subframe
nBGscheduled=randperm(numberOfBG); %number of broadcast groups (the 4th is deleted later for execution)
nRBpSFCell2 = 10;
nBGScheduledCell2=randperm(numberOfBGC2);
packet=1;
nmess=1;
%Create the packet level Matrix
packetLevelMatrix=zeros(numberOfBG,numberOfPackets);
numberOfMessage=1;

%--------------------------------------------------------------------------
%------------------VECTORS FOR AMOUNT OF RECEIVED PACKETS------------------

numberOfPackReceiver1=zeros(1,numberOfBG);
numberOfPackReceiver2=zeros(1,numberOfBG);
numberOfPackReceiver3=zeros(1,numberOfBG);
numberOfPackReceiver4=zeros(1,numberOfBG);
numberOfPackReceiver5=zeros(1,numberOfBG);
numberOfPackReceiver6=zeros(1,numberOfBG);
numberOfPackReceiver7=zeros(1,numberOfBG);
numberOfPackReceiver8=zeros(1,numberOfBG);
numberOfPackReceiver9=zeros(1,numberOfBG);
numberOfPackReceiver10=zeros(1,numberOfBG);

%--------------------------------------------------------------------------
%------------------VECTORS FOR AMOUNT OF RECEIVED MESSAGES-----------------

numberOfMessageReceiver1=zeros(1,numberOfBG);
numberOfMessageReceiver2=zeros(1,numberOfBG);
numberOfMessageReceiver3=zeros(1,numberOfBG);
numberOfMessageReceiver4=zeros(1,numberOfBG);
numberOfMessageReceiver5=zeros(1,numberOfBG);
numberOfMessageReceiver6=zeros(1,numberOfBG);
numberOfMessageReceiver7=zeros(1,numberOfBG);
numberOfMessageReceiver8=zeros(1,numberOfBG);
numberOfMessageReceiver9=zeros(1,numberOfBG);
numberOfMessageReceiver10=zeros(1,numberOfBG);



%Create the resource block matrix for cell 1 and 2; note that we consider
%the scheduled mode, only for Cell1; hence, for Cell2 we still have
%3Dmatrix(i.e. the autonomous mode)
scheduledRBCell1 = zeros(nRBpSF,length(bitmapCell1scheduled));
autonomousRBCell2 = zeros(nRBpSFCell2,length(bitmapCell2reuse),numberOfBGC2);

%Execution for 1 message
for countMs=0:(numberOfPackets-1);
    %Repeat every 120 ms or 1 SCPeriod
    if mod(countMs,scPeriod)==0;
        scheduledRBCell1 = zeros(nRBpSF,length(bitmapCell1scheduled));
        autonomousRBCell2 = zeros(nRBpSFCell2,length(bitmapCell2reuse),numberOfBGC2);
        receiverInterfScheduled=ones(numberOfBG,numberOfReceivers);
        contSCPeriods=contSCPeriods+1;
        %---------------------------Cell1-----------------------------------------%
        %Allocate the BG
        nBGscheduled=randperm(numberOfBG);
        resblock=[1,2,9,10];%# of RB that can be assigned
        msize = numel(resblock);
        resblockmix=resblock(randperm(msize, msize));
        %We put a mini for loop here to assume each of these RBs to the
        %first RB number of elements in nBGscheduled
        brodgscheduledCell1=zeros(1,length(resblockmix));
        for z=1:length(resblockmix);
            brodgscheduledCell1(1,z)=resblockmix(1,z);
        end;
        
%         brodg1scheduledCell1=resblock(randi([1 4],1));
%         brodg2scheduledCell1=resblock(randi([1 4],1));
%         brodg3scheduledCell1=resblock(randi([1 4],1));
%         brodg4scheduledCell1=resblock(randi([1 4],1));
%         brodg5scheduledCell1=resblock(randi([1 4],1));
%         brodg6scheduledCell1=resblock(randi([1 4],1));
%         brodg7scheduledCell1=resblock(randi([1 4],1));
%         brodg8scheduledCell1=resblock(randi([1 4],1));
%         brodg9scheduledCell1=resblock(randi([1 4],1));
%         brodg10scheduledCell1=resblock(randi([1 4],1));
        
        bitmapCell1scheduled = bitmPool((randi([37 106],1)),:);
        
        for a=1:length(bitmapCell1scheduled);
            %Fill the first resource blocks with D2D users
            for b=1:nRBpSF;
                if numberOfBG<length(resblockmix);%this mini for loop specifies the range of iterator "c" in the next "for" loop, based on the fact that #BG is less than resources or not
                   decided=numberOfBG;
                else
                   decided=length(resblockmix); 
                end;
                for c=1:decided;%Here instead of "nr of BG" we put "length(resblockmix)" to avoid misoccupation of RBs by extra BGs
                    if bitmapCell1scheduled(a) == 1;
                        if b<=2 || b>=9;
                            if nBGscheduled(c)==1;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==2;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==3;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==4;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==5;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==6;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==7;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==8;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==9;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                            if nBGscheduled(c)==10;
                                scheduledRBCell1(brodgscheduledCell1(1,c),a)= nBGscheduled(c);
                            end;
                        end;
                    end;
                end;
            end;
        end;
        
        
 %Here, we do justification in Cell1, with "newLCRBCell1=5";For the
 %scheduled mode, we do it only to compare it with the matrix for Cell2,
 %during inter-cell interference calculation
 newLCRBCell1=5;
            %for k=1:numberOfBG;
                e=ones(newLCRBCell1,1);
                Bee=kron(scheduledRBCell1,e);
            %end;
            
            scheduledRBCell1new=Bee;
            dedRBOverlap=scheduledRBCell1new;
        
 %In Cell2 we don't do intelligent resource allocation; Hence, we keep the
 %previous random allocation scheme as follows
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
                        end;
                    end;
                end;
            end;
        end;
        
        
        
        %Create the matrix with all the bitmaps
        bigBitmapCell1=horzcat(bigBitmapCell1, bitmapCell1scheduled);
        bigBitmapCell2=horzcat(bigBitmapCell2, bitmapCell2reuse);
    end;
    
    %Repeat every 8ms or every bitmap
    if mod(countMs,8)==0;
        for bt=1:8;
            for sf=1:10;
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
        
        
               
         %justification in Cell2, with "newLCRBCell1=5", which is always the
            %same for Cell2
            for k=1:numberOfBGC2;
                f=ones(newLCRBCell1,1);
                temp2=kron(autonomousRBCell2(:,:,k),f);
                Cee(:,:,k)=temp2;
            end;
            autonomousRBCell2new=Cee;
            %we also expand the "cellularRBMatrixgraph" matrix, in order to
            %be compatible with other expanded matrices. this is needed for
            %later calculations
            cellularRBMatrixgraphnew=kron(cellularRBMatrixgraph,ones(newLCRBCell1,1));
        
        
        %Execute a script where it is determined if there's any overlapping
        %taking into account the transmitters from cell 1 between them, receivers from cell 1
        %with transmitters from cell 2. Regarding the RB's allocated.
        
        %dedRBOverlap=scheduledRBCell1;
        poolInterCellScheduledext;
        
    end;
    
     %The following "for" loop is changed according to extension.
     nRBpSFCell1new=50;
    for rb=1:newLCRBCell1:nRBpSFCell1new;%I've chenged to nRBpSFCell1new from 10!
        for bm=1:8;
            if scheduledRBCell1new(rb,bm)==1;
                packetLevelMatrixsched(1,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==2;
                packetLevelMatrixsched(2,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==3;
                packetLevelMatrixsched(3,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==4;
                packetLevelMatrixsched(4,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==5;
                packetLevelMatrixsched(5,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==6;
                packetLevelMatrixsched(6,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==7;
                packetLevelMatrixsched(7,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==8;
                packetLevelMatrixsched(8,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==9;
                packetLevelMatrixsched(9,packet)=1;
            end;
            if scheduledRBCell1new(rb,bm)==10;
                packetLevelMatrixsched(10,packet)=1;
            end;
        end;
    end;
    packet=packet+1;
    
    %Create the big Matrix for all the allocations (Cell 1=D2D)(Cell2=D2D + Cellular)
    bigMatrixCell1=horzcat(bigMatrixCell1, dedRBOverlap);
    bigMatrixCell2=horzcat(bigMatrixCell2, autonomousRBCell2new);
    
    %Count successfuly allocated RB's
    contSuc=0;
    
    for azk=1:8;
        for azk2=1:length(dedRBOverlap);
            if (dedRBOverlap(azk2,azk)==1)||(dedRBOverlap(azk2,azk)==2)||(dedRBOverlap(azk2,azk)==3);
                contSuc=contSuc+1;
            end;
        end;
    end;
    
    successful=[successful contSuc];
    
    bigReceptionMatrixSched2=horzcat(bigReceptionMatrixSched2,receiverInterfScheduled);
    
end;


cntpckt=0;
counterpackets=0;
contemptypckt=0;
suma=0;
messnumber=1;

%Create the Message level Matrix
for brodg=1:numberOfBG;
    for pckt=1:numberOfPackets;
        if packetLevelMatrixsched(brodg,pckt)==1;
            cntpckt=cntpckt+1;
        end;
        if mod(pckt,messizeinpackets)==0;
            if cntpckt==messizeinpackets;
                messageLevelMatrixsched(brodg,messnumber)=1;
                cntpckt=0;
            else
                messageLevelMatrixsched(brodg,messnumber)=2;
                cntpckt=0;
            end;
            messnumber=messnumber+1;
        end;
        counterpackets=counterpackets+1;
    end;
    messnumber=1;
end;

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

for nbgroup=1:numberOfBG;
    for pcktreceiver=1:length(bigReceptionMatrixSched2);
        if mod(pcktreceiver,10)==1;
            numpack=numpack+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver1(1,nbgroup)=numberOfPackReceiver1(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack,messizeinpackets)==0);
            if(numberOfPackReceiver1(1,nbgroup)==messizeinpackets);
%                 if scheduledRBCell1(brodg1scheduledCell1,1)==1||scheduledRBCell1(brodg1scheduledCell1,2)==1||scheduledRBCell1(brodg1scheduledCell1,3)==1||scheduledRBCell1(brodg1scheduledCell1,4)==1||scheduledRBCell1(brodg1scheduledCell1,5)==1||scheduledRBCell1(brodg1scheduledCell1,6)==1||scheduledRBCell1(brodg1scheduledCell1,7)==1||scheduledRBCell1(brodg1scheduledCell1,8)==1;
                    numberOfMessageReceiver1(1,nbgroup)=numberOfMessageReceiver1(1,nbgroup)+1;
%                 end;
                numberOfPackReceiver1(1,nbgroup)=0;
            end;
        end;
        if mod(pcktreceiver,10)==2;
            numpack2=numpack2+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver2(1,nbgroup)=numberOfPackReceiver2(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack2,messizeinpackets)==0)&&(numberOfPackReceiver2(1,nbgroup)==messizeinpackets);
%             if scheduledRBCell1(brodg2scheduledCell1,1)==2||scheduledRBCell1(brodg2scheduledCell1,2)==2||scheduledRBCell1(brodg2scheduledCell1,3)==2||scheduledRBCell1(brodg2scheduledCell1,4)==2||scheduledRBCell1(brodg2scheduledCell1,5)==2||scheduledRBCell1(brodg2scheduledCell1,6)==2||scheduledRBCell1(brodg2scheduledCell1,7)==2||scheduledRBCell1(brodg2scheduledCell1,8)==2;
                numberOfMessageReceiver2(1,nbgroup)=numberOfMessageReceiver2(1,nbgroup)+1;
%             end;
            numberOfPackReceiver2(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==3;
            numpack3=numpack3+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver3(1,nbgroup)=numberOfPackReceiver3(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack3,messizeinpackets)==0)&&(numberOfPackReceiver3(1,nbgroup)==messizeinpackets);
%             if scheduledRBCell1(brodg3scheduledCell1,1)==3||scheduledRBCell1(brodg3scheduledCell1,2)==3||scheduledRBCell1(brodg3scheduledCell1,3)==3||scheduledRBCell1(brodg3scheduledCell1,4)==3||scheduledRBCell1(brodg3scheduledCell1,5)==3||scheduledRBCell1(brodg3scheduledCell1,6)==3||scheduledRBCell1(brodg3scheduledCell1,7)==3||scheduledRBCell1(brodg3scheduledCell1,8)==3;
                numberOfMessageReceiver3(1,nbgroup)=numberOfMessageReceiver3(1,nbgroup)+1;
%             end;
            numberOfPackReceiver3(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==4;
            numpack4=numpack4+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver4(1,nbgroup)=numberOfPackReceiver4(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack4,messizeinpackets)==0)&&(numberOfPackReceiver4(1,nbgroup)==messizeinpackets);
%             if scheduledRBCell1(brodg4scheduledCell1,1)==4||scheduledRBCell1(brodg4scheduledCell1,2)==4||scheduledRBCell1(brodg4scheduledCell1,3)==4||scheduledRBCell1(brodg4scheduledCell1,4)==4||scheduledRBCell1(brodg4scheduledCell1,5)==4||scheduledRBCell1(brodg4scheduledCell1,6)==4||scheduledRBCell1(brodg4scheduledCell1,7)==4||scheduledRBCell1(brodg4scheduledCell1,8)==4;
                numberOfMessageReceiver4(1,nbgroup)=numberOfMessageReceiver4(1,nbgroup)+1;
%             end;
            numberOfPackReceiver4(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==5;
            numpack5=numpack5+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver5(1,nbgroup)=numberOfPackReceiver5(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack5,messizeinpackets)==0)&&(numberOfPackReceiver5(1,nbgroup)==messizeinpackets);
%            if scheduledRBCell1(brodg5scheduledCell1,1)==5||scheduledRBCell1(brodg5scheduledCell1,2)==5||scheduledRBCell1(brodg5scheduledCell1,3)==5||scheduledRBCell1(brodg5scheduledCell1,4)==5||scheduledRBCell1(brodg5scheduledCell1,5)==5||scheduledRBCell1(brodg5scheduledCell1,6)==5||scheduledRBCell1(brodg5scheduledCell1,7)==5||scheduledRBCell1(brodg5scheduledCell1,8)==5;
                numberOfMessageReceiver5(1,nbgroup)=numberOfMessageReceiver5(1,nbgroup)+1;
%             end;
            numberOfPackReceiver5(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==6;
            numpack6=numpack6+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver6(1,nbgroup)=numberOfPackReceiver6(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack6,messizeinpackets)==0)&&(numberOfPackReceiver6(1,nbgroup)==messizeinpackets);
%             if scheduledRBCell1(brodg6scheduledCell1,1)==6||scheduledRBCell1(brodg6scheduledCell1,2)==6||scheduledRBCell1(brodg6scheduledCell1,3)==6||scheduledRBCell1(brodg6scheduledCell1,4)==6||scheduledRBCell1(brodg6scheduledCell1,5)==6||scheduledRBCell1(brodg6scheduledCell1,6)==6||scheduledRBCell1(brodg6scheduledCell1,7)==6||scheduledRBCell1(brodg6scheduledCell1,8)==6;
                numberOfMessageReceiver6(1,nbgroup)=numberOfMessageReceiver6(1,nbgroup)+1;
%             end;
            numberOfPackReceiver6(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==7;
            numpack7=numpack7+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver7(1,nbgroup)=numberOfPackReceiver7(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack7,messizeinpackets)==0)&&(numberOfPackReceiver7(1,nbgroup)==messizeinpackets);
%             if scheduledRBCell1(brodg7scheduledCell1,1)==7||scheduledRBCell1(brodg7scheduledCell1,2)==7||scheduledRBCell1(brodg7scheduledCell1,3)==7||scheduledRBCell1(brodg7scheduledCell1,4)==7||scheduledRBCell1(brodg7scheduledCell1,5)==7||scheduledRBCell1(brodg7scheduledCell1,6)==7||scheduledRBCell1(brodg7scheduledCell1,7)==7||scheduledRBCell1(brodg7scheduledCell1,8)==7;
                numberOfMessageReceiver7(1,nbgroup)=numberOfMessageReceiver7(1,nbgroup)+1;
%             end;
            numberOfPackReceiver7(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==8;
            numpack8=numpack8+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver8(1,nbgroup)=numberOfPackReceiver8(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack8,messizeinpackets)==0)&&(numberOfPackReceiver8(1,nbgroup)==messizeinpackets);
%             if scheduledRBCell1(brodg8scheduledCell1,1)==8||scheduledRBCell1(brodg8scheduledCell1,2)==8||scheduledRBCell1(brodg8scheduledCell1,3)==8||scheduledRBCell1(brodg8scheduledCell1,4)==8||scheduledRBCell1(brodg8scheduledCell1,5)==8||scheduledRBCell1(brodg8scheduledCell1,6)==8||scheduledRBCell1(brodg8scheduledCell1,7)==8||scheduledRBCell1(brodg8scheduledCell1,8)==8;
                numberOfMessageReceiver8(1,nbgroup)=numberOfMessageReceiver8(1,nbgroup)+1;
%             end;
            numberOfPackReceiver8(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==9;
            numpack9=numpack9+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver9(1,nbgroup)=numberOfPackReceiver9(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack9,messizeinpackets)==0)&&(numberOfPackReceiver9(1,nbgroup)==messizeinpackets);
%             if scheduledRBCell1(brodg9scheduledCell1,1)==9||scheduledRBCell1(brodg9scheduledCell1,2)==9||scheduledRBCell1(brodg9scheduledCell1,3)==9||scheduledRBCell1(brodg9scheduledCell1,4)==9||scheduledRBCell1(brodg9scheduledCell1,5)==9||scheduledRBCell1(brodg9scheduledCell1,6)==9||scheduledRBCell1(brodg9scheduledCell1,7)==9||scheduledRBCell1(brodg9scheduledCell1,8)==9;
                numberOfMessageReceiver9(1,nbgroup)=numberOfMessageReceiver9(1,nbgroup)+1;
%             end;
            numberOfPackReceiver9(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==0;
            numpack10=numpack10+1;
            if bigReceptionMatrixSched2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver10(1,nbgroup)=numberOfPackReceiver10(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack10,messizeinpackets)==0)&&(numberOfPackReceiver10(1,nbgroup)==messizeinpackets);
%             if scheduledRBCell1(brodg10scheduledCell1,1)==10||scheduledRBCell1(brodg10scheduledCell1,2)==10||scheduledRBCell1(brodg10scheduledCell1,3)==10||scheduledRBCell1(brodg10scheduledCell1,4)==10||scheduledRBCell1(brodg10scheduledCell1,5)==10||scheduledRBCell1(brodg10scheduledCell1,6)==10||scheduledRBCell1(brodg10scheduledCell1,7)==10||scheduledRBCell1(brodg10scheduledCell1,8)==10;
                numberOfMessageReceiver10(1,nbgroup)=numberOfMessageReceiver10(1,nbgroup)+1;
%             end;
            numberOfPackReceiver10(1,nbgroup)=0;
        end;
    end;
    numberOfMessage=1;
end;

totalnMessage=[numberOfMessageReceiver1;numberOfMessageReceiver2;numberOfMessageReceiver3;numberOfMessageReceiver4;numberOfMessageReceiver5;numberOfMessageReceiver6;numberOfMessageReceiver7;numberOfMessageReceiver8;numberOfMessageReceiver9;numberOfMessageReceiver10];

totBG=mean(totalnMessage);
counterbgs=0;
activeReceiversScheduled=receiverInterfScheduled;

for brdg=1:numberOfBG;
    for btmm=1:length(bitmapCell1scheduled);
        for sbff=1:10;
            if scheduledRBCell1(sbff,btmm)~=brdg;
                counterbgs=counterbgs+1;
            end;
            if counterbgs==80;
                totBG(brdg)=0;
                activeReceiversScheduled(brdg,:)=0;
            end;
        end;
    end;
    counterbgs=0;
end;


activeReceiversScheduledSum=sum(activeReceiversScheduled(:));
tbg=mean(totBG);



