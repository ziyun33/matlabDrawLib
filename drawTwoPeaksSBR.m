%% 绘图参数填写
xLabel = "Pixel";
yLabel = "Gray Value";
Legend = "NIR IIc";
% lineColor = [0 0.4470 0.7410]; % 蓝
% lineColor = [0.8500 0.3250 0.0980]; % 橙
% lineColor = [0.4660 0.6740 0.1880]; % 绿
lineColor = [0.9290 0.6940 0.1250]; % 黄
SBRPrecision = 2; % Crosstalk 保留位数

% 箭头高度有时候会有问题……
yArrowMinParameter = 0.9;
yArrowMaxParameter1 = 0.89;
yArrowMaxParameter2 = 0.85;

%% 选取文件，并读入数据
[file,path] = uigetfile({'*.csv';'*.txt';'*.xlsx';'*.*'});
FullFileName = [path, file];
DataInput = readmatrix(FullFileName);
x = DataInput(:,1);
y = DataInput(:,2);
y = smooth(y);
y = (y-min(y))/(max(y)-min(y));  % 归一化

%% 查找最明显的局部最小值及最大值，即为“谷”和“峰”
[TF1,P1] = islocalmin(y,"MaxNumExtrema",1);
[TF2,P2] = islocalmax(y,"MaxNumExtrema",2);

%% 求解信噪比
[ymax, ymaxIndex] = max(y);
[ymin, yminIndex] = min(y);
ylocalminIndex = find(TF1==1);
ylocalmin = y(ylocalminIndex);
ylocalmaxIndex = find(TF2==1);
ylocalmax = y(ylocalmaxIndex);
SBR1 = (ylocalmax(1)-ymin)/(ylocalmin-ymin);  % 求解第一个信噪比
SBR2 = (ylocalmax(2)-ymin)/(ylocalmin-ymin);  % 求解第二个信噪比
SBR = [SBR1, SBR2];
SBR = round(SBR, SBRPrecision);

%% 绘图
figure1 = figure;
axes1 = axes('Parent',figure1);
plot(x,y,"Color",lineColor,'linewidth',5) % 绘制原数据
hold on
plot(x(TF1),y(TF1),'*') % 绘制最低点
set(gca,'looseInset',[0.1 0.1 0.05 0.05]);% 宽度方向空白区域0.15， 高度方向空白区域0.15
axis([x(1),x(end),-0.1,1.1])
xl = xlim; % x坐标轴范围
yl = ylim; % y坐标轴范围

ArrowX = 0.1+[0.70*ylocalmaxIndex(1)/(xl(2)-xl(1)),0.70*ylocalmaxIndex(1)/(xl(2)-xl(1));...
    1.0*ylocalmaxIndex(2)/(xl(2)-xl(1)),1.0*ylocalmaxIndex(2)/(xl(2)-xl(1))]; % 箭头x坐标
ArrowY = 0.1+[yArrowMinParameter*[(ylocalmin-yl(1))/(yl(2)-yl(1));(ylocalmin-yl(1))/(yl(2)-yl(1))],...
    [yArrowMaxParameter1*(ylocalmax(1)-yl(1))/(yl(2)-yl(1));yArrowMaxParameter2*(ylocalmax(2)-yl(1))/(yl(2)-yl(1))]]; % 箭头y坐标

textX = [0.05*(xl(2)-xl(1))*(mean(ArrowX(1,:)-0.1)),1.20*(xl(2)-xl(1))*(mean(ArrowX(2,:)-0.1))];
textY = (ylocalmax + ylocalmin)/2;

line1X = [ArrowX(1,1),0.1+0.85*ylocalmaxIndex(1)/(xl(2)-xl(1));...
    ArrowX(2,1),0.1+0.85*ylocalmaxIndex(2)/(xl(2)-xl(1))];
line1Y = [ArrowY(1,2),ArrowY(1,2);...
    ArrowY(2,2),ArrowY(2,2)];
line2X = [ArrowX(1,1),0.1+0.85*ylocalminIndex/(xl(2)-xl(1));...
    ArrowX(2,1),0.1+0.85*ylocalminIndex/(xl(2)-xl(1))];
line2Y = ArrowY(1,1) * ones(2,2); 

for i = 1:2
    SBRtext = strcat("SBR=",string(SBR(i)));
    an = annotation('doublearrow',ArrowX(i,:),ArrowY(i,:),'LineWidth',4,...
    'Head2Width',12,...
    'Head2Length',10,...
    'Head1Width',12,...
    'Head1Length',10); % 绘制双箭头
    text(textX(i),textY(i),SBRtext,...
        'FontWeight','bold','FontSize',18) % 绘制文本
    annotation(figure1,'line',line1X(i,:),line1Y(i,:),'LineWidth',2,'LineStyle','--'); % 绘制虚线
    annotation(figure1,'line',line2X(i,:),line2Y(i,:),'LineWidth',2,'LineStyle','--'); % 绘制虚线
end

xlabel(xLabel)
ylabel(yLabel)
set(axes1,'FontSize',18,'FontWeight','bold');
legend1 = legend(Legend);
set(legend1,'FontSize',18,'EdgeColor','none','Color','none',...
    'Position',[0.714166663465046 0.865079363353669 0.225357146058764 0.0819047636304584]);