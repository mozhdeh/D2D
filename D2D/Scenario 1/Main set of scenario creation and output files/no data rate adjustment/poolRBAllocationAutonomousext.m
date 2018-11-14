%---------------------Resource Block Allocation Autonomous---------------------------%
%Determine the users, total number of subframes (50/10), and use a random
%order for resource block allocation for each SCPeriod in order to create
%more reallistic scenarios.
%--------------------------------------------------------------------------
%------------------FOR CHANGING THE MESSAGE SIZE---------------------------
numberOfPackets=1500;
messizeinpackets=15;
%--------------------------------------------------------------------------
%------------------FOR CHANGING THE SC-PERIOD------------------------------
scPeriod=120;
%--------------------------------------------------------------------------

bitmapCell1autonomous = bitmPool((randi([37 106],1)),:);
bitmapCell2autonomous = bitmPool((randi([37 106],1)),:);
nRBpSF = 10;%number of resource blocks per subframe. can it be variable too?yes.
%numberOfBG=10;
nBGautonomous=randperm(numberOfBG);%number of broadcast groups
nRBpSFCell2 = 10;
nBGCell2graph=randperm(numberOfBG);%why this has a non-matching name?it can be changed.in files for shceduled mode it is named correctly.
packetLevelMatrixauto=zeros(numberOfBG,numberOfPackets);
packet=1;
nmess=1;%not needed?no
numberOfMessage=1;

numberOfPackReceiver1=zeros(1,numberOfBG);%each matrix shows receiver "x" of all BGs. we can change here the number of receivers.
numberOfPackReceiver2=zeros(1,numberOfBG);
numberOfPackReceiver3=zeros(1,numberOfBG);
numberOfPackReceiver4=zeros(1,numberOfBG);
numberOfPackReceiver5=zeros(1,numberOfBG);
numberOfPackReceiver6=zeros(1,numberOfBG);
numberOfPackReceiver7=zeros(1,numberOfBG);
numberOfPackReceiver8=zeros(1,numberOfBG);
numberOfPackReceiver9=zeros(1,numberOfBG);
numberOfPackReceiver10=zeros(1,numberOfBG);

numberOfMessageReceiver1=zeros(1,numberOfBG);%each matrix shows receiver "x" of all BGs. we can change here the number of receivers.
numberOfMessageReceiver2=zeros(1,numberOfBG);
numberOfMessageReceiver3=zeros(1,numberOfBG);
numberOfMessageReceiver4=zeros(1,numberOfBG);
numberOfMessageReceiver5=zeros(1,numberOfBG);
numberOfMessageReceiver6=zeros(1,numberOfBG);
numberOfMessageReceiver7=zeros(1,numberOfBG);
numberOfMessageReceiver8=zeros(1,numberOfBG);
numberOfMessageReceiver9=zeros(1,numberOfBG);
numberOfMessageReceiver10=zeros(1,numberOfBG);


%Create the resource block matrix for cell 1 and 2
autonomousRBCell1 = zeros(nRBpSF,length(bitmapCell1autonomous),10);%we create the matrix with the size of max. nr of BGs. but we can use as many as we need.
autonomousRBCell2 = zeros(nRBpSFCell2,length(bitmapCell2autonomous),10);

%Execution for 1 message
for countMsgraph=0:(numberOfPackets-1);
    %Repeat every 120 ms or 1 SCPeriod
    if mod(countMsgraph,scPeriod)==0;
        contIntraC=0;
        contIntraCell2=0;
        autonomousRBCell1 = zeros(nRBpSF,length(bitmapCell1autonomous),10);%we create the matrix with the size of max. nr of BGs. but we can use as many as we need.
        autonomousRBCell2 = zeros(nRBpSFCell2,length(bitmapCell2autonomous),10);%we create the matrix with the size of max. nr of BGs. but we can use as many as we need.
        receiverInterfautonomous=ones(numberOfBG,numberOfReceivers);
        
        %---------------------------Cell1-----------------------------------------%
        %Allocate the BG
        nBGautonomous=randperm(numberOfBG);
        resblock=[1,2,9,10];%# of RB that can be assigned. can this be variable?yes.
        bitmapCell1autonomous = bitmPool((randi([37 106],1)),:);
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
        brodgAutonomous=[brodg1autonomous,brodg2autonomous,brodg3autonomous,brodg4autonomous,brodg5autonomous,brodg6autonomous,brodg7autonomous,brodg8autonomous,brodg9autonomous,brodg10autonomous];
        
        for a=1:length(bitmapCell1autonomous);
            %Fill the first resource blocks with D2D users
            for b=1:nRBpSF;
                for c=1:numberOfBG;
                    if bitmapCell1autonomous(a) == 1;
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
                        end;
                    end;
                end;
            end;
        end;
        
        %---------------------------Cell2-----------------------------------------%
        
        nBGCell2graph=randperm(numberOfBG);
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
        bitmapCell2autonomous = bitmPool((randi([37 106],1)),:);
        for a=1:length(bitmapCell2autonomous);
            %Fill the first resource blocks with D2D users
            for b=1:nRBpSFCell2;
                for c=1:numberOfBG;
                    if bitmapCell2autonomous(a)== 1;
                        if b<=2 || b>=9;
                            if nBGCell2graph(c)==1;
                                autonomousRBCell2(brodg1autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==2;
                                autonomousRBCell2(brodg2autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==3;
                                autonomousRBCell2(brodg3autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==4;
                                autonomousRBCell2(brodg4autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==5;
                                autonomousRBCell2(brodg5autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==6;
                                autonomousRBCell2(brodg6autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==7;
                                autonomousRBCell2(brodg7autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==8;
                                autonomousRBCell2(brodg8autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==9;
                                autonomousRBCell2(brodg9autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                            if nBGCell2graph(c)==10;
                                autonomousRBCell2(brodg10autonomousCell2,a,nBGCell2graph(c))= nBGCell2graph(c);
                            end;
                        end;
                    end;
                end;
            end;
        end;
        %Erase the 4th bg as we only want 3 (with 4 there will be an error
        %in the program because currently the calculations are done for 3)
        %         for col=1:length(bitmapCell1graph);
        %             for line=1:nRBpSF;
        %                 if graphRB(line,col)==4;
        %                     graphRB(line,col)=0;
        %                 end;
        %                 if graphRBCell2(line,col)==4;
        %                     graphRBCell2(line,col)=0;
        %                 end;
        %             end;
        %         end;
        
        %Create the matrix with all the bitmaps
        bigBitmapCell1autonomous=horzcat(bigBitmapCell1autonomous, bitmapCell1autonomous);%not needed?
        bigBitmapCell2autonomous=horzcat(bigBitmapCell2autonomous, bitmapCell2autonomous);%not needed?
        
        %--------------Check if there is any INTRA cell interference---------------
        poolIntraCellAutonomousext;%"contIntraC" is the output from this file
        contIntraCellInterfgraph=horzcat(contIntraCellInterfgraph, contIntraC);
    end;
    
    %Repeat every 8ms or every bitmap
    if mod(countMsgraph,8)==0;
        for bt=1:8;
            for sf=1:nRBpSF;%I've chenged to nRBpSF from 10!
                %erase cellular users for reallocation
                if autonomousRBCell2(sf,bt)~=1;
                    autonomousRBCell2(sf,bt)=0;
                end;
            end;
        end;
        %every 8ms
        contCUsersAlloc=contCUsersAlloc+1;
        cellularRBMatrixgraph = zeros(nRBpSF,8);%I've chenged to nRBpSF from 10!
        cont=0;
        idCellUser=21;
        bitInd=1;
        %Cellular user's matrix
        for f=1:length(bitmapCell2autonomous);
            for g=1:nRBpSF;
                %Create positions for CUE in the matrix
                %if the current bit in the bitmap is 0, it means we have
                %all RBs from 1 to 10 available for x
                if bitmapCell2autonomous(bitInd)== 0;
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
       %Execute a script where it is determined if there's any overlapping
        %taking into account the transmitters from cell 1
        %with transmitters from cell 2 and also receivers from cell 1 with transmitters from cell2. Regarding the RB's allocated. 
        %this is for inter-cell interference check.
        
        
        %first save the RB allocation box of the cell1 in another box
        %autonomousRBOverlap. this avoids wrong occupation of zeroed (wasted)
        %RBs, as a result of interference check, by cellular users.
        autonomousRBOverlap=autonomousRBCell1;
        %this script checks inter-cell interference
        poolInterCellAutonomousext;
        
        
    end;
    
    for superrb=1:nRBpSF;%I've chenged to nRBpSF from 10!
        for bm=1:8;
            if autonomousRBCell1(superrb,bm,1)==1;
                packetLevelMatrixauto(1,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,2)==2;
                packetLevelMatrixauto(2,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,3)==3;
                packetLevelMatrixauto(3,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,4)==4;
                packetLevelMatrixauto(4,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,5)==5;
                packetLevelMatrixauto(5,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,6)==6;
                packetLevelMatrixauto(6,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,7)==7;
                packetLevelMatrixauto(7,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,8)==8;
                packetLevelMatrixauto(8,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,9)==9;
                packetLevelMatrixauto(9,packet)=1;
            end;
            if autonomousRBCell1(superrb,bm,10)==10;
                packetLevelMatrixauto(10,packet)=1;
            end;
        end;
    end;
    packet=packet+1;
    
    %Create the big Matrix for all the allocations (Cell 1=D2D)(Cell2=D2D + Cellular)
    bigMatrixCell1autonomous=horzcat(bigMatrixCell1autonomous, autonomousRBOverlap);
    bigMatrixCell2autonomous=horzcat(bigMatrixCell2autonomous, autonomousRBCell2);
         
    bigReceptionMatrixAuto2=horzcat(bigReceptionMatrixAuto2,receiverInterfautonomous);
    
    
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
    for pcktreceiver=1:length(bigReceptionMatrixAuto2);%All packets of each BG (nbgroup): example:10(receivers)*15(packet/message)*100(messages)
        if mod(pcktreceiver,10)==1;%to spot the position of all the packets of receiver "1" of BG:nbgroup. note that "10" must be changed based on the nr of receivers!
            numpack=numpack+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;%the matrix bigReceptionMatrixAuto2 is filled after interference check
                numberOfPackReceiver1(1,nbgroup)=numberOfPackReceiver1(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack,messizeinpackets)==0);%the condition for this "if" changes after the neccessary number of iterations for the above "for" loop.
            if(numberOfPackReceiver1(1,nbgroup)==messizeinpackets);
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
        if (mod(numpack2,messizeinpackets)==0)&&(numberOfPackReceiver2(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver2(1,nbgroup)=numberOfMessageReceiver2(1,nbgroup)+1;
            numberOfPackReceiver2(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==3;%to spot the position of all the packets of receiver "3" of BG:nbgroup 
            numpack3=numpack3+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver3(1,nbgroup)=numberOfPackReceiver3(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack3,messizeinpackets)==0)&&(numberOfPackReceiver3(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver3(1,nbgroup)=numberOfMessageReceiver3(1,nbgroup)+1;
            numberOfPackReceiver3(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==4;%to spot the position of all the packets of receiver "4" of BG:nbgroup
            numpack4=numpack4+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver4(1,nbgroup)=numberOfPackReceiver4(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack4,messizeinpackets)==0)&&(numberOfPackReceiver4(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver4(1,nbgroup)=numberOfMessageReceiver4(1,nbgroup)+1;
            numberOfPackReceiver4(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==5;%to spot the position of all the packets of receiver "5" of BG:nbgroup
            numpack5=numpack5+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver5(1,nbgroup)=numberOfPackReceiver5(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack5,messizeinpackets)==0)&&(numberOfPackReceiver5(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver5(1,nbgroup)=numberOfMessageReceiver5(1,nbgroup)+1;
            numberOfPackReceiver5(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==6;
            numpack6=numpack6+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver6(1,nbgroup)=numberOfPackReceiver6(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack6,messizeinpackets)==0)&&(numberOfPackReceiver6(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver6(1,nbgroup)=numberOfMessageReceiver6(1,nbgroup)+1;
            numberOfPackReceiver6(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==7;
            numpack7=numpack7+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver7(1,nbgroup)=numberOfPackReceiver7(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack7,messizeinpackets)==0)&&(numberOfPackReceiver7(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver7(1,nbgroup)=numberOfMessageReceiver7(1,nbgroup)+1;
            numberOfPackReceiver7(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==8;
            numpack8=numpack8+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver8(1,nbgroup)=numberOfPackReceiver8(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack8,messizeinpackets)==0)&&(numberOfPackReceiver8(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver8(1,nbgroup)=numberOfMessageReceiver8(1,nbgroup)+1;
            numberOfPackReceiver8(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==9;
            numpack9=numpack9+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver9(1,nbgroup)=numberOfPackReceiver9(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack9,messizeinpackets)==0)&&(numberOfPackReceiver9(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver9(1,nbgroup)=numberOfMessageReceiver9(1,nbgroup)+1;
            numberOfPackReceiver9(1,nbgroup)=0;
        end;
        if mod(pcktreceiver,10)==0;
            numpack10=numpack10+1;
            if bigReceptionMatrixAuto2(nbgroup,pcktreceiver)==1;
                numberOfPackReceiver10(1,nbgroup)=numberOfPackReceiver10(1,nbgroup)+1;
            end;
        end;
        if (mod(numpack10,messizeinpackets)==0)&&(numberOfPackReceiver10(1,nbgroup)==messizeinpackets);
            numberOfMessageReceiver10(1,nbgroup)=numberOfMessageReceiver10(1,nbgroup)+1;
            numberOfPackReceiver10(1,nbgroup)=0;
        end;
    end;
    numberOfMessage=1;
end;

%integrating all the output from the above big "for" loop
totalnMessage=[numberOfMessageReceiver1;numberOfMessageReceiver2;numberOfMessageReceiver3;numberOfMessageReceiver4;numberOfMessageReceiver5;numberOfMessageReceiver6;numberOfMessageReceiver7;numberOfMessageReceiver8;numberOfMessageReceiver9;numberOfMessageReceiver10];

totBG=mean(totalnMessage);%averaging the result of all receivers of each BGS (within each BG). for whic hBG? it is not specified?
tbg=mean(totBG);%averaging the results of each BG (among all BGs)

activeReceiversAutonomous=receiverInterfautonomous;
activeReceiversAutonomousSum=sum(activeReceiversAutonomous(:));



