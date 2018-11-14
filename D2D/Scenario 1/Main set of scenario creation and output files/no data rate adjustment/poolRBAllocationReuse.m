
%---------------------Resource Block Allocation Intelligent Reuse mechanism---------------------------%
%Determine the users, total number of subframes, and use a random
%order for resource block allocation for each SCPeriod in order to create
%more reallistic scenarios.
%--------------------------------------------------------------------------
%------------------FOR CHANGING THE MESSAGE SIZE---------------------------
numberOfPackets= messizeinpackets*100;
%messizeinpackets=15;
%--------------------------------------------------------------------------
%------------------FOR CHANGING THE SC-PERIOD------------------------------
%scPeriod=40;%I've changed this from 120ms
%--------------------------------------------------------------------------

bitmapCell1reuse = bitmPool((randi([37 106],1)),:);
bitmapCell2reuse = bitmPool((randi([37 106],1)),:);


%--------------------------------------------------------------------------%
%------------------------------Extension part------------------------------%
%--------------------------------------------------------------------------%
%note that all these changes from the default setting, belongs to Cell1.
%That's why we put "Cell1" at the end of all the new adapted variables, in
%order not to mix things with Cell2.n
BW=50;
load('myvariables.mat')
%number of resource blocks per subframe. can it be variable too?yes.
nRBpSFCell1 = nrResourcesTotalCell1;
%round down "nRBpSF" to the nearest integer
nRBpSFCell1=floor(nRBpSFCell1);
%--------------------------------------------------------------------------%
%------------------------------Extension part------------------------------%
%--------------------------------------------------------------------------%

load('numberOfBG.mat','numberOfBG')
load('numberOfBGC2.mat','numberOfBGC2')
load('numberOfReceivers.mat','numberOfReceivers')
%numberOfBG=6; %I've changed this from "10", to generate result for #BG=6
nBGreuseCell1=randperm(numberOfBG);%number of broadcast groups in Cell1

nRBpSFCell2 = 10;%we consider constant number of resources in Cell2; so, we don't care about LI and LIth levels.
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
%"reuseRBCell1" & "autonomousRBCell2", such that they both have "50" RBs.
%This means that, we expand each row element(SRB) of these matrices, by the size
%of "LCRB". For example, if "LCRB=5" (like in the default case that we
%considered), each SRB contains 5 RBs; So, we expand each SRB to its 5RBs.
%Doing that for both cells, they would have equal dimensions and the
%calculations would be ok. So, at first, we fill in the matrices,
%separately for Cell1 and Cell2 and then if "nRBpSFCell1" & "nRBpSFCell2"
%are not equal, we do the expansion.

reuseRBCell1 = zeros(nRBpSFCell1,length(bitmapCell1reuse),20);
autonomousRBCell2 = zeros(nRBpSFCell2,length(bitmapCell2reuse),20);

%Execution for 1 message
 for countMsgraph=0:(numberOfPackets-1);
 %Repeat every 120 ms or 1 SCPeriod
     if mod(countMsgraph,scPeriod)==0;
contIntraC=0;
contIntraCell2=0;
reuseRBCell1 = zeros(nRBpSFCell1,length(bitmapCell1reuse),20);
autonomousRBCell2 = zeros(nRBpSFCell2,length(bitmapCell2reuse),20);
receiverInterfreuse=ones(numberOfBG,numberOfReceivers);
        
%---------------------------Cell1-----------------------------------------%
%Allocate the BG
nBGreuse=randperm(numberOfBG);
        
