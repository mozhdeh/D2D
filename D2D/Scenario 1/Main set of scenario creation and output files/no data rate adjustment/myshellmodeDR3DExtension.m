%  clc
%  clear all
%  close all

scperiod=[40,60,80,100,120];
MS=[5,7,9,11,13,15];
%for x=1:1;%confidence repetition
   for i=1:16;%#BG
           for k=1:6;%messizeinpackets
               %here we need to import the BGCcoor and the independent
               %subset generated in Mathematica
               textFileName = ['BGC' num2str(i+4) 'rep7.txt'];
               BGC1=dlmread(textFileName);%note that regardless of #BG, in the code BGC1 saves the coordinates; so here after reading them with different names, we save all with the same name             
               save('BGC1Coordinates.mat','BGC1')
               textFileName = ['DisjointIndependentSubsets' num2str(i+4) 'rep7.txt'];
               MySubsets=dlmread(textFileName);%the same thing regarding unified naming, after reading, applies here
               save('MySubsets.mat','MySubsets')
               createScenarioext(i+4,100,MS(1,k));
               %save the delivery ratio in the text file
               load('graph1.mat','graph1');
               DR(i,k)=graph1;
               %save the spectrum efficiency in the text file
               load('se.mat','se');
               SE(i,k)=se;
               %save the packet error rate in the text file
               load('final.mat','final');
               PER(i,k)=final;
               %save the number of used resources (i.e. lines) in the text file
               load('lines.mat','lines');
               Lines(i,k)=lines;         
           end;
   end;
   
    %here we export the generated matrices to plot later
    dlmwrite('DRrep7.txt',DR);
    dlmwrite('serep7.txt',SE);
    dlmwrite('PERrep7.txt',PER);
    dlmwrite('linesrep7.txt',Lines);

%end;

 
       
       
       