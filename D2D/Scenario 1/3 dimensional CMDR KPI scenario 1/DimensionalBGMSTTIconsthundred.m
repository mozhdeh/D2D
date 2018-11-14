%reading from the matrices: DRrep1-7, PERrep1-7, linesrep1-7, serep1-7

DRrep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/DRrep1.txt');
DRrep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/DRrep2.txt');
DRrep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/DRrep3.txt');
DRrep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/DRrep4.txt');
DRrep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/DRrep5.txt');
DRrep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/DRrep6.txt');
DRrep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/DRrep7.txt');

PERrep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/PERrep1.txt');
PERrep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/PERrep2.txt');
PERrep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/PERrep3.txt');
PERrep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/PERrep4.txt');
PERrep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/PERrep5.txt');
PERrep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/PERrep6.txt');
PERrep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/PERrep7.txt');

serep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/serep1.txt');
serep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/serep2.txt');
serep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/serep3.txt');
serep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/serep4.txt');
serep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/serep5.txt');
serep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/serep6.txt');
serep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/serep7.txt');

linesrep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/linesrep1.txt');
linesrep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/linesrep2.txt');
linesrep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/linesrep3.txt');
linesrep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/linesrep4.txt');
linesrep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/linesrep5.txt');
linesrep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/linesrep6.txt');
linesrep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/linesrep7.txt');


meanMatrixDR = (DRrep1+DRrep2+DRrep3+DRrep4+DRrep5+DRrep6+DRrep7)/7;
meanMatrixPER = (PERrep1+PERrep2+PERrep3+PERrep4+PERrep5+PERrep6+PERrep7)/7
meanMatrixPER=meanMatrixPER*100;
meanMatrixse = (serep1+serep2+serep3+serep4+serep5+serep6+serep7)/7;
meanMatrixlines = (linesrep1+linesrep2+linesrep3+linesrep4+linesrep5+linesrep6+linesrep7)/7;

%DRMean matrix, modified (descending order in two dimesnions),imported here
DRMeanExtension=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/DRMean.txt');

%PLRMean matrix, modified (descending order in two dimesnions),imported here
PLRMeanExtension=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtension/3D-BGMSTTIconst100msExt/PLRMean.txt');

%reading from the matrices: DRrep1-6auto, PERrep1-6auto, linesrep1-6auto,
%serep1-6auto
DRrep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep1auto.txt');
DRrep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep2auto.txt');
DRrep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep3auto.txt');
DRrep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep4auto.txt');
DRrep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep5auto.txt');
DRrep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRrep6auto.txt');

PERrep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERrep1auto.txt');
PERrep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERrep2auto.txt');
PERrep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERrep3auto.txt');
PERrep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERrep4auto.txt');
PERrep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERrep5auto.txt');
PERrep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERrep6auto.txt');

serep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/serep1auto.txt');
serep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/serep2auto.txt');
serep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/serep3auto.txt');
serep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/serep4auto.txt');
serep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/serep5auto.txt');
serep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/serep6auto.txt');

linesrep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesrep1auto.txt');
linesrep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesrep2auto.txt');
linesrep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesrep3auto.txt');
linesrep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesrep4auto.txt');
linesrep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesrep5auto.txt');
linesrep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesrep6auto.txt');

meanMatrixDRAuto = (DRrep1auto+DRrep2auto+DRrep3auto+DRrep4auto+DRrep5auto+DRrep6auto)/6;
meanMatrixPERAuto = (PERrep1auto+PERrep2auto+PERrep3auto+PERrep4auto+PERrep5auto+PERrep6auto)/6;
meanMatrixseAuto = (serep1auto+serep2auto+serep3auto+serep4auto+serep5auto+serep6auto)/6;
meanMatrixlinesAuto = (linesrep1auto+linesrep2auto+linesrep3auto+linesrep4auto+linesrep5auto+linesrep6auto)/6;

%DRMean matrix, modified (descending order in two dimesnions),
%imported here
DRMeanAutonomous=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRMeanAuto.txt');

%PLRMean matrix, modified (descending order in two dimesnions),
%imported here
PLRMeanAutonomous=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PLRMeanAuto.txt');

%%%%%%%%%%%%%%%%Delivery ratio graph for 
%autonomous & extension(spatial reuse, without rate adjustment)
%intracell & intercell effects
%100 ms SC-Period
%100 messages, varying message size
width1 = .05;
p=bar3(DRMeanExtension,width1);
%set(p,'FaceColor',[1 0.78 0.80])%pink
set(p,'FaceColor',[0,0.6,1])%light magneta
hold on

width2 = .2;
p=bar3(DRMeanAutonomous,width2);
set(p,'FaceColor',[1 0.4 1])
hold on

lgd=legend({'spatial reuse','random'},'FontSize',20);
set(lgd,'FontSize',30);
set(gca,'FontSize',18)
xlabel('MS(#packets)','FontSize',22)
ylabel('# Broadcast Groups','FontSize',22)
zlabel('CMDR (%)','FontSize',22) 
axis([1 6 1 20 0 100])
x1=[1,2,3,4,5,6];
x2=[5,7,9,11,13,15];
set(gca,'XTick',x1)
set(gca,'XTickLabel',x2)
set(get(gca,'XLabel'),'Rotation',18);
set(get(gca,'YLabel'),'Rotation',-35);
% set(gca,'YTick',y)
% set(gca,'YTickLabel',y)
%daspect([1 2 10])
%daspect([1 5 25])
daspect([2 5 30])
grid on 
%%%%%%%%%%%%%%%%PLR graph for 
%autonomous & extension(spatial reuse, without rate adjustment)
%intracell & intercell effects
%100 ms SC-Period
%100 messages, varying message size
% % width1 = .05;
% % p=bar3(PLRMeanAutonomous,width1);
% % %set(p,'FaceColor',[0,0,1])
% % set(p,'FaceColor',[1 0.4 1])%light magneta
% % hold on
% % 
% % width2 = .2;
% % p=bar3(PLRMeanExtension,width2);
% % set(p,'FaceColor',[0,0.6,1])
% % hold on
% % 
% % lgd=legend({'spatial reuse','random'},'FontSize',20);
% % set(lgd,'FontSize',30);
% % set(gca,'FontSize',18)
% % xlabel('MS(#packets)','FontSize',22)
% % ylabel('# Broadcast Groups','FontSize',18)
% % zlabel('PLR (%)','FontSize',18) 
% % axis([1 6 1 20 0 100])
% % x1=[1,2,3,4,5,6];
% % x2=[5,7,9,11,13,15];
% % set(gca,'XTick',x1)
% % set(gca,'XTickLabel',x2)
% % set(get(gca,'XLabel'),'Rotation',18);
% % set(get(gca,'YLabel'),'Rotation',-35);
% % % set(gca,'YTick',y)
% % % set(gca,'YTickLabel',y)
% % %daspect([1 2 10])
% % %daspect([1 5 25])
% % daspect([2 5 30])
% % grid on 





 