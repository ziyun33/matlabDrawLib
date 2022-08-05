%% 绘图参数填写
clear

spectrumNumber = 2;

xLabel = "Wavelength (nm)";
yLabel = "Normalized Intensity";
Legends = ["水性 3号 QD 初测", "水性 3号 QD 重测"];

Blue = [0 0.4470 0.7410]; % 蓝
Orange = [0.8500 0.3250 0.0980]; % 橙
Green = [0.4660 0.6740 0.1880]; % 绿
Yellow = [0.9290 0.6940 0.1250]; % 黄
Purple = [0.4940 0.1840 0.5560]; % 紫

lineColors = [Blue; Orange; Yellow; Green; Purple];

%% 选取文件，并读入数据
FileNameList = [];
for i = 1:spectrumNumber
    [file,path] = uigetfile({'*.csv';'*.txt';'*.xlsx';'*.*'});
    FullFileName = [path, file];
    FileNameList = [FileNameList,  convertCharsToStrings(FullFileName)];
end

%% 新建图窗
figure1 = figure;
axes1 = axes('Parent',figure1);

%% 提取数据，绘制曲线
for i = 1:spectrumNumber
    DataInput = readmatrix(FileNameList(i));
    DataInput = DataInput(:,1:2);
    x = DataInput(:,1);
    x = x(~isnan(x));
    y = DataInput(:,2);
    y = y(~isnan(y));
    
    y = smooth(y);
    y = smooth(y);
    y = (y - min(y)) / (max(y) - min(y));
    
    plotObj = plot(x,y,"Color",lineColors(i, :),'linewidth',2); % 绘制原数据
    hold(axes1, "on")
    index = find(y==1);
    xtip = x(index);
    ytip = y(index);
    datatip(plotObj, "DataIndex", index, "FontSize", 8);
end

%% 绘制图像其他部分
axis([x(1),x(end),-0.2,1.2])
xlabel(xLabel)
ylabel(yLabel)
set(axes1,'FontSize',18,'FontWeight','bold','LineWidth',1);
legend1 = legend(Legends);
set(legend1,'FontSize',18,...
    'EdgeColor','none','Color','none');
