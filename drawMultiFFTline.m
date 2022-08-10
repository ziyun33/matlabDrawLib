xLabel = "Frequency";
yLabel = "Intensity";
Legends = ["900-1000 nm", "1000-1100 nm","1100-1300 nm",...
    "1300-1400 nm","1400-1500 nm","1500-1700 nm","1700-1880 nm"];

Blue = [0 0.4470 0.7410]; % 蓝
Orange = [0.8500 0.3250 0.0980]; % 橙
Green = [0.4660 0.6740 0.1880]; % 绿
Yellow = [0.9290 0.6940 0.1250]; % 黄
Purple = [0.4940 0.1840 0.5560]; % 紫
SkyBlue = [0.3010 0.7450 0.9330]; % 天蓝
Red = [0.6350 0.0780 0.1840]; % 红

lineColors = [Blue; Orange; Yellow; Green; Purple; SkyBlue; Red];

imgNumber = 7;

FileNameList = [];
for i = 1:imgNumber
    [file,path] = uigetfile({'*.tif';'*.*'});
    FullFileName = [path, file];
    FileNameList = [FileNameList,  convertCharsToStrings(FullFileName)];
end

%% 新建图窗
figure1 = figure;
axes1 = axes('Parent',figure1);

%%
for i = 1:imgNumber
    img=imread(FileNameList(i));
    [img_out, y] = imgfft(img);
    plot(0:length(y)-1,y,"Color",lineColors(i, :),'linewidth',2);
    hold(axes1, "on")
end

%% 绘制图像剩余部分
% axis([x(1),x(end),-0.1,1.1])
xlabel(xLabel)
ylabel(yLabel)
set(axes1,'FontSize',18,'FontWeight','bold','LineWidth',1);
legend1 = legend(Legends);
set(legend1,'FontSize',18,...
    'EdgeColor','none','Color','none');