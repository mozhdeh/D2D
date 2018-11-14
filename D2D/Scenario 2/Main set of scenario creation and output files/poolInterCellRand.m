%Due to the extension, now in this script we use "autonomousRBCell1" &
%"autonomousRBCell2" instead of "reuseRBCell1" & "autonomousRBCell2"
%Note that due to extension "autonomousRBCell1" &
%"autonomousRBCell2" have different first dimension (nRBpSFCell1new=50=BW) than "autonomousRBCell1"
%& "autonomousRBCell2" (nRBpSFCell1=10)
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBG.mat','numberOfBG')
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBGC2.mat','numberOfBGC2')

load('numberOfReceivers.mat','numberOfReceivers')%doesn't matter from which path to load, as always 10
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/IntranotDesiredPrMatrix.mat','IntranotDesiredPrMatrix')
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/MCSBLERSINR.mat','modulation','MCSIndex','Qm','RE')
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BGC1.mat','BGC1')

mysize=size(autonomousRBCell1);
nRBpSFCell1new=mysize(1,1);
%The same is valid for Cell2
nRBpSFCell2new=mysize(1,1);

%Here we create a matrix called "InternotDesiredPrMatrix" to save the
%calculated "sum(AllprNotDesiredAuto)" for each user of each BG; The reason
%is that we later need these values to be summed up with the corresponding
%values for "Intra-cell" and come up with the final level of not desired pr
%and accordingly calculate the final SINR for that particular receiver.
InternotDesiredPrMatrix=zeros(numberOfBG,numberOfReceivers);

%We create a corresponding matrix "totalnotDesiredPrMatrix" to save the intra & inter pr sums
totalnotDesiredPrMatrix=zeros(numberOfBG,numberOfReceivers);

%We define the following matrix to save the udesired pr caused by CUE to
%the D2D users in Cell1. we'll some the values in this matrix with the
%peer ones in "totalnotDesiredPrMatrix", in order to get the total undesiredpr
NotDesiredPrMatrixCUE=zeros(numberOfBG,numberOfReceivers);

%We define the "prDesiredAuto" matrix, in stead of just saving instantly
%its current value, because we need to use it in the last nested for loop of this file to calcualte BLERs
prDesiredAuto=zeros(numberOfBG,numberOfReceivers);

%Create overlapping Matrixes; is this needed?
overlappingMatgraph=zeros(numberOfBG,numberOfReceivers,2);

%Check intercell interference for all the broadcast groups in Cell1
        for c=1:length(bitmapCell1reuse);
             for d=1:nRBpSFCell1new;
                temp1=autonomousRBCell1(d,c,:);
                temp2=temp1(temp1~=0);
                nonzerosCell1=zeros(length(temp2),1);
                %Since "autonomousRBCell1" is a 3D matrix, "nonzerosCell1" is too;
                %So, we need to change this and save "nonzerosCell1" as an
                %ordinary 2D matrix
                for r=1:length(nonzerosCell1);
                    nonzerosCell1(r,1)=temp2(:,:,r);
                end;
                %Now, we get the "nonzerosCell2" the same way we did for
                %Cell1;
                temp3=autonomousRBCell2(d,c,:);             
                temp4=temp3(temp3~=0);
                temp4=temp4(temp4<=10);
                nonzerosCell2=zeros(length(temp4),1);
                %Since "autonomousRBCell2" is a 3D matrix, "nonzerosCell2" is too;
                %So, we need to change this and save "nonzerosCell1" as an
                %ordinary 2D matrix
                for r=1:length(nonzerosCell2);
                    nonzerosCell2(r,1)=temp4(:,:,r);
                end;
