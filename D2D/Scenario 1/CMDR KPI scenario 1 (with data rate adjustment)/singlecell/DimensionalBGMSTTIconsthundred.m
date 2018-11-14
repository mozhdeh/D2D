%SingleCell:
%this is the data rate adjustment file to create a 2D graph for DR against BG
%reading from the matrices: DRrateraterep1-5, PERrateraterep1-5, linesrateraterep1-5, serateraterep1-5
%note that these file just include the values for BG=13-20; So, we need to
%import also the ones for BG=1-4(scheduled) and BG=5-12(reuse with no adjustment from previous experiments)

% % % DRraterep1sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep1sched.txt');
% % % DRraterep2sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep2sched.txt');
% % % DRraterep3sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep3sched.txt');
% % % DRraterep4sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep4sched.txt');
% % % DRraterep5sched=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep5sched.txt');

%taking mean of the scheduled 5 repetitions

%%%Meansched=(DRraterep1sched+DRraterep2sched+DRraterep3sched+DRraterep4sched+DRraterep5sched)/5;

%importing the already mean for the case BG=5 to 12 (reuse, but no rate adjustment)
%%DRMeantrunce5to12=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRMeantrunce5-12.txt');

%%%%%note that since these new values of the scheduled repetitions is not
%%%%%good, I use the already generated ones, so instead of importing
%%%%%"DRMeantrunce5to12" (commented above), we import "DRMeantrunce1to12"

%%%DRMeantrunce1to12=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRMeantrunce1-12.txt');

%importing the 5 repetitions for the case BG=5 to 20
DRraterep1singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep1singlecell.txt');
DRraterep2singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep2singlecell.txt');
DRraterep3singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep3singlecell.txt');
DRraterep4singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep4singlecell.txt');
DRraterep5singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRraterep5singlecell.txt');
%taking mean of the 5 repetitions for the case BG=13 to 20 (reuse with rate adjustment)
DRMeanTotal=(DRraterep1singlecell+DRraterep2singlecell+DRraterep3singlecell+DRraterep4singlecell+DRraterep5singlecell)/5
%exporting this text file, since we later need to use it to plot together
%with results for the double cell case + the case with no rate adjustment(double cell)

% % textFileName = 'DRMeanTotalsingle.txt';
% % dlmwrite(textFileName,DRMeanTotal);
dlmwrite('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRMeanTotalsingle.txt',DRMeanTotal);

%we need to vertically concatenate 3 matrices Meansched, DRMeantrunce5to12 and DRMeantrunce13to20

%%%DRMeanTotal=vertcat(DRMeantrunce1to12,DRMeantrunce13to20)

%in order to compare in a graph, we import here the results for no rate
%adjustment for the same setting
%%%DRMeanTotalNoAdjustment=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRMeanTotalNoAdjustment.txt')


%we also need to import the data rate files "newLCRBCell1raterep-13-20" for
%5 repetitions
LCRBCell1raterep1singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/newLCRBCell1raterep1singlecell.txt');
LCRBCell1raterep2singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/newLCRBCell1raterep2singlecell.txt');
LCRBCell1raterep3singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/newLCRBCell1raterep3singlecell.txt');
LCRBCell1raterep4singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/newLCRBCell1raterep4singlecell.txt');
LCRBCell1raterep5singlecell=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/newLCRBCell1raterep5singlecell.txt');
MeanLCRB=(LCRBCell1raterep1singlecell+LCRBCell1raterep2singlecell+LCRBCell1raterep3singlecell+LCRBCell1raterep4singlecell+LCRBCell1raterep5singlecell)/5;

%we can get from the matrix "MeanLCRB" the corresponding data rate for each
% number of BG:13-20 and later specify it in the graph for delivery ratio


% % % % % % PERraterep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/PERraterep1.txt');
% % % % % % PERraterep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/PERraterep2.txt');
% % % % % % PERraterep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/PERraterep3.txt');
% % % % % % PERraterep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/PERraterep4.txt');
% % % % % % PERraterep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/PERraterep5.txt');
% % % % % % PERraterep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/PERraterep6.txt');
% % % % % % PERraterep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/PERraterep7.txt');
% % % % % % 
% % % % % % seraterep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/seraterep1.txt');
% % % % % % seraterep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/seraterep2.txt');
% % % % % % seraterep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/seraterep3.txt');
% % % % % % seraterep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/seraterep4.txt');
% % % % % % seraterep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/seraterep5.txt');
% % % % % % seraterep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/seraterep6.txt');
% % % % % % seraterep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/seraterep7.txt');
% % % % % % 
% % % % % % linesraterep1=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/linesraterep1.txt');
% % % % % % linesraterep2=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/linesraterep2.txt');
% % % % % % linesraterep3=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/linesraterep3.txt');
% % % % % % linesraterep4=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/linesraterep4.txt');
% % % % % % linesraterep5=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/linesraterep5.txt');
% % % % % % linesraterep6=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/linesraterep6.txt');
% % % % % % linesraterep7=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/linesraterep7.txt');
% % % % % % 
% % % % % % 
% % % % % % meanMatrixDR = (DRraterep1+DRraterep2+DRraterep3+DRraterep4+DRraterep5+DRraterep6+DRraterep7)/7;
% % % % % % meanMatrixPER = (PERraterep1+PERraterep2+PERraterep3+PERraterep4+PERraterep5+PERraterep6+PERraterep7)/7
% % % % % % meanMatrixPER=meanMatrixPER*100;
% % % % % % meanMatrixse = (seraterep1+seraterep2+seraterep3+seraterep4+seraterep5+seraterep6+seraterep7)/7;
% % % % % % meanMatrixlines = (linesraterep1+linesraterep2+linesraterep3+linesraterep4+linesraterep5+linesraterep6+linesraterep7)/7;
% % % % % % 
% % % % % % %DRMean matrix, modified (descending order in two dimesnions),imported here
% % % % % % DRMeanExtension=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/DRMean.txt');
% % % % % % 
% % % % % % %PLRMean matrix, modified (descending order in two dimesnions),imported here
% % % % % % PLRMeanExtension=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsExtensionRateAdjustment/singlecell/PLRMean.txt');
% % % % % % 
% % % % % % %reading from the matrices: DRraterep1-6auto, PERraterep1-6auto, linesraterep1-6auto,
% % % % % % %seraterep1-6auto
% % % % % % DRraterep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/DRraterep1auto.txt');
% % % % % % DRraterep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/DRraterep2auto.txt');
% % % % % % DRraterep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/DRraterep3auto.txt');
% % % % % % DRraterep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/DRraterep4auto.txt');
% % % % % % DRraterep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/DRraterep5auto.txt');
% % % % % % DRraterep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/DRraterep6auto.txt');
% % % % % % 
% % % % % % PERraterep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/PERraterep1auto.txt');
% % % % % % PERraterep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/PERraterep2auto.txt');
% % % % % % PERraterep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/PERraterep3auto.txt');
% % % % % % PERraterep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/PERraterep4auto.txt');
% % % % % % PERraterep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/PERraterep5auto.txt');
% % % % % % PERraterep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/PERraterep6auto.txt');
% % % % % % 
% % % % % % seraterep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/seraterep1auto.txt');
% % % % % % seraterep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/seraterep2auto.txt');
% % % % % % seraterep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/seraterep3auto.txt');
% % % % % % seraterep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/seraterep4auto.txt');
% % % % % % seraterep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/seraterep5auto.txt');
% % % % % % seraterep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/seraterep6auto.txt');
% % % % % % 
% % % % % % linesraterep1auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/linesraterep1auto.txt');
% % % % % % linesraterep2auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/linesraterep2auto.txt');
% % % % % % linesraterep3auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/linesraterep3auto.txt');
% % % % % % linesraterep4auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/linesraterep4auto.txt');
% % % % % % linesraterep5auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/linesraterep5auto.txt');
% % % % % % linesraterep6auto=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/linesraterep6auto.txt');
% % % % % % 
% % % % % % meanMatrixDRAuto = (DRraterep1auto+DRraterep2auto+DRraterep3auto+DRraterep4auto+DRraterep5auto+DRraterep6auto)/6;
% % % % % % meanMatrixPERAuto = (PERraterep1auto+PERraterep2auto+PERraterep3auto+PERraterep4auto+PERraterep5auto+PERraterep6auto)/6;
% % % % % % meanMatrixseAuto = (seraterep1auto+seraterep2auto+seraterep3auto+seraterep4auto+seraterep5auto+seraterep6auto)/6;
% % % % % % meanMatrixlinesAuto = (linesraterep1auto+linesraterep2auto+linesraterep3auto+linesraterep4auto+linesraterep5auto+linesraterep6auto)/6;
% % % % % % 
% % % % % % %DRMean matrix, modified (descending order in two dimesnions),
% % % % % % %imported here
% % % % % % DRMeanAutonomous=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/DRMeanAuto.txt');
% % % % % % 
% % % % % % %PLRMean matrix, modified (descending order in two dimesnions),
% % % % % % %imported here
% % % % % % PLRMeanAutonomous=dlmread('/Users/toor/Desktop/Script_Files/Matlab/D2DBashResultsAutonomous/3D-BGMSTTIconst100msAuto/singlecell/PLRMeanAuto.txt');

%%%%%%%%%%%%%%%%Delivery ratio graph for 
%autonomous & extension(spatial reuse, with rate adjustment)
%intracell & intercell effects
%100 ms SC-Period
%100 messages, MS=15 packets
p=plot(DRMeanTotal);
p.LineWidth=2;
p.Marker='+';
hold on
%set(p,'Color',[1 0.78 0.80])%pink
set(p,'Color',[0,0.6,1])%light magneta
hold on

% % % p=plot(DRMeanTotalNoAdjustment);
% % % p.LineWidth=2;
% % % p.Marker='*';
% % % set(p,'Color',[1 0.4 1])
% % % hold on

lgd=legend({'spatial reuse','random'},'FontSize',20);
set(lgd,'FontSize',30);
set(gca,'FontSize',18);
xlabel('# Broadcast Groups','FontSize',22)
ylabel('Delivery ratio(%)','FontSize',22) 
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
% % % % p=bar3(PLRMeanAutonomous,width1);
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





 