# matlabDrawLib

一些matlab绘图文件工具

## 画信背比、串扰率相关曲线

### drawOnePeakCrosstalk
适用于绘制单峰、并求串扰率的图片
### drawTwoPeaksSBR
适用于绘制双峰、并求SBR的图片

## 画光谱相关曲线

### drawSpectrumXML

适用于用一个.xml文件绘制一条光谱

（程序中需要的x，y如何从parseXML.m返回的struct中提取可能需要更改……）

### drawMultiSpectrumXML

适用于用多个.xml文件数据绘制多条光谱

（程序中需要的x，y如何从parseXML.m返回的struct中提取可能需要更改……）

### drawSpectrumCSV

适用于用一个.csv文件绘制一条光谱

### drawMultiSpectrumCSV

适用于用多个.csv文件数据绘制多条光谱

## 辅助函数

### parseXML

适用于解析.xml文件数据，返回一个struct
