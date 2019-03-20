clear all
close all
clc

figure(1)
hold on;
k=1;
for i=180:1:200
    filename = ['data/angle4-1.95/time_',num2str(i),'.mat'];
    load(filename);
    plot(data(1,:),-data(3,:),'r');
%     figure(2)
%     plot(data(1,:),-data(3,:));
%     clear data;
    x = data(1,:);
    y = data(2,:);
    p = polyfit(x,y,1);
    b(k) = data(4,26);%p(2);
    k = k+1;
end
% x1 = 85:1:110;
% y1 = p(1)*x1+p(2);
% figure(3)
% plot(x,y);
% hold on;
% plot(x1,y1,'r');
% load data/time2