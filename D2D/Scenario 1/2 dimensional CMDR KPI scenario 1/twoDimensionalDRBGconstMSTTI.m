%reading from the matrices: 2DDRrep1-5, PERrep1-5, linesrep1-5, serep1-5

%first 4 scheduled
DRrep1sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep1sched.txt');
DRrep2sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep2sched.txt');
DRrep3sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep3sched.txt');
DRrep4sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep4sched.txt');
DRrep5sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep5sched.txt');
meanMatrixDRsched = (DRrep1sched+DRrep1sched+DRrep1sched+DRrep1sched+DRrep1sched)/5;

%next 16 reused
DRrep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep1.txt');
DRrep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep2.txt');
DRrep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep3.txt');
DRrep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep4.txt');
DRrep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/2DDRrep5.txt');
meanMatrixDRreuse = (DRrep1+DRrep2+DRrep3+DRrep4+DRrep5)/5;

%we need to vertically concatenate the matrices for the scheduled mode (BG:1-4) and
%reuse mode (BG:5-20), in order to have the results for 20 BGS
meanMatrixDRTotal=vertcat(meanMatrixDRsched,meanMatrixDRreuse)

%DRMean matrix, modified (descending order in two dimesnions),imported here
DRMeanExtension=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/2D-DRBGconstMS15TTI40Ext/DRMean.txt');

%NOTE THAT HERE WE IMPORT THE EXCEL FILES, USED BEFORE TO MAKE THE 2D
%DELIVERY RATIO GRAPHS (FIGURE NR.5 IN THE PAPER) AND COMBINE THEM WITH THE
%ABOVE ONE (INTER+INTRA (DOUBLE CELL) EXTENSION)

xlRange = 'AC:AC';
graph1 = xlsread('/Users/toor/Desktop/Script_Files/Matlab/D2D/extended version5RANDC2/Numericals-norateadjustment/deliveryratio-simulation-numericals-intra-autonomous.xlsx',xlRange)
p=plot(graph1,'b');
p.LineWidth=2;
p.Marker='*';
hold on

xlRange = 'Z:Z';
graph2 = xlsread('/Users/toor/Desktop/Script_Files/Matlab/D2D/extended version5RANDC2/Numericals-norateadjustment/deliveryratio-simulation-numericals-intra-extension.xlsx',xlRange)
p=plot(graph2,'r');
p.LineWidth=2;
p.Marker='+';
hold on

xlRange = 'AB:AB';
graph3 = xlsread('/Users/toor/Desktop/Script_Files/Matlab/D2D/extended version5RANDC2/Numericals-norateadjustment/deliveryratio-simulation-numericals-inter-intra-autonomous.xlsx',xlRange)
p=plot(graph3,'b--');
p.LineWidth=2;
p.Marker='*';
hold on


%reading from the matrices: DRrep1-6auto, PERrep1-6auto, linesrep1-6auto,
%serep1-6auto
% % DRrep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep1auto.txt');
% % DRrep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep2auto.txt');
% % DRrep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep3auto.txt');
% % DRrep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep4auto.txt');
% % DRrep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep5auto.txt');
% % DRrep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep6auto.txt');
% % 
% % meanMatrixDRAuto = (DRrep1auto+DRrep2auto+DRrep3auto+DRrep4auto+DRrep5auto+DRrep6auto)/6;
% % 
% % %DRMean matrix, modified (descending order in two dimesnions),
% % %imported here
% % DRMeanAutonomous=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRMeanAuto.txt');

%%%%%%%%%%%%%%%%Delivery ratio graph for 
%autonomous & extension(spatial reuse, without rate adjustment)
%intracell & intercell effects
%100 ms SC-Period
%100 messages, varying message size

p=plot(DRMeanExtension,'r--');
p.LineWidth=3;
p.Marker='+';
hold on

% % width2 = .2;
% % p=plot(DRMeanAutonomous,width2);
% % set(p,'Color',[1 0.4 1])
% % hold on

lgd=legend({'random reuse-single cell','spatial reuse-single cell','random reuse-double cell','spatial reuse-double cell'},'FontSize',15,'Location','northwest');
set(gca,'FontSize',20);
xlabel('# Broadcast Groups','FontSize',20)
ylabel('CMDR (%)','FontSize',18) 
axis([1 20 0 100])
daspect([1 8 1])

x1=[1,5,10,15,20];
x2=[1,5,10,15,20];
set(gca,'XTick',x1)
set(gca,'XTickLabel',x2)




 