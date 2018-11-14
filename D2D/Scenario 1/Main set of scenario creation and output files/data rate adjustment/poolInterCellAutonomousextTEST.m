%Due to the extension, now in this script we use "reuseRBCell1new" &
%"autonomousRBCell2new" instead of "reuseRBCell1" & "autonomousRBCell2"
%Note that due to extension "reuseRBCell1new" &
%"autonomousRBCell2new" have different first dimension (nRBpSFCell1new=50=BW) than "reuseRBCell1new"
%& "autonomousRBCell2new" (nRBpSFCell1=10)
load('numberOfBG.mat','numberOfBG')
load('numberOfBGC2.mat','numberOfBGC2')
load('numberOfReceivers.mat','numberOfReceivers')
load('IntranotDesiredPrMatrix.mat','IntranotDesiredPrMatrix')
%numberOfBG=6;
mysize=size(reuseRBCell1new);
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

%Create overlapping Matrixes; is this needed?
overlappingMatgraph=zeros(numberOfBG,numberOfReceivers,2);

%Check intercell interference for all the broadcast groups in Cell1
        for c=1:length(bitmapCell1reuse);
            %for d=1:nRBpSFCell1new;
             for d=1:newLCRBCell1:nRBpSFCell1new;
                temp1=reuseRBCell1new(d,c,:);
                temp2=temp1(temp1~=0);
                nonzerosCell1=zeros(length(temp2),1);
                %Since "reuseRBCell1new" is a 3D matrix, "nonzerosCell1" is too;
                %So, we need to change this and save "nonzerosCell1" as an
                %ordinary 2D matrix
                for r=1:length(nonzerosCell1);
                    nonzerosCell1(r,1)=temp2(:,:,r);
                end;
                %Now, we get the "nonzerosCell2" the same way we did for
                %Cell1;
                temp3=autonomousRBCell2new(d,c,:);             
                temp4=temp3(temp3~=0);
                temp4=temp4(temp4<=10);
                nonzerosCell2=zeros(length(temp4),1);
                %Since "autonomousRBCell2new" is a 3D matrix, "nonzerosCell2" is too;
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
                       
                    
                    
                  %if inranges==0;
                      %SNR calculation;in this case we just have the hata
                      %path loss due to distance from the source and
                      %nothing from interfering sources