%--------------------------------------------------------------------------%
%------------------------------Extension part------------------------------%
%--------------------------------------------------------------------------%
%note that all these changes from the default setting, belongs to Cell1.
%That's why we put "Cell1" at the end of all the new adapted variables, in
%order not to mix things with Cell2.
 %create an empty "resblock" array of size 2*xSRB
 %first round down "xSRB" to the nearest integer
 xSRB=floor(xSRB);
 
 resblock1Cell1=zeros(1,xSRB); %first half of the "resblockCell1" matrix;%# of RB that can be assigned. can this be variable?yes, xSRB is variable.
 %now parameterize the array
 resblock1Cell1=1:xSRB;
 resblock2Cell1=zeros(1,xSRB); %second half of the "resblockCell1" matrix; this one starts after "xSRB" D2D resources + 6 CUE resources + 1 
 %now parameterize the array
 resblock2Cell1=xSRB+7:nRBpSFCell1;
 %now we concatenate "" & "" to make the single array.
 resblockCell1=horzcat(resblock1Cell1,resblock2Cell1);
 
 %we need to find the number of uncovered D2D RBs for later use during
 %justification, otherwise there would be dimensin mismatch 
 uncovered=20 - newLCRBCell1*(2*xSRB);
 %now at each side of D2D allocation (i.e. top & bottom) there would be
 %"uncovered/2" zero single RBs
 uncovered=uncovered/2;
 
 %take the nr of columns of "resblockCell1", as its size
 mysizeraw=size(resblockCell1);
 mysizeready=mysizeraw(1,2);

 bitmapCell1reuse = bitmPool((randi([37 106],1)),:);
 
 %assign intelligently (taking into account geographical distance) a
 %resource block to each BG (they can be repeated). For this, we import the text file "DisjointIndependentSubsets.txt" from Mathematica, altogether containing the list of all
 %possible disjoint sets of independent elements with size "LI". Each of
 %these sets has at least "LI" number of nodes that are not in each others coverage
 %(i.e. independent sets in the corresponding graph). 
 
 %At first, we create a matrix BGResourceMap(resblockCell1,1,LI+2) to save the
 %mapping between each of these disjoint sets and a RB as follows
 %we round up "LI" to the nearest integer first. The reason for considering
 %"LI+2" is that if there is any D2D transmitters left isolated (not in any
 %of the independent subsets generated in Mathematica), we have to add it
 %to one of the independent subsets (preferable to the subset that still can remain independent after adding this new extra isolated D2D transmitter). So, for this we need to have some
 %extra empty space (for example "2" extra space: LI+2) available at the "BGResourceMap".
 LI=ceil(LI);
 BGResourceMap=zeros(length(resblockCell1),1,numberOfBG+1);%Instead of LI+2 or LI+3, I've considered numberOfBG as the 3rd dimension to be sure that all fit, if needed
 
 %Here we "randperm" the indices(not the values) of "resblockCell1"
 %elements, because weo don't want repetition in selection of RBs
 randyindex=randperm(mysizeready);
 
 %First reading the text file "DisjointIndependentSubsets.txt"
 load('MySubsets.mat','MySubsets')
 mysetsize=size(MySubsets);
 lines=mysetsize(1,1);
 %Putting RBs in the "BGResourceMap" matrix. We take from "resblockCell1"
 %as many as we need, which is equal to "nrofIndependentSets"
 for fileline=1:lines;
     BGResourceMap(fileline,1,1)=resblockCell1(1,randyindex(1,fileline));
 end;
 
%Now, we put these disjoint sets in the matrix "BGResourceMap"
 for fileline=1:lines;
     for lineelement=1:mysetsize(1,2);
         if MySubsets(fileline,lineelement)~=0;
         BGResourceMap(fileline,1,lineelement+1)=MySubsets(fileline,lineelement);
         end;
     end;
 end;

%In this "for" loop, we transfer the content of "BGResourceMap" into
%"reuseRBCell1"
for a=1:length(bitmapCell1reuse);
            %Fill the resource blocks with D2D users
            for b=1:lines;%because of "lines" Arrays (disjoint sets)
                for c=2:numberOfBG+1;%Instead of nr. of BGs, now we have LI. must be corrected!
                    if bitmapCell1reuse(a) == 1;
                       if BGResourceMap(b,1,c)~=0;
                        reuseRBCell1(BGResourceMap(b,1,1),a,BGResourceMap(b,1,c))= BGResourceMap(b,1,c);
                       end;
                    end;
                end;
            end;
end;

%Here, we do justification in Cell1, with "newLCRBCell1"; note that due to the
%case of rate adaptation, we do justification separately for RBs for CUE
%and D2D users


