mysize=size(autonomousRBCell1);
nRBpSFCell1new=mysize(1,1);
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBG.mat','numberOfBG')
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/numberOfBGC2.mat','numberOfBGC2')

load('numberOfReceivers.mat','numberOfReceivers')%doesn't matter from which path to laod as always 10
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/MCSBLERSINR.mat','modulation','MCSIndex','Qm','RE')
load('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/BGC1.mat','BGC1')


%Here we create a matrix called "IntranotDesiredPrMatrix" to save the
%calculated "sum(AllprNotDesiredAuto)" for each user of each BG; The reason
%is that we later need these values to be summed up with the corresponding
%values for "Inter-cell" and come up with the final level of not desired pr
%and accordingly calculate the final SINR for that particular receiver.
IntranotDesiredPrMatrix=zeros(numberOfBG,numberOfReceivers);

%We define the "prDesiredAuto" matrix, instead of just saving instantly
%its current value, because we need to use it in the last nested for loop of this file to calcualte BLERs
prDesiredAuto=zeros(numberOfBG,numberOfReceivers);

        for c=1:length(bitmapCell1reuse);
            %for d=1:nRBpSFCell1new;
            for d=1:nRBpSFCell1new;
                if nnz(autonomousRBCell1(d,c,:))>1 
                   temp1=autonomousRBCell1(d,c,:);
                   temp2=temp1(temp1~=0);
                   nonzerosCell1=zeros(length(temp2),1);
                   %Since "autonomousRBCell1" is a 3D matrix, "nonzerosCell1" is too;
                   %So, we need to change this and save "nonzerosCell1" as an
                   %ordinary 2D matrix
                   for r=1:length(nonzerosCell1);
                       nonzerosCell1(r,1)=temp2(:,:,r);
                   end;
                   
                   for k=1:length(nonzerosCell1);
                       x=nonzerosCell1([1:k-1 k+1:end]);
                       coordinatesx=zeros(length(x),2);
                       coordinatesy=BGC1(nonzerosCell1(k,1),1:2);

                       inranges=zeros(length(x),1);
                       for z=1:length(x);
                           coordinatesx(z,:)=BGC1(x(z,1),1:2);
                           idx = rangesearch(coordinatesx(z,:),coordinatesy,2);
                           %accessing cell element
                           idx=idx{1,1};
                           if idx~=0;
                           inranges(z,1)=idx;
                           end;
                           inranges = inranges(inranges~=0);
                       end;
                    
                       
                   
                   if inranges~=0;
                       %SINR calculation    
                    for rece=1:numberOfReceivers;
                            XtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),1)-receiversT(nonzerosCell1(k,1),rece,1));%?for distance measure between desired X_tx and X_receiver
                            YtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),2)-receiversT(nonzerosCell1(k,1),rece,2));%?for distance measure between desired Y_tx and Y_receiver
                            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
                            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
                            prDesiredAuto(nonzerosCell1(k,1),rece)=40-pathLossDesiredAuto;%what? pathloss=p_tx/p_rx; so this is to calculate p_rx; p_tx has changed from 30 to 40 for test purpose
                            
                            %the same distance measure for "all"
                            %non-desired ones in "inranges"; for this we
                            %need a mini "for" loop. before, we create a
                            %matrix to save all the distances
                            inrangesDistances=zeros(length(inranges),1);
                            for e=1:length(inranges);
                                XtransreceiverNotDesiredAuto=abs(receiversT(nonzerosCell1(k,1),rece,1)-BGC1(inranges(e,1),1));
                                YtransreceiverNotDesiredAuto=abs(receiversT(nonzerosCell1(k,1),rece,2)-BGC1(inranges(e,1),2));
                                tangentNotDesiredAuto=sqrt((XtransreceiverNotDesiredAuto^2)+(YtransreceiverNotDesiredAuto^2));
                                inrangesDistances(e,1)=tangentNotDesiredAuto;
                            end;

                            
                            %Again here, we need a mini "for" loop to
                            %calculate "prNotDesiredAuto" for all the not
                            %desired ones. Before, we crete a matrix to
                            %save all "prNotDesiredAuto"
                            AllprNotDesiredAuto=zeros(length(inranges),1);
                            for f=1:length(inranges);
                                pathLossNotDesiredAuto=148+40*log10(inrangesDistances(f,1));%km?yes
                                AllprNotDesiredAuto(f,1)=40-pathLossNotDesiredAuto;% p_tx has changed from 30 to 40 for test purpose
                            end;
                            
                            IntranotDesiredPrMatrix(nonzerosCell1(k,1),rece)=sum(AllprNotDesiredAuto);
                            
                     end;
                   end; 
                   
                        contIntraC = contIntraC +1;
                  end; 
                end;
            end;
        end;
        
%We save "IntranotDesiredPrMatrix", as we need
%to sum it with the corresponding inter-cell
save('/Users/toor/Desktop/Script_Files/Matlab/D2D/ExtensionBatchRateAdjustmentDynamicFinalnodelayMinorChanges/IntranotDesiredPrMatrix.mat','IntranotDesiredPrMatrix')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %note that in order to generate results for the single-cell scenarios (with
% % % %no inter-cell interference), we add here also the calculations we have in
% % % %the "poolInterCell" files for SINR and BLER. We manually comment /
% % % %uncomment this part of the code for single & double cell scenarios
% % % 
% 
% % %Now we introduce a nested for loop to calculate EbN0 for each individual receiver of all BGs (given undesiredPrs matrices) and based on that fill in the BLER matrix.
% % %for this, we first define matrices to save the total Pr and EbNo and BER and BLER.
% % 
% PrNotDesiredTotal=zeros(numberOfBG,numberOfReceivers);
% EbNo=zeros(numberOfBG,numberOfReceivers);
% BER=zeros(numberOfBG,numberOfReceivers);
% BERunique=zeros(numberOfBG,numberOfReceivers);
% BLER=zeros(numberOfBG,numberOfReceivers);
% BLERreal=zeros(numberOfBG,numberOfReceivers);
% 
% %Note that since in the previous version of the code , we only calculated
% %SINR for the "in-conflict" users, now in the new version we need it for
% %all users, because we need to know BLER for all users. So, here we
% %introduce a for loop to spot the zero elements of "prDesiredAuto" and fill them in with new corresponding calculations.
% 
% for b=1:numberOfBG;
%     for r=1:numberOfReceivers;
%         if prDesiredAuto(b,r)==0;
%             
%             XtransreceiverDesiredAuto=abs(BGC1(b,1)-receiversT(b,r,1));%?for distance measure between desired X_tx and X_receiver
%             YtransreceiverDesiredAuto=abs(BGC1(b,2)-receiversT(b,r,2));%?for distance measure between desired Y_tx and Y_receiver
%             tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
%                             
%             pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);            
%             prDesiredAuto(b,r)=40-pathLossDesiredAuto;%p_tx has changed from 30 to 40 for test purpose
%         end;
% 
%     end;
% end;
% 
% 
% 
% for b=1:numberOfBG;
%     %as BER doesn't change significantly with a change in EbN0, here we
%     %generate a number that gets increased by each iteration of the for
%     %loop for #of BGs, so that we see in the final graph increasing BER, by
%     %an increase in #BGs from 1 to 15 and not only after 16.
%     
%     for r=1:numberOfReceivers;
%         
%         PrNotDesiredTotal(b,r)=IntranotDesiredPrMatrix(b,r);%the only undesired Pr
% 
%         %Now, here is the new BER calculation; for this, we need to know which modulation &
%         %coding have been used as
%         if modulation == 1;%QPSK=4QAM
%            k=2; 
%            %EbNo(b,r) = prDesiredAuto(b,r)-10*log10(k)-(-107)-PrNotDesiredTotal(b,r);
%            EbNo(b,r) = prDesiredAuto(b,r)-(-107)+PrNotDesiredTotal(b,r);
%            BER(b,r) = berawgn(EbNo(b,r),'qam',4)
%         elseif modulation == 16;%16QAM
%            k=4; 
%            %EbNo(b,r) = prDesiredAuto(b,r)-10*log10(k)-(-107)-PrNotDesiredTotal(b,r);
%            EbNo(b,r) = prDesiredAuto(b,r)-(-107)+PrNotDesiredTotal(b,r);
%            BER(b,r) = berawgn(EbNo(b,r),'qam',16)
%         else %64QAM
%            k=6; 
%            %EbNo(b,r) = prDesiredAuto(b,r)-10*log10(k)-(-107)-PrNotDesiredTotal(b,r);
%            EbNo(b,r) = prDesiredAuto(b,r)-(-107)+PrNotDesiredTotal(b,r);
%            BER(b,r) = berawgn(EbNo(b,r),'qam',64)
%         end;
%         
%         %Now from BER, we need to calculate BLER 
%          BLERreal(b,r) = 1-(1-BER(b,r))^TBS;
%          BERunique(b,r) = BER(b,r);
%     end;
% end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
