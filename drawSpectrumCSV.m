%% 绘图参数填写
clear
xLabel = "Wavelength (nm)";
yLabel = "Normalized Intensity";
Legend = "1700 QD";
Blue = [0 0.4470 0.7410]; % 蓝
Orange = [0.8500 0.3250 0.0980]; % 橙
Green = [0.4660 0.6740 0.1880]; % 绿
Yellow = [0.9290 0.6940 0.1250]; % 黄
Purple = [0.4940 0.1840 0.5560]; % 紫
lineColor = Blue;

%% 选取文件，并读入数据
[file,path] = uigetfile({'*.csv';'*.txt';'*.xlsx';'*.*'});
FullFileName = [path, file];
DataInput = readmatrix(FullFileName);
x = DataInput(:,1);
y = DataInput(:,2);

y = smooth(y);
y = smooth(y);
y = (y - min(y)) / (max(y) - min(y));

%% 绘图
figure1 = figure;
axes1 = axes('Parent',figure1);
plot(x,y,"Color",lineColor,'linewidth',2) % 绘制原数据
hold on
axis([x(1),x(end),-0.1,1.1])
xlabel(xLabel)
ylabel(yLabel)
set(axes1,'FontSize',18,'FontWeight','bold','LineWidth',1);
legend1 = legend(Legend);
set(legend1,'FontSize',18,...
    'EdgeColor','none','Color','none');