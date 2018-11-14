mysize=size(reuseRBCell1new)
nRBpSFCell1new=mysize(1,1)
load('numberOfBG.mat','numberOfBG')
load('numberOfReceivers.mat','numberOfReceivers')
%Here we create a matrix called "IntranotDesiredPrMatrix" to save the
%calculated "sum(AllprNotDesiredAuto)" for each user of each BG; The reason
%is that we later need these values to be summed up with the corresponding
%values for "Inter-cell" and come up with the final level of not desired pr
%and accordingly calculate the final SINR for that particular receiver.
IntranotDesiredPrMatrix=zeros(numberOfBG,numberOfReceivers);

        for c=1:length(bitmapCell1reuse);
            for d=1:nRBpSFCell1new;
                if nnz(reuseRBCell1new(d,c,:))>1 
                   temp1=reuseRBCell1new(d,c,:);
                   temp2=temp1(temp1~=0);
                   nonzeros=zeros(length(temp2),1);
                   %Since "reuseRBCell1new" is a 3D matrix, "nonzeros" is too;
                   %So, we need to change this and save "nonzeros" as an
                   %ordinary 2D matrix
                   for r=1:length(nonzeros);
                       nonzeros(r,1)=temp2(:,:,r);
                   end;
                   
                   for k=1:length(nonzeros);
                       x=nonzeros([1:k-1 k+1:end]);
                       coordinatesx=zeros(length(x),2);
                       coordinatesy=BGC1(nonzeros(k,1),1:2);
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
                    
                    %if (BGC1(nfirstbg,1)-5<=BGC1(nbrog,1))&&(BGC1(nfirstbg,1)+5>=BGC1(nbrog,1))&&(BGC1(nfirstbg,2)-5<=BGC1(nbrog,2))&&(BGC1(nfirstbg,2)+5>=BGC1(nbrog,2));
                       
                    for rece=1:numberOfReceivers;
                            XtransreceiverDesiredAuto=abs(BGC1(nonzeros(k,1),1)-receiversT(nonzeros(k,1),rece,1));%?for distance measure between desired X_tx and X_receiver
                            YtransreceiverDesiredAuto=abs(BGC1(nonzeros(k,1),2)-receiversT(nonzeros(k,1),rece,2));%?for distance measure between desired Y_tx and Y_receiver
                            tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));%? for the final distance measure between desired tx & receiver
                            
                            pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);%km?yes
                            prDesiredAuto=40-pathLossDesiredAuto;%what? pathloss=p_tx/p_rx; so this is to calculate p_rx
                            
                            %the same distance measure for "all"
                            %non-desired ones in "inranges"; for this we
                            %need a mini "for" loop. before, we create a
                            %matrix to save all the distances
                            inrangesDistances=zeros(length(inranges),1);
                            for e=1:length(inranges);
                                XtransreceiverNotDesiredAuto=abs(receiversT(nonzeros(k,1),rece,1)-BGC1(inranges(e,1),1));
                                YtransreceiverNotDesiredAuto=abs(receiversT(nonzeros(k,1),rece,2)-BGC1(inranges(e,1),2));
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
                                AllprNotDesiredAuto(f,1)=40-pathLossNotDesiredAuto;
                            end;
                            
                            SINRAuto=prDesiredAuto - (118.4+sum(AllprNotDesiredAuto));
                            IntranotDesiredPrMatrix(nonzeros(k,1),rece)=sum(AllprNotDesiredAuto);
                            
                            if (SINRAuto<-107);
                                receiverInterfautonomous(nonzeros(k,1),rece)=0;
                            end;

                     end;

                        contIntraC = contIntraC +1;
                  end; 
                end;
            end;
        end;
        
%We save "IntranotDesiredPrMatrix", as we need
%to sum it with the corresponding inter-cell
save('IntranotDesiredPrMatrix.mat','IntranotDesiredPrMatrix')
