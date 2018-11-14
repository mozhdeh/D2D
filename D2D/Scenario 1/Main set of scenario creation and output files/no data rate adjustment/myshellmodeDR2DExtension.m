 clc
 clear all
 close all

scperiod=[40,60,80,100,120];
MS=[5,7,9,11,13,15];
%for x=1:1;%confidence repetition
   for i=1:4;%#BG
           %for k=1:6;%messizeinpackets
               %here we need to import the BGCcoor and the independent
               %subset generated in Mathematica
               textFileName = ['BGC' num2str(i) 'rep5.txt'];
               BGC1=dlmread(textFileName);%note that regardless of #BG, in the code BGC1 saves the coordinates; so here after reading them with different names, we save all with the same name             
               save('BGC1Coordinates.mat','BGC1')
               textFileName = ['DisjointIndependentSubsets' num2str(i) 'rep5.txt'];
               if i>=5;
                  MySubsets=dlmread(textFileName);%the same thing regarding unified naming, after reading, applies here
                  save('MySubsets.mat','MySubsets')
               end;              
               createScenarioext(i,40,15);
               %save the delivery ratio in the text file
               load('graph1sched.mat','graph1sched');
               DR(i,1)=graph1sched;
% %                %save the spectrum efficiency in the text file
% %                load('se.mat','se');
% %                SE(i,1)=se;
% %                %save the packet error rate in the text file
% %                load('final.mat','final');
% %                PER(i,1)=final;
% %                %save the number of used resources (i.e. lines) in the text file
% %                load('lines.mat','lines');
% %                Lines(i,1)=lines;         
           %end;
   end;
   
    %here we export the generated matrices to plot later
    dlmwrite('2DDRrep5sched.txt',DR);
% %     dlmwrite('2Dserep5sched.txt',SE);
% %     dlmwrite('2DPERrep5sched.txt',PER);
% %     dlmwrite('2Dlinesrep5sched.txt',Lines);

%end;

 
       
       
       