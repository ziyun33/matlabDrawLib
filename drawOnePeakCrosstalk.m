%% 绘图参数填写
clear
xLabel = "Distance";
yLabel = "Normalized Intensity";
Legend = "NIR-IIx";
% lineColor = [0 0.4470 0.7410]; % 蓝
% lineColor = [0.8500 0.3250 0.0980]; % 橙
lineColor = [0.4660 0.6740 0.1880]; % 绿
% lineColor = [0.9290 0.6940 0.1250]; % 黄
CrosstalkPrecision = 2; % Crosstalk 保留位数

%% 选取文件，并读入数据
[file,path] = uigetfile({'*.csv';'*.txt';'*.xlsx';'*.*'});
FullFileName = [path, file];
DataInput = readmatrix(FullFileName);
x = DataInput(:,1);
y = DataInput(:,2);
y = (y-min(y))/(max(y)-min(y));  % 归一化

%% 查找最明显的局部最小值及最大值，即为“谷”和“峰”
[TF1,P1] = islocalmin(y,"MaxNumExtrema",1);
% [TF2,P2] = islocalmax(y,"MaxNumExtrema",2);
[TF2,P2] = islocalmax(y,"MaxNumExtrema",2,'MinSeparation',20,'SamplePoints',x);

%% 求解信噪比
[ymax, ymaxIndex] = max(y);
ylocalmaxIndex = find(TF2==1);
ylocalmax = y(ylocalmaxIndex);
yS = max(ylocalmax);
ySIndex = ylocalmaxIndex(find(ylocalmax==yS));
yB = min(ylocalmax);
yBIndex = ylocalmaxIndex(find(ylocalmax==yB));
Crosstalk = yB/yS;
Crosstalk = round(Crosstalk, CrosstalkPrecision);

%% 绘图
figure1 = figure;
axes1 = axes('Parent',figure1);
plot(x,y,"Color",lineColor,'linewidth',5) % 绘制原数据
hold on
xl = xlim;
axis([x(1),x(end),-0.1,1.1])
xl = xlim; % x坐标轴范围
yl = ylim; % y坐标轴范围
set(gca,'looseInset',[0.1 0.1 0.05 0.05]);% 宽度方向空白区域0.15， 高度方向空白区域0.15
ArrowX = 0.1+0.6*[ylocalmaxIndex(1)/(xl(2)-xl(1)),ylocalmaxIndex(1)/(xl(2)-xl(1))]; % 箭头x坐标
ArrowY = 0.1+[1.15*(yB-yl(1))/(yl(2)-yl(1)),0.85*(yS-yl(1))/(yl(2)-yl(1))]; % 箭头y坐标
textX = 2.5*(xl(2)-xl(1))*(ArrowX(1)-0.1);
textY = (yS + yB)/2;
line1X = [ArrowX(1),0.1+0.85*ySIndex/(xl(2)-xl(1))];
line1Y = 0.1+0.85*[(yS-yl(1))/(yl(2)-yl(1)),(yS-yl(1))/(yl(2)-yl(1))];
line2X = [ArrowX(1),0.1+0.85*yBIndex/(xl(2)-xl(1))];
line2Y = 0.1+1.15*[(yB-yl(1))/(yl(2)-yl(1)),(yB-yl(1))/(yl(2)-yl(1))];

for i = 1:1
    CrosstalkText = strcat("Crosstalk = ",string(Crosstalk));
    an = annotation('doublearrow',ArrowX,ArrowY,'LineWidth',4,...
    'Head2Width',12,...
    'Head2Length',10,...
    'Head1Width',12,...
    'Head1Length',10); % 绘制双箭头
    text(textX,textY,CrosstalkText,...
        'FontWeight','bold','FontSize',18) % 绘制文本
    annotation(figure1,'line',line1X,line1Y,'LineWidth',2,'LineStyle','--'); % 绘制虚线
    annotation(figure1,'line',line2X,line2Y,'LineWidth',2,'LineStyle','--'); % 绘制虚线
end

xlabel(xLabel)
ylabel(yLabel)
set(axes1,'FontSize',18,'FontWeight','bold','LineWidth',1);
legend1 = legend(Legend);
set(legend1,'FontSize',18,...
    'Position',[0.717023806509518 0.872698426526693 0.225357146058764 0.0819047636304584],...
    'EdgeColor','none','Color','none');


