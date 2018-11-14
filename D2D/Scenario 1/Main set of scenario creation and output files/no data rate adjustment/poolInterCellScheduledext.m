%Due to the extension, now in this script we use "reuseRBCell1new" &
%"autonomousRBCell2new" instead of "reuseRBCell1" & "autonomousRBCell2"
%Note that due to extension "reuseRBCell1new" &
%"autonomousRBCell2new" have different first dimension (nRBpSFCell1new=50=BW) than "reuseRBCell1new"
%& "autonomousRBCell2new" (nRBpSFCell1=10)
load('numberOfBG.mat','numberOfBG')
load('numberOfBGC2.mat','numberOfBGC2')
load('numberOfReceivers.mat','numberOfReceivers')
%numberOfBG=6;
mysize=size(scheduledRBCell1new);
nRBpSFCell1new=mysize(1,1);
%The same is valid for Cell2
nRBpSFCell2new=mysize(1,1);

%Here we create a matrix called "InternotDesiredPrMatrix" to save the
%calculated "sum(AllprNotDesiredAuto)" for each user of each BG; The reason
%is that we later need these values to be summed up with the corresponding
%values for "Intra-cell" and come up with the final level of not desired pr
%and accordingly calculate the final SINR for that particular receiver.
InternotDesiredPrMatrix=zeros(numberOfBG,numberOfReceivers);


%Create overlapping Matrixes; is this needed?
overlappingMatgraph=zeros(numberOfBG,numberOfReceivers,2);

%Check intercell interference for all the broadcast groups in Cell1
        for c=1:length(bitmapCell1scheduled);
            %for d=1:nRBpSFCell1new;
             for d=1:newLCRBCell1:nRBpSFCell1new;
               if (scheduledRBCell1new(d,c)~=0);
                    nonzerosCell1=scheduledRBCell1new(d,c);
                    %Now, we get the "nonzerosCell2"
                   temp3=autonomousRBCell2new(d,c,:);             
                   temp4=temp3(temp3~=0);
                   temp4=temp4(temp4<10);
                   nonzerosCell2=zeros(length(temp4),1);
                %Since "autonomousRBCell2new" is a 3D matrix, "nonzerosCell2" is too;
                %So, we need to change this and save "nonzerosCell2" as an
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
                     %SNR calculation 
%                      for rece=1:numberOfReceivers;
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
%                             %Here, we calculate the
%                             %SNR for a given receiver "rece"
%                             %of a given BG "nonzerosCell1(k,1)"
%                             if (SINRAuto<-107);
%                                 receiverInterfScheduled(nonzerosCell1(k,1),rece)=0;
%                             end;
%                      end; 
                     
                  %else
                     %SINR calculation
                   if inranges~=0;
                     for rece=1:numberOfReceivers;
                              
                            XtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),1)-receiversT(nonzerosCell1(k,1),rece,1));%?for distance measure between desired X_tx and X_receiver
                            YtransreceiverDesiredAuto=abs(BGC1(nonzerosCell1(k,1),2)-receiversT(nonzerosCell1(k,1),rece,2));%?for distance measure between desired Y_tx and Y_receiver
                            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
                            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
                            prDesiredAuto=30-pathLossDesiredAuto;%what? pathloss=p_tx/p_rx; so this is to calculate p_rx
                            
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

                            SINRAuto=prDesiredAuto - (174+InternotDesiredPrMatrix(nonzerosCell1(k,1),rece));
                            
                            %Here, we calculate the
                            %(inter) SINR for a given receiver "rece"
                            %of a given BG "nonzerosCell1(k,1)"
                            if (SINRAuto<-107);
                                receiverInterfScheduled(nonzerosCell1(k,1),rece)=0;
                            end;
                     end; 
                  end;
                  %end;   
                end;
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
                 %for numBGCell1=1:numberOfBG;
                     if (cellularRBMatrixgraphnew(d,c)~=0)&&(scheduledRBCell1new(d,c)~=0);
                         
                        coordinatesCUE=[ex yi];
                         %In the following line, I've considered 1km(as transmission range of BG)+3km(as transmission range of CUE)=4 as
                         %the in range limit for SINR calculation
                         idx = rangesearch(coordinatesCUE,BGC1(scheduledRBCell1new(d,c),1:2),4);
                         %accessing cell element
                         idx=idx{1,1};
                         if idx~=0;
                         %Now, we calculate SINR for all the receivers of
                         %the BG=numBGCell1
                         for rece=1:numberOfReceivers;
                            XtransreceiverDesiredAuto=abs(BGC1(scheduledRBCell1new(d,c),1)-receiversT(scheduledRBCell1new(d,c),rece,1));%?for distance measure between desired X_tx and X_receiver
                            YtransreceiverDesiredAuto=abs(BGC1(scheduledRBCell1new(d,c),2)-receiversT(scheduledRBCell1new(d,c),rece,2));%?for distance measure between desired Y_tx and Y_receiver
                            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
                            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
                            prDesiredAuto=30-pathLossDesiredAuto;%what? pathloss=p_tx/p_rx; so this is to calculate p_rx
                            
                            %the same distance measure for the single
                            %non-desired CUE which is inrange; 

                                XtransreceiverNotDesiredAuto=abs(receiversT(scheduledRBCell1new(d,c),rece,1)-ex);
                                YtransreceiverNotDesiredAuto=abs(receiversT(scheduledRBCell1new(d,c),rece,2)-yi);
                                tangentNotDesiredAutoCUE=sqrt((XtransreceiverNotDesiredAuto^2)+(YtransreceiverNotDesiredAuto^2));

                            %Again here, we calculate "prNotDesiredAuto" for the single not
                            %desired CUE. 

                                pathLossNotDesiredAutoCUE=128.1+37.6*log10(tangentNotDesiredAutoCUE);%km?yes
                                %I should check the transmission power for
                                %the CUE. If it's "40" (the same as D2D) or
                                %not
                                prNotDesiredAutoCUE=40-pathLossNotDesiredAutoCUE;
                            
                                SINRAuto=prDesiredAuto - (174+prNotDesiredAutoCUE);
                            
                                if (SINRAuto<-107);
                                    receiverInterfScheduled(scheduledRBCell1new(d,c),rece)=0;
                                end;

                          end;
                         end;
                    end; 
                 %end;
                end;
              end;
            end;
        end;