%Now what we do is to calculate SINR for receivers of each element in "nonzerosCell1" by
%taking into account the effect of all (together at once) elements in
%"nonzerosCell2". This will give us the total inter-cell SINR for that
%particular receiver, later to be summed up with the corresponding
%intra-cell one, calculated in file "poolIntraCellAutonomousext"

                for k=1:length(nonzerosCell1);
                    %Note that now "x" are located in Cell2
                    x=nonzerosCell2;
                    coordinatesx=zeros(length(x),2);
                    coordinatesy=BGC1(nonzerosCell1(k,1),1:2);
                    inranges=zeros(length(x),1);
                    
                    for z=1:length(x);
                        %Note that now "x" are located in Cell2
                        coordinatesx(z,:)=BGC2(x(z,1),1:2);
                        idx = rangesearch(coordinatesx(z,:),coordinatesy,2);
                        %accessing cell element
                        idx=idx{1,1};
                        if idx~=0;
                           inranges(z,1)=idx;
                        end;
                           inranges = inranges(inranges~=0);
                    end;
                       
                  
                  if inranges~=0;
                      %SINR calculation;in this case we have both sources
                      %of loss (distance+interfering sources)
                    for rece=1:numberOfReceivers;
                              
                            XtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),1)-receiversT(nonzerosCell1(k,1),rece,1));%?for distance measure between desired X_tx and X_receiver
                            YtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),2)-receiversT(nonzerosCell1(k,1),rece,2));%?for distance measure between desired Y_tx and Y_receiver
                            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
                            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
                            prDesiredAuto(nonzerosCell1(k,1),rece)=40-pathLossDesiredAuto;%what? pathloss=p_tx/p_rx; so this is to calculate p_rx; p_tx has changed from 30 to 40 for test purpose
                            
                            %the same distance measure for "all"
                            %non-desired ones in "inranges" in Cell2; for this we
                            %need a mini "for" loop. before, we create a
                            %matrix to save all the distances
                            inrangesDistances=zeros(length(inranges),1);
                            for e=1:length(inranges);
                                XtransreceiverNotDesiredAuto=abs(receiversT(nonzerosCell1(k,1),rece,1)-BGC2(inranges(e,1),1));
                                YtransreceiverNotDesiredAuto=abs(receiversT(nonzerosCell1(k,1),rece,2)-BGC2(inranges(e,1),2));
                                tangentNotDesiredAuto=sqrt((XtransreceiverNotDesiredAuto^2)+(YtransreceiverNotDesiredAuto^2));
                                inrangesDistances(e,1)=tangentNotDesiredAuto;
                            end;

                            
                            %Again here, we need a mini "for" loop to
                            %calculate "prNotDesiredAuto" for all the not
                            %desired ones in Cell2. Before, we crete a matrix to
                            %save all "prNotDesiredAuto"
                            AllprNotDesiredAuto=zeros(length(inranges),1);
                            for f=1:length(inranges);
                                pathLossNotDesiredAuto=148+40*log10(inrangesDistances(f,1));%km?yes
                                AllprNotDesiredAuto(f,1)=40-pathLossNotDesiredAuto; %p_tx has changed from 30 to 40 for test purpose
                            end;
                            
                            %Here we have the total not desired pr for each
                            %receiver of each BG, comming from BGs in Cell2
                            %(i.e. Inter-cell)
                            InternotDesiredPrMatrix(nonzerosCell1(k,1),rece)=sum(AllprNotDesiredAuto);
                            
                            %Here, we need to sum up the results for
                            %"IntranotDesiredPrMatrix" with the results for
                            %"InternotDesiredPrMatrix", in order to have
                            %the final pr for each receiver of each BG in
                            %Cell1 (intra-cell +inter-cell). 
                            totalnotDesiredPrMatrix(nonzerosCell1(k,1),rece)=InternotDesiredPrMatrix(nonzerosCell1(k,1),rece)+IntranotDesiredPrMatrix(nonzerosCell1(k,1),rece);                                                       
                    end; 
                  end; 
                end;
                
                
            %Check if there is any conflict with cellular users. no SINR
            %for CUE? we have changed also the dimension of
            %"cellularRBMatrixgraph" matrix from "10" to "50" and saved it as matrix "cellularRBMatrixgraph", to be
            %compatible with the extension. 
            
             for cusers=1:length(numberOfCellularUsersCell2);
                 if cellularUsersCell2(cusers,3)==cellularRBMatrixgraph(d,c);
                    ex=cellularUsersCell2(cusers,1);
                    yi=cellularUsersCell2(cusers,2);
                    
                 for numBGCell1=1:numberOfBG;
                     if (cellularRBMatrixgraph(d,c)~=0)&&(autonomousRBCell1(d,c,numBGCell1)~=0);
                         
                        coordinatesCUE=[ex yi];
                         %In the following line, I've considered 1(transmissino range of BG)+3(transmissino range of CUE)=4 as
                         %the in range limit for SINR calculation
                         idx = rangesearch(coordinatesCUE,BGC1(autonomousRBCell1(d,c,numBGCell1),1:2),4);
                         %accessing cell element
                         idx=idx{1,1};
                         if idx~=0;
                         %Now, we calculate SINR for all the receivers of
                         %the BG=numBGCell1
                         for rece=1:numberOfReceivers;
                            XtransreceiverDesiredAuto=abs(BGC1(autonomousRBCell1(d,c,numBGCell1),1)-receiversT(autonomousRBCell1(d,c,numBGCell1),rece,1));%?for distance measure between desired X_tx and X_receiver
                            YtransreceiverDesiredAuto=abs(BGC1(autonomousRBCell1(d,c,numBGCell1),2)-receiversT(autonomousRBCell1(d,c,numBGCell1),rece,2));%?for distance measure between desired Y_tx and Y_receiver
                            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
                            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
                            prDesiredAuto(autonomousRBCell1(d,c,numBGCell1),rece)=40-pathLossDesiredAuto;%what? pathloss=p_tx/p_rx; so this is to calculate p_rx; p_tx has changed from 30 to 40 for test purpose
                            
                            %the same distance measure for the single
                            %non-desired CUE which is inrange; 

                                XtransreceiverNotDesiredAuto=abs(receiversT(autonomousRBCell1(d,c,numBGCell1),rece,1)-ex);
                                YtransreceiverNotDesiredAuto=abs(receiversT(autonomousRBCell1(d,c,numBGCell1),rece,2)-yi);
                                tangentNotDesiredAutoCUE=sqrt((XtransreceiverNotDesiredAuto^2)+(YtransreceiverNotDesiredAuto^2));

                            %Again here, we calculate "prNotDesiredAuto" for the single not
                            %desired CUE. 

                                pathLossNotDesiredAutoCUE=128.1+37.6*log10(tangentNotDesiredAutoCUE);%km?yes
                                %I should check the transmission power for
                                %the CUE. If it's "40" (the same as D2D) or
                                %not
                                prNotDesiredAutoCUE=40-pathLossNotDesiredAutoCUE;%40 has changed from 40
                                %here we save the calculated "prNotDesiredAutoCUE" into the
                                %matrix "NotDesiredPrMatrixCUE"; later we'll sum the
                                %corresponsing values of this matrix with
                                %the peers ones in "totalnotDesiredPrMatrix", to get the
                                %totalnotdesiredpr and accordingly get the 
                                NotDesiredPrMatrixCUE(autonomousRBCell1(d,c,numBGCell1),rece)=prNotDesiredAutoCUE;
                          end;
                         end;
                    end; 
                 end;
                end;
              end;
            end;
        end;
        

 %Now we introduce a nested for loop to calculate EbN0 for each individual receiver of all BGs (given undesiredPrs matrices) and based on that fill in the BLER matrix.
%for this, we first define matrices to save the total Pr and EbNo and BER and BLER.

PrNotDesiredTotal=zeros(numberOfBG,numberOfReceivers);
EbNo=zeros(numberOfBG,numberOfReceivers);
BER=zeros(numberOfBG,numberOfReceivers);
BERunique=zeros(numberOfBG,numberOfReceivers);
BLER=zeros(numberOfBG,numberOfReceivers);
BLERreal=zeros(numberOfBG,numberOfReceivers);

%Note that since in the previous version of the code , we only calculated
%SINR for the "in-conflict" users, now in the new version we need it for
%all users, because we need to know BLER for all users. So, here we
%introduce a for loop to spot the zero elements of "prDesiredAuto" and fill them in with new corresponding calculations.

for b=1:numberOfBG;
    for r=1:numberOfReceivers;
        if prDesiredAuto(b,r)==0;
            
            XtransreceiverDesiredAuto=abs(BGC1(b,1)-receiversT(b,r,1));%?for distance measure between desired X_tx and X_receiver
            YtransreceiverDesiredAuto=abs(BGC1(b,2)-receiversT(b,r,2));%?for distance measure between desired Y_tx and Y_receiver
            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);            
            prDesiredAuto(b,r)=40-pathLossDesiredAuto; %p_tx has changed from 30 to 40 for test purpose
        end;

    end;
end;


for b=1:numberOfBG;
    for r=1:numberOfReceivers;
        
        PrNotDesiredTotal(b,r)=totalnotDesiredPrMatrix(b,r)+NotDesiredPrMatrixCUE(b,r);%summed up undesired Pr
     
        %Now, here is the new BER calculation; for this, we need to know which modulation &
        %coding have been used as
        if modulation == 1;%QPSK=4QAM
           k=2; 
           %EbNo(b,r) = prDesiredAuto(b,r)-10*log10(k)-(-107)+PrNotDesiredTotal(b,r);
           EbNo(b,r) = prDesiredAuto(b,r)-(-107)+PrNotDesiredTotal(b,r);
           BER(b,r) = berawgn(EbNo(b,r),'qam',4);
        elseif modulation == 16;%16QAM
           k=4; 
           %EbNo(b,r) = prDesiredAuto(b,r)-10*log10(k)-(-107)+PrNotDesiredTotal(b,r);
           EbNo(b,r) = prDesiredAuto(b,r)-(-107)+PrNotDesiredTotal(b,r);
           BER(b,r) = berawgn(EbNo(b,r),'qam',16);
        else %64QAM
           k=6; 
           %EbNo(b,r) = prDesiredAuto(b,r)-10*log10(k)-(-107)+PrNotDesiredTotal(b,r);
           EbNo(b,r) = prDesiredAuto(b,r)-(-107)+PrNotDesiredTotal(b,r);
           BER(b,r) = berawgn(EbNo(b,r),'qam',64);
        end;
        
        %Now from BER, we need to calculate BLER 
         BLERreal(b,r) = 1-(1-BER(b,r))^TBS;
         BERunique(b,r) = BER(b,r);
         
    end;
end;
       
BER
%fprintf('The current BERunique is : %d \n', BERunique);
        
%this is a mini for loop to turn the elements of "receiverInterfreuse" with
%SINR less than threshold into "0"; this is for the second alternative
%solution, if the BLEr doesn't work well

% % for b=1:numberOfBG;
% %     for r=1:numberOfReceivers;
% %         if  modulation == 1;%QPSK=4QAM       
% %             if SINRTotal(b,r) <25;%most robust modulation
% %                receiverInterfreuse(b,r)=0; 
% %             end;
% %          elseif modulation == 16;%16QAM 
% %             if SINRTotal(b,r) <31;
% %                receiverInterfreuse(b,r)=0; 
% %             end;
% %         else %64QAM
% %             if SINRTotal(b,r) <50;%least robust modulation
% %                receiverInterfreuse(b,r)=0; 
% %             end;
% %         
% %         end;
% %     end;
% % end;

% EbNo
% prDesiredAuto
% PrNotDesiredTotal
%SINRTotal
%save('receiverInterfreuse.mat','receiverInterfreuse');
 
  