%                       for rece=1:numberOfReceivers;
%                           
%                             XtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),1)-receiversT(nonzerosCell1(k,1),rece,1));%?for distance measure between desired X_tx and X_receiver
%                             YtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),2)-receiversT(nonzerosCell1(k,1),rece,2));%?for distance measure between desired Y_tx and Y_receiver
%                             tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
%                             
%                             pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
%                             prDesiredAuto=40-pathLossDesiredAuto;%what? pathloss=p_tx/p_rx; so this is to calculate p_rx
%                             
%                             SINRAuto=prDesiredAuto - 100;
%                             
%                            %Here, we calculate the
%                             %SNR for a given receiver "rece"
%                             %of a given BG "nonzerosCell1(k,1)"
%                             if (SINRAuto<-107);
%                                 receiverInterfreuse(nonzerosCell1(k,1),rece)=0;
%                             end;
%                       end;
                  %else
                  
                  if inranges~=0;
                      %SINR calculation;in this case we have both sources
                      %of loss (distance+interfering sources)
                    for rece=1:numberOfReceivers;
                              
                            XtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),1)-receiversT(nonzerosCell1(k,1),rece,1));%?for distance measure between desired X_tx and X_receiver
                            YtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),2)-receiversT(nonzerosCell1(k,1),rece,2));%?for distance measure between desired Y_tx and Y_receiver
                            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
                            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
                            prDesiredAuto=30-pathLossDesiredAuto%what? pathloss=p_tx/p_rx; so this is to calculate p_rx
                            
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
                                AllprNotDesiredAuto(f,1)=30-pathLossNotDesiredAuto;
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
                            
                            SINRAuto=prDesiredAuto - (174+totalnotDesiredPrMatrix(nonzerosCell1(k,1),rece));
                            
                            %Here, we calculate the final total
                            %(intra+inter) SINR for a given receiver "rece"
                            %of a given BG "nonzerosCell1(k,1)"
                            if (SINRAuto<-107);
                                receiverInterfreuse(nonzerosCell1(k,1),rece)=0;
                            end;
                     end; 
                  end; 
                  %end;
                end;
                
                
            %Check if there is any conflict with cellular users. no SINR
            %for CUE? we have changed also the dimension of
            %"cellularRBMatrixgraph" matrix from "10" to "50" and saved it as matrix "cellularRBMatrixgraphnew", to be
            %compatible with the extension. 
            
             for cusers=1:length(numberOfCellularUsersCell2);
                 if cellularUsersCell2(cusers,3)==cellularRBMatrixgraphnew(d,c);
                    ex=cellularUsersCell2(cusers,1);
                    yi=cellularUsersCell2(cusers,2);
                 %end;
                 for numBGCell1=1:numberOfBG;
                     if (cellularRBMatrixgraphnew(d,c)~=0)&&(reuseRBCell1new(d,c,numBGCell1)~=0);
                         
                        coordinatesCUE=[ex yi];
                         %In the following line, I've considered 1(transmissino range of BG)+3(transmissino range of CUE)=4 as
                         %the in range limit for SINR calculation
                         idx = rangesearch(coordinatesCUE,BGC1(reuseRBCell1new(d,c,numBGCell1),1:2),4);
                         %accessing cell element
                         idx=idx{1,1};
                         if idx~=0;
                         %Now, we calculate SINR for all the receivers of
                         %the BG=numBGCell1
                         for rece=1:numberOfReceivers;
                            XtransreceiverDesiredAuto=abs(BGC1(reuseRBCell1new(d,c,numBGCell1),1)-receiversT(reuseRBCell1new(d,c,numBGCell1),rece,1));%?for distance measure between desired X_tx and X_receiver
                            YtransreceiverDesiredAuto=abs(BGC1(reuseRBCell1new(d,c,numBGCell1),2)-receiversT(reuseRBCell1new(d,c,numBGCell1),rece,2));%?for distance measure between desired Y_tx and Y_receiver
                            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
                            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
                            prDesiredAuto=30-pathLossDesiredAuto%what? pathloss=p_tx/p_rx; so this is to calculate p_rx
                            
                            %the same distance measure for the single
                            %non-desired CUE which is inrange; 

                                XtransreceiverNotDesiredAuto=abs(receiversT(reuseRBCell1new(d,c,numBGCell1),rece,1)-ex);
                                YtransreceiverNotDesiredAuto=abs(receiversT(reuseRBCell1new(d,c,numBGCell1),rece,2)-yi);
                                tangentNotDesiredAutoCUE=sqrt((XtransreceiverNotDesiredAuto^2)+(YtransreceiverNotDesiredAuto^2));

                            %Again here, we calculate "prNotDesiredAuto" for the single not
                            %desired CUE. 

                                pathLossNotDesiredAutoCUE=128.1+37.6*log10(tangentNotDesiredAutoCUE);%km?yes
                                %I should check the transmission power for
                                %the CUE. If it's "40" (the same as D2D) or
                                %not
                                prNotDesiredAutoCUE=40-pathLossNotDesiredAutoCUE;

                            %Now, we calculate the SINR. Again here we have
                            %to consider the all the not desired ones (single not desired from CUE(inter-cell)+other not desired ones from D2D BGs(intra-cell) to be summed up)
                                AllprNotDesiredAuto=prNotDesiredAutoCUE+IntranotDesiredPrMatrix(reuseRBCell1new(d,c,numBGCell1),rece);
                            
                                SINRAuto=prDesiredAuto - (174+AllprNotDesiredAuto);
                            
                                if (SINRAuto<-107);
                                    receiverInterfreuse(reuseRBCell1new(d,c,numBGCell1),rece)=0;
                                end;

                          end;
                         end;
                    end; 
                 end;
                end;
              end;
            end;
        end;