if newLCRBCell1==LCRBdefaultCell1;%in case of no rate adaptation
   for k=1:20;%note that here instead of "numberOfBG", we put "20", in order to run the file in batch mode without need for commenting extra lines
       e=ones(newLCRBCell1,1);
       temp1=kron(reuseRBCell1(:,:,k),e);
       Bee(:,:,k)=temp1;
   end;
   reuseRBCell1new=Bee;
   autonomousRBOverlap=reuseRBCell1new; 
   
else %in case of a rate adaptation
   
   y=zeros(50,8); %temporary matrix for justification; 50 is the total nr of single RBs, resulted from justification
   z=zeros(50,8); %temporary matrix for justification
    
   for k=1:20;%note that here instead of "numberOfBG", we put "20", in order to run the file in batch mode without need for commenting extra lines
       for b=1:nRBpSFCell1;
            if b<=xSRB || b>=(xSRB+7);%justification for D2D RBs with the newLCRBCell1
               e=ones(newLCRBCell1,1);
               temp1=kron(reuseRBCell1(b,:,k),e); 
               
            else %justification for CUE RBs, with the LCRBdefaultCell1
               e=ones(LCRBdefaultCell1,1);
               temp1=kron(reuseRBCell1(b,:,k),e);
            end;
            
           y=vertcat(y,temp1);  
       end;
       
       thesize=size(y);
       if thesize(1,1)~=100; % this if checks if there is any uncovered single D2D RBs to be added to "y" before concatenation with "z"
           
          b=zeros(1,8);
          row_no=newLCRBCell1*(xSRB)+51; %insert for first uncovered
          y(1:row_no-1,:) = y(1:row_no-1,:);
          tp =y(row_no:end,:);
          y(row_no,:)=b;
          y(row_no+1:end+1,:) =tp;

          thissize=size(y);
          row_no=thissize(1,1)-(newLCRBCell1*(xSRB)); %insert for second uncovered

          y(1:row_no-1,:) = y(1:row_no-1,:);
          tp =y(row_no:end,:);
          y(row_no,:)=b;
          y(row_no+1:end+1,:) =tp;
       end;
       
       thesize=size(y);
       y=y(51:thesize(1,1),1:8);
       z=cat(3,y,z);
   end; 
   
   reuseRBCell1new=z;
   
   %we need to remove the last all zero page of "z" that was
       %initialized 
       reuseRBCell1new=reuseRBCell1new(:,:,1:numberOfBG);
       reuseRBCell1newreverse=zeros(50,8,numberOfBG);
       %since "cat" concatenates the pages in reverse, we do reverse one
       %more to have the right arrangement of pages in matrix "z" and for
       %this, we need a for loop
       num=0;
       for page=1:numberOfBG;
           reuseRBCell1newreverse(:,:,page)=reuseRBCell1new(:,:,numberOfBG-num);
           num=num+1;
       end;
   
  reuseRBCell1new=reuseRBCell1newreverse;
  autonomousRBOverlap=reuseRBCell1new; 
end;
           
    
 %--------------------------------------------------------------------------%
 %------------------------------Extension part------------------------------%
 %--------------------------------------------------------------------------%
 
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


        
        
%--------------Check if there is any INTRA cell interference (maybe, no longer would be needed for extended code)---------------
poolIntraCellAutonomousextRANGE; 

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
        
        %Execute a script where it is determined if there's any overlapping
        %taking into account the transmitters from cell 1
        %with transmitters from cell 2 and also receivers from cell 1 with transmitters from cell2. Regarding the RB's allocated. 
        %this is for inter-cell interference check.
        
        
        %first save the RB allocation box of the cell1 in another box
        %autonomousRBOverlap. this avoids wrong occupation of zeroed (wasted)
        %RBs, as a result of interference check, by cellular users.
        %autonomousRBOverlap=reuseRBCell1;
        
        %this script checks inter-cell interference
        %before running this script, the size justification that is
        %described earlier in this file regarding inequal "nRBpSFCell1" &
        %"nRBpSFCell2") must be done, as follows!
        
       
       % if nRBpSFCell1 ~= nRBpSFCell2;
            %justification in Cell1, with "newLCRBCell1";we did it earlier
            %in this file, so we comment it here
