%% 绘图参数填写
clear
xLabel = "Wavelength (nm)";
yLabel = "Normalized Intensity";
Legend = "1700 QD";
lineColor = [0 0.4470 0.7410]; % 蓝
% lineColor = [0.8500 0.3250 0.0980]; % 橙
% lineColor = [0.4660 0.6740 0.1880]; % 绿
% lineColor = [0.9290 0.6940 0.1250]; % 黄

%% 选取文件，并读入数据
[file,path] = uigetfile({'*.xml';'*.*'});
FullFileName = [path, file];
DataInput = parseXML(FullFileName);
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

%% 绘图
figure1 = figure;
axes1 = axes('Parent',figure1);
plot(x,y,"Color",lineColor,'linewidth',2) % 绘制原数据
hold on
xlabel(xLabel)
ylabel(yLabel)
set(axes1,'FontSize',18,'FontWeight','bold','LineWidth',1);
legend1 = legend(Legend);
set(legend1,'FontSize',18,...
    'EdgeColor','none','Color','none');