clc
close all;
clear all;

% Configuration
Image = double(imread('lena.tif'));
Noisy = Image+10*randn(size(Image));
tic

% % Test1 中文博客中的算法
% Denoised = NLM1(Image,1,5,10);
% 
% % Test2 积分算法 Yue Wu
% Denoised = NLM2(Image,1,5,10);
% 
% % Test3 卷积算法 Zhang Xuande
% Denoised = NLM3(Image,1,5,10);
% 
% % Test4 不知道是什么算法-_- Christian Desrosiers 
% Denoised = NLM4(Image,1,5,10);

% Results
toc
imshow([Noisy,Denoised],[]);
MSE = norm(Image-Denoised,'fro')/numel(Image);
PSNR = 10*log10(255^2/MSE)