%             for k=1:numberOfBG;
%                 e=ones(newLCRBCell1,1);
%                 temp1=kron(reuseRBCell1(:,:,k),e);
%                 Bee(:,:,k)=temp1;
%             end;
%             reuseRBCell1new=Bee;
%             autonomousRBOverlap=reuseRBCell1new;
            

            %justification in Cell2, with "LCRBdefaultCell1", which is the
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
            cellularRBMatrixgraphnew=kron(cellularRBMatrixgraph,ones(LCRBdefaultCell1,1));
      %  end;
        
        poolInterCellAutonomousextTEST;
          
    end; %of Repeat every 8ms or every bitmap for CUEs
  
        
    
    %The following "for" loop is changed accroding to extension.
    for rb=1:newLCRBCell1:nRBpSFCell1new;%I've chenged to nRBpSFCell1new from 10!
        for f=1:8;
            if reuseRBCell1new(rb,f,1)==1;
                packetLevelMatrixauto(1,packet)=1;
            end;
            if reuseRBCell1new(rb,f,2)==2;
                packetLevelMatrixauto(2,packet)=1;
            end;
            if reuseRBCell1new(rb,f,3)==3;
                packetLevelMatrixauto(3,packet)=1;
            end;
            if reuseRBCell1new(rb,f,4)==4;
                packetLevelMatrixauto(4,packet)=1;
            end;
            if reuseRBCell1new(rb,f,5)==5;
                packetLevelMatrixauto(5,packet)=1;
            end;
            if reuseRBCell1new(rb,f,6)==6;
                packetLevelMatrixauto(6,packet)=1;
            end;
            if reuseRBCell1new(rb,f,7)==7;
                packetLevelMatrixauto(7,packet)=1;
            end;
            if reuseRBCell1new(rb,f,8)==8;
                packetLevelMatrixauto(8,packet)=1;
            end;
            if reuseRBCell1new(rb,f,9)==9;
                packetLevelMatrixauto(9,packet)=1;
            end;
            if reuseRBCell1new(rb,f,10)==10;
                packetLevelMatrixauto(10,packet)=1;
            end;
            if reuseRBCell1new(rb,f,11)==11;
                packetLevelMatrixauto(11,packet)=1;
            end;
            if reuseRBCell1new(rb,f,12)==12;
                packetLevelMatrixauto(12,packet)=1;
            end;
            if reuseRBCell1new(rb,f,13)==13;
                packetLevelMatrixauto(13,packet)=1;
            end;
            if reuseRBCell1new(rb,f,14)==14;
                packetLevelMatrixauto(14,packet)=1;
            end;
            if reuseRBCell1new(rb,f,15)==15;
                packetLevelMatrixauto(15,packet)=1;
            end;
            if reuseRBCell1new(rb,f,16)==16;
                packetLevelMatrixauto(16,packet)=1;
            end;
            if reuseRBCell1new(rb,f,17)==17;
                packetLevelMatrixauto(17,packet)=1;
            end;
            if reuseRBCell1new(rb,f,18)==18;
                packetLevelMatrixauto(18,packet)=1;
            end;
            if reuseRBCell1new(rb,f,19)==19;
                packetLevelMatrixauto(19,packet)=1;
            end;
            if reuseRBCell1new(rb,f,20)==20;
                packetLevelMatrixauto(20,packet)=1;
            end;
       end;
    end;
    packet=packet+1;
    
    %Create the big Matrix for all the allocations (Cell 1=D2D)(Cell2=D2D + Cellular)
    bigMatrixCell1autonomous=horzcat(bigMatrixCell1autonomous, autonomousRBOverlap);
    %Note that we put expanded matrix "autonomousRBCell2new", instead of
    %the previous matrix "autonomousRBCell2"
    bigMatrixCell2autonomous=horzcat(bigMatrixCell2autonomous, autonomousRBCell2new);         
    bigReceptionMatrixAuto2=horzcat(bigReceptionMatrixAuto2,receiverInterfreuse);

  end; %of execution for one message
 

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
totBG=mean(totalnMessage);%averaging the result of all receivers of each BGS (within each BG). for which BG? it is not specified?
tbg=mean(totBG);%averaging the results of each BG (among all BGs)

activeReceiversAutonomous=receiverInterfreuse;
activeReceiversAutonomousSum=sum(activeReceiversAutonomous(:));
        