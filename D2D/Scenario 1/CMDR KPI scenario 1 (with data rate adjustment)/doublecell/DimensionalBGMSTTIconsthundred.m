%this is the data rate adjustment file to create a 2D graph for DR against BG
%reading from the matrices: DRrateraterep1-5, PERrateraterep1-5, linesrateraterep1-5, serateraterep1-5
%note that these file just include the values for BG=13-20; So, we need to
%import also the ones for BG=1-4(scheduled) and BG=5-12(reuse with no adjustment from previous experiments)
DRraterep1sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep1sched.txt');
DRraterep2sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep2sched.txt');
DRraterep3sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep3sched.txt');
DRraterep4sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep4sched.txt');
DRraterep5sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep5sched.txt');
%taking mean of the scheduled 5 repetitions
Meansched=(DRraterep1sched+DRraterep2sched+DRraterep3sched+DRraterep4sched+DRraterep5sched)/5
%importing the already mean for the case BG=5 to 12 (reuse, but no rate adjustment)
%%DRMeantrunce5to12=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRMeantrunce5-12.txt');

%%%%%note that since these new values of the scheduled repetitions is not
%%%%%good, I use the already generated ones, so instead of importing
%%%%%"DRMeantrunce5to12" (commented above), we import "DRMeantrunce1to12"
DRMeantrunce1to12=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRMeantrunce1-12.txt');

%importing the 5 repetitions for the case BG=13 to 20
DRraterep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep1-13-20.txt');
DRraterep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep2-13-20.txt');
DRraterep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep3-13-20.txt');
DRraterep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep4-13-20.txt');
DRraterep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRraterep5-13-20.txt');
%taking mean of the 5 repetitions for the case BG=13 to 20 (reuse with rate adjustment)
DRMeantrunce13to20=(DRraterep1+DRraterep2+DRraterep3+DRraterep4+DRraterep5)/5;

%modifying the obtained values for DRMeantrunce13to20, in the right order
%and import it here
DRMeantrunce13to20=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRMeantrunce13to20.txt');

%we need to vertically concatenate 3 matrices Meansched, DRMeantrunce5to12 and DRMeantrunce13to20
DRMeanTotal=vertcat(DRMeantrunce1to12,DRMeantrunce13to20)

%in order to compare in a graph, we import here the results for no rate
%adjustment for the same setting
DRMeanTotalNoAdjustment=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRMeanTotalNoAdjustment.txt')

%also in order to compare the curves with the single cell case (spatial
%reuse + rate adjustment), we import the corresponding text file here
DRMeanTotalsinglecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRMeanTotalsingle.txt')


%we also need to import the data rate files "newLCRBCell1raterep-13-20" for
%5 repetitions
LCRBrep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/newLCRBCell1raterep1-13-20.txt');
LCRBrep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/newLCRBCell1raterep2-13-20.txt');
LCRBrep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/newLCRBCell1raterep3-13-20.txt');
LCRBrep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/newLCRBCell1raterep4-13-20.txt');
LCRBrep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/newLCRBCell1raterep5-13-20.txt');
MeanLCRB=(LCRBrep1+LCRBrep2+LCRBrep3+LCRBrep4+LCRBrep5)/5;

%modified MeanLCRB imported from the text file "MeanLCRB.txt"; we don't use
%this directly on the plot, instead we derive the corresponding data rate
%values and note them on the relevant part of the curve
MeanLCRB=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/MeanLCRB.txt');

%we can get from the matrix "MeanLCRB" the corresponding data rate for each
% number of BG:13-20 and later specify it in the graph for delivery ratio


% % % % % % PERraterep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/PERraterep1.txt');
% % % % % % PERraterep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/PERraterep2.txt');
% % % % % % PERraterep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/PERraterep3.txt');
% % % % % % PERraterep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/PERraterep4.txt');
% % % % % % PERraterep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/PERraterep5.txt');
% % % % % % PERraterep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/PERraterep6.txt');
% % % % % % PERraterep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/PERraterep7.txt');
% % % % % % 
% % % % % % seraterep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/seraterep1.txt');
% % % % % % seraterep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/seraterep2.txt');
% % % % % % seraterep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/seraterep3.txt');
% % % % % % seraterep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/seraterep4.txt');
% % % % % % seraterep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/seraterep5.txt');
% % % % % % seraterep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/seraterep6.txt');
% % % % % % seraterep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/seraterep7.txt');
% % % % % % 
% % % % % % linesraterep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/linesraterep1.txt');
% % % % % % linesraterep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/linesraterep2.txt');
% % % % % % linesraterep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/linesraterep3.txt');
% % % % % % linesraterep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/linesraterep4.txt');
% % % % % % linesraterep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/linesraterep5.txt');
% % % % % % linesraterep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/linesraterep6.txt');
% % % % % % linesraterep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/linesraterep7.txt');
% % % % % % 
% % % % % % 
% % % % % % meanMatrixDR = (DRraterep1+DRraterep2+DRraterep3+DRraterep4+DRraterep5+DRraterep6+DRraterep7)/7;
% % % % % % meanMatrixPER = (PERraterep1+PERraterep2+PERraterep3+PERraterep4+PERraterep5+PERraterep6+PERraterep7)/7
% % % % % % meanMatrixPER=meanMatrixPER*100;
% % % % % % meanMatrixse = (seraterep1+seraterep2+seraterep3+seraterep4+seraterep5+seraterep6+seraterep7)/7;
% % % % % % meanMatrixlines = (linesraterep1+linesraterep2+linesraterep3+linesraterep4+linesraterep5+linesraterep6+linesraterep7)/7;
% % % % % % 
% % % % % % %DRMean matrix, modified (descending order in two dimesnions),imported here
% % % % % % DRMeanExtension=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/DRMean.txt');
% % % % % % 
% % % % % % %PLRMean matrix, modified (descending order in two dimesnions),imported here
% % % % % % PLRMeanExtension=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/doublecell/PLRMean.txt');
% % % % % % 
% % % % % % %reading from the matrices: DRraterep1-6auto, PERraterep1-6auto, linesraterep1-6auto,
% % % % % % %seraterep1-6auto
% % % % % % DRraterep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRraterep1auto.txt');
% % % % % % DRraterep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRraterep2auto.txt');
% % % % % % DRraterep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRraterep3auto.txt');
% % % % % % DRraterep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRraterep4auto.txt');
% % % % % % DRraterep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRraterep5auto.txt');
% % % % % % DRraterep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRraterep6auto.txt');
% % % % % % 
% % % % % % PERraterep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERraterep1auto.txt');
% % % % % % PERraterep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERraterep2auto.txt');
% % % % % % PERraterep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERraterep3auto.txt');
% % % % % % PERraterep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERraterep4auto.txt');
% % % % % % PERraterep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERraterep5auto.txt');
% % % % % % PERraterep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PERraterep6auto.txt');
% % % % % % 
% % % % % % seraterep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/seraterep1auto.txt');
% % % % % % seraterep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/seraterep2auto.txt');
% % % % % % seraterep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/seraterep3auto.txt');
% % % % % % seraterep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/seraterep4auto.txt');
% % % % % % seraterep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/seraterep5auto.txt');
% % % % % % seraterep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/seraterep6auto.txt');
% % % % % % 
% % % % % % linesraterep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesraterep1auto.txt');
% % % % % % linesraterep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesraterep2auto.txt');
% % % % % % linesraterep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesraterep3auto.txt');
% % % % % % linesraterep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesraterep4auto.txt');
% % % % % % linesraterep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesraterep5auto.txt');
% % % % % % linesraterep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/linesraterep6auto.txt');
% % % % % % 
% % % % % % meanMatrixDRAuto = (DRraterep1auto+DRraterep2auto+DRraterep3auto+DRraterep4auto+DRraterep5auto+DRraterep6auto)/6;
% % % % % % meanMatrixPERAuto = (PERraterep1auto+PERraterep2auto+PERraterep3auto+PERraterep4auto+PERraterep5auto+PERraterep6auto)/6;
% % % % % % meanMatrixseAuto = (seraterep1auto+seraterep2auto+seraterep3auto+seraterep4auto+seraterep5auto+seraterep6auto)/6;
% % % % % % meanMatrixlinesAuto = (linesraterep1auto+linesraterep2auto+linesraterep3auto+linesraterep4auto+linesraterep5auto+linesraterep6auto)/6;
% % % % % % 
% % % % % % %DRMean matrix, modified (descending order in two dimesnions),
% % % % % % %imported here
% % % % % % DRMeanAutonomous=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/DRMeanAuto.txt');
% % % % % % 
% % % % % % %PLRMean matrix, modified (descending order in two dimesnions),
% % % % % % %imported here
% % % % % % PLRMeanAutonomous=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/doublecell/PLRMeanAuto.txt');

