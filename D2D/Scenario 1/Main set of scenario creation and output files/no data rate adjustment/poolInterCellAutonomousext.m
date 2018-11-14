%Due to the extension, now in this script we use "reuseRBCell1new" &
%"autonomousRBCell2new" instead of "reuseRBCell1" & "autonomousRBCell2"
%Note that due to extension "reuseRBCell1new" &
%"autonomousRBCell2new" have different first dimension (nRBpSFCell1new=50=BW) than "reuseRBCell1new"
%& "autonomousRBCell2new" (nRBpSFCell1=10)
load('numberOfBG.mat','numberOfBG')
%numberOfBG=6;
mysize=size(reuseRBCell1new)
nRBpSFCell1new=mysize(1,1)
%The same is valid for Cell2
nRBpSFCell2new=mysize(1,1)

%Create overlapping Matrixes; is this needed?
overlappingMatgraph=zeros(numberOfBG,numberOfReceivers,2);

%Check intercell interference for all the broadcast groups in Cell1
for numBG=1:numberOfBG;
    for c=1:length(bitmapCell1reuse);
        for d=1:nRBpSFCell1new;
            %if there's a conflic between D2D BGs; the following if checks
            %if the same position is occupied in Cell1 and Cell2
            if (reuseRBCell1new(d,c,numBG)~=0)&&(autonomousRBCell2new(d,c,numBG)~=0)&&(autonomousRBCell2new(d,c,numBG)<=10);
                %and the distance is less than a threshold, check SINR
                if (BGC1(reuseRBCell1new(d,c,numBG),1)-5<=BGC2(autonomousRBCell2new(d,c,numBG),1))&&(BGC1(reuseRBCell1new(d,c,numBG),1)+5>=BGC2(autonomousRBCell2new(d,c,numBG),1))&&(BGC1(reuseRBCell1new(d,c,numBG),2)-5<=BGC2(autonomousRBCell2new(d,c,numBG),2))&&(BGC1(reuseRBCell1new(d,c,numBG),2)+5>=BGC2(autonomousRBCell2new(d,c,numBG),2));
                    for a=1:length(receiversT);
                        XtransreceiverDesiredAuto=abs(BGC1(reuseRBCell1new(d,c,numBG),1)-receiversT(reuseRBCell1new(d,c,numBG),a,1));
                        YtransreceiverDesiredAuto=abs(BGC1(reuseRBCell1new(d,c,numBG),2)-receiversT(reuseRBCell1new(d,c,numBG),a,2));
                        tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));
                        
                        XtransreceiverNotDesiredAuto=abs(receiversT(reuseRBCell1new(d,c,numBG),a,1)-BGC2(autonomousRBCell2new(d,c,numBG),1));
                        YtransreceiverNotDesiredAuto=abs(receiversT(reuseRBCell1new(d,c,numBG),a,2)-BGC2(autonomousRBCell2new(d,c,numBG),2));
                        tangentNotDesiredAuto=sqrt((XtransreceiverNotDesiredAuto^2)+(YtransreceiverNotDesiredAuto^2));
                        
                        pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);
                        pathLossNotDesiredAuto=148+40*log10(tangentNotDesiredAuto);
                        
                        prDesiredAuto=40-pathLossDesiredAuto;
                        prNotDesiredAuto=40-pathLossNotDesiredAuto;
                        
                        SINRAuto=prDesiredAuto - (118.4+prNotDesiredAuto);
                        if (SINRAuto<-107);
                            receiverInterfautonomous(reuseRBCell1new(d,c,numBG),a)=0;
                        end;
                    end;
                elseif (BGC1(reuseRBCell1new(d,c,numBG),1)-5>BGC2(autonomousRBCell2new(d,c,numBG),1))||(BGC1(reuseRBCell1new(d,c,numBG),1)+5<BGC2(autonomousRBCell2new(d,c,numBG),1))&&(BGC1(reuseRBCell1new(d,c,numBG),2)-5>BGC2(autonomousRBCell2new(d,c,numBG),2))||(BGC1(reuseRBCell1new(d,c,numBG),2)+5<BGC2(autonomousRBCell2new(d,c,numBG),2));
                    for a=1:length(receiversT);
                        %compare distance of receivers from cell one with
                        %transmitters of cell 2
                        XtransreceiverDesiredAuto=abs(BGC1(reuseRBCell1new(d,c,numBG),1)-receiversT(reuseRBCell1new(d,c,numBG),a,1));
                        YtransreceiverDesiredAuto=abs(BGC1(reuseRBCell1new(d,c,numBG),2)-receiversT(reuseRBCell1new(d,c,numBG),a,2));
                        tangentDesiredAuto=sqrt((XtransreceiverDesiredAuto^2)+(YtransreceiverDesiredAuto^2));
                        
                        XtransreceiverNotDesiredAuto=abs(receiversT(reuseRBCell1new(d,c,numBG),a,1)-BGC2(autonomousRBCell2new(d,c,numBG),1));
                        YtransreceiverNotDesiredAuto=abs(receiversT(reuseRBCell1new(d,c,numBG),a,2)-BGC2(autonomousRBCell2new(d,c,numBG),2));
                        tangentNotDesiredAuto=sqrt((XtransreceiverNotDesiredAuto^2)+(YtransreceiverNotDesiredAuto^2));
                        
                        pathLossDesiredAuto=148+40*log10(tangentDesiredAuto);
                        pathLossNotDesiredAuto=148+40*log10(tangentNotDesiredAuto);
                        
                        prDesiredAuto=40-pathLossDesiredAuto;
                        prNotDesiredAuto=40-pathLossNotDesiredAuto;
                        
                        SINRAuto=prDesiredAuto - (118.4+prNotDesiredAuto);
                        if (SINRAuto<-107);
                            receiverInterfautonomous(reuseRBCell1new(d,c,numBG),a)=0;
                        end;
                    end;
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
                end;
                if (cellularRBMatrixgraphnew(d,c)~=0)&&(reuseRBCell1new(d,c,numBG)~=0);
                    if (BGC1(reuseRBCell1new(d,c,numBG),1)-10<=ex)&&(BGC1(reuseRBCell1new(d,c,numBG),1)+10>=ex)&&(BGC1(reuseRBCell1new(d,c,numBG),2)-10<=yi)&&(BGC1(reuseRBCell1new(d,c,numBG),2)+10>=yi);
                        autonomousRBOverlap(d,c,numBG)=0;
                        autonomousRBCell2new(d,c,numBG)=0;
                    elseif (receiversT(reuseRBCell1new(d,c,numBG),a,1)-3<=ex)&&(receiversT(reuseRBCell1new(d,c,numBG),a,1)+3>=ex)&&(receiversT(reuseRBCell1new(d,c,numBG),a,2)-3<=yi)&&(receiversT(reuseRBCell1new(d,c,numBG),a,2)+3>=yi);
                        receiverInterfautonomous(reuseRBCell1new(d,c,numBG),cusers)=0;
                    end;
                    
                end;
            end;
        end;
    end;
end;

