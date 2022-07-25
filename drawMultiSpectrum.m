%% 绘图参数填写
clear

spectrumNumber = 3;

xLabel = "Wavelength (nm)";
yLabel = "Normalized Intensity";
Legends = ["1100 QD", "1400 QD", "1700 QD"];

Blue = [0 0.4470 0.7410]; % 蓝
Orange = [0.8500 0.3250 0.0980]; % 橙
Green = [0.4660 0.6740 0.1880]; % 绿
Yellow = [0.9290 0.6940 0.1250]; % 黄

lineColors = [Blue; Orange; Yellow];

%% 选取文件，并读入数据
FileNameList = [];
for i = 1:spectrumNumber
    [file,path] = uigetfile({'*.xml';'*.*'});
    FullFileName = [path, file];
    FileNameList = [FileNameList,  convertCharsToStrings(FullFileName)];
end

xlist = [];
ylist = [];

for i = 1:spectrumNumber
    DataInput = parseXML(FileNameList(i));
    D1 = DataInput.Children(10).Children(2).Children;
    D2 = DataInput.Children(10).Children(4).Children;
    SIZE = length(2:2:length(D1));
    x = zeros(1,SIZE);
    y = zeros(1,SIZE);

    for i = 1:SIZE
        x(i) = (str2double(D1(2*i).Children.Data));
        y(i) = (str2double(D2(2*i).Children.Data));
    end
    
    y = (y - min(y)) / (max(y) - min(y));
    y = smooth(y);
    
    x = x';
    % y = y';
    
    xlist = [xlist, x];
    ylist = [ylist, y];
    
end



%% 绘图
figure1 = figure;
axes1 = axes('Parent',figure1);
for i = 1:spectrumNumber
    x = xlist(:, i);
    y = ylist(:, i);
    plot(x,y,"Color",lineColors(i, :),'linewidth',2) % 绘制原数据
    hold(axes1, "on")
end
xlabel(xLabel)
ylabel(yLabel)
set(axes1,'FontSize',18,'FontWeight','bold','LineWidth',1);
legend1 = legend(Legends);
set(legend1,'FontSize',18,...
    'EdgeColor','none','Color','none');