%%%%%%%%%%%%%%%%Delivery ratio graph for 
%autonomous & extension(spatial reuse, with rate adjustment)
%intracell & intercell effects
%100 ms SC-Period
%100 messages, MS=15 packets

%single cell case (spatial + adjustment)
p=plot(DRMeanTotalsinglecell);
p.LineWidth=3;
p.Marker='*';
set(p,'Color',[0 0.7 0])%green
hold on

%double cell case (spatial)
p=plot(DRMeanTotalNoAdjustment);
p.LineWidth=3;
p.Marker='x';
%set(p,'Color',[1 0.4 1])%light magneta
set(p,'Color',[1,0,0])%red
hold on

%double cell case (spatial + adjustment)
p=plot(DRMeanTotal);
p.LineWidth=3;
p.Marker='+';
hold on
%set(p,'Color',[1 0.78 0.80])%pink
set(p,'Color',[0,0.6,1])%blue
hold on


lgd=legend({'spatial reuse + rate adjustment single cell','spatial reuse double cell','spatial reuse + rate adjustment double cell'},'FontSize',30);
%set(lgd,'FontSize',30);
set(gca,'FontSize',30);
xlabel('# Broadcast Groups','FontSize',35)
ylabel('CMDR (%)','FontSize',35) 
axis([1 20 0 100])
% % x1=[1,2,3,4,5,6];
% % x2=[5,7,9,11,13,15];
% % set(gca,'XTick',x1)
% % set(gca,'XTickLabel',x2)
% % set(get(gca,'XLabel'),'Rotation',18);
% % set(get(gca,'YLabel'),'Rotation',-35);
% set(gca,'YTick',y)
% set(gca,'YTickLabel',y)
%daspect([1 2 10])
%daspect([1 5 25])
%daspect([2 5 30])
%grid on 

%%%%%%%%%%%%%%%%PLR graph for 
%autonomous & extension(spatial reuse, without rate adjustment)
%intracell & intercell effects
%100 ms SC-Period
%100 messages, varying message size
% % % % width1 = .05;
% % % % p=(PLRMeanAutonomous,width1);
% % % % %set(p,'FaceColor',[0,0,1])
% % % % set(p,'FaceColor',[1 0.4 1])%light magneta
% % % % hold on
% % % % 
% % % % width2 = .2;
% % % % p=bar3(PLRMeanExtension,width2);
% % % % set(p,'FaceColor',[0,0.6,1])
% % % % hold on
% % % % 
% % % % lgd=legend({'spatial reuse','random'},'FontSize',20);
% % % % set(lgd,'FontSize',30);
% % % % set(gca,'FontSize',18)
% % % % xlabel('MS(#packets)','FontSize',22)
% % % % ylabel('# Broadcast Groups','FontSize',22)
% % % % zlabel('PLR(%)','FontSize',22) 
% % % % axis([1 6 1 20 0 70])
% % % % x1=[1,2,3,4,5,6];
% % % % x2=[5,7,9,11,13,15];
% % % % set(gca,'XTick',x1)
% % % % set(gca,'XTickLabel',x2)
% % % % set(get(gca,'XLabel'),'Rotation',18);
% % % % set(get(gca,'YLabel'),'Rotation',-35);
% % % % % set(gca,'YTick',y)
% % % % % set(gca,'YTickLabel',y)
% % % % %daspect([1 2 10])
% % % % %daspect([1 5 25])
% % % % daspect([2 5 30])
% % % % grid on 





 