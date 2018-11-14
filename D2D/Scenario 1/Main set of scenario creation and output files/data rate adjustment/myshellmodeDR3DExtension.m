 clc
 clear all
 close all

%we use this script (mainly just the following for loop) both for single & double cell rate adjustment scenarios

%for x=1:1;%confidence repetition
   for i=13:13;%#BG. note that since till BG=13 there is no rate adjustment, we execute from 13 to 20. for the earlier cases: BG=1:12, we use the previous available values
               %here we need to import the BGCcoor and the independent
               %subset generated in Mathematica
               textFileName = ['BGC' num2str(i) 'raterep5.txt'];
               BGC1=dlmread(textFileName) %note that regardless of #BG, in the code BGC1 saves the coordinates; so here after reading them with different names, we save all with the same name             
               save('BGC1Coordinates.mat','BGC1')
               if i>=5;
                  textFileName = ['DisjointIndependentSubsets' num2str(i) 'raterep5.txt'];
                  MySubsets=dlmread(textFileName);%the same thing regarding unified naming, after reading, applies here
                  save('MySubsets.mat','MySubsets') 
               end;              
               createScenarioext(i,100,15);%scperiod=100ms,messagesizeinpackets=15
               %save the delivery ratio in the text file
               load('graph1.mat','graph1');
               DR(i,1)=graph1
               %save the spectrum efficiency in the text file
               load('se.mat','se');
               SE(i,1)=se
               %save the packet error rate in the text file
               load('final.mat','final');
               PER(i,1)=final
               %save the number of used resources (i.e. lines) in the text file
               load('lines.mat','lines');
               Lines(i,1)=lines   
                %save the newLCRBCell1 (i.e. new data rate) in the text file
               load('newLCRBCell1.mat','newLCRBCell1');
               DataRate(i,1)=newLCRBCell1 
   end;
       
% % for i=1:4;%#BG
% %                %here we need to import the BGCcoor and the independent
% %                %subset generated in Mathematica
% %                textFileName = ['BGC' num2str(i) 'raterep5.txt'];
% %                BGC1=dlmread(textFileName) %note that regardless of #BG, in the code BGC1 saves the coordinates; so here after reading them with different names, we save all with the same name             
% %                save('BGC1Coordinates.mat','BGC1')
% %                if i>=5;
% %                   textFileName = ['DisjointIndependentSubsets' num2str(i) 'raterep5.txt'];
% %                   MySubsets=dlmread(textFileName);%the same thing regarding unified naming, after reading, applies here
% %                   save('MySubsets.mat','MySubsets') 
% %                end;              
% %                createScenarioext(i,100,15);%scperiod=100ms,messagesizeinpackets=15
% %                %save the delivery ratio in the text file
% %                load('graph1sched.mat','graph1sched');
% %                DR(i,1)=graph1sched
% %                %save the spectrum efficiency in the text file
% %                load('se.mat','se');
% %                SE(i,1)=se
% %                %save the packet error rate in the text file
% %                load('final.mat','final');
% %                PER(i,1)=final
% %                %save the number of used resources (i.e. lines) in the text file
% %                load('lines.mat','lines');
% %                Lines(i,1)=lines        
% % end;

    %here we export the generated matrices to plot later
    dlmwrite('DRraterep5singlecell.txt',DR);
    dlmwrite('seraterep5singlecell.txt',SE);
    dlmwrite('PERraterep5singlecell.txt',PER);
    dlmwrite('linesraterep5singlecell.txt',Lines);
    dlmwrite('newLCRBCell1raterep5singlecell.txt',DataRate);

%end;

 
       
       
       