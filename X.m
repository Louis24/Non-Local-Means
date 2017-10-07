clc
close all;
clear all;

% Configuration
Image = double(imread('lena.tif'));
Noisy = Image+10*randn(size(Image));
tic

% % Test1 ���Ĳ����е��㷨
% Denoised = NLM1(Image,1,5,10);
% 
% % Test2 �����㷨 Yue Wu
% Denoised = NLM2(Image,1,5,10);
% 
% % Test3 ����㷨 Zhang Xuande
% Denoised = NLM3(Image,1,5,10);
% 
% % Test4 ��֪����ʲô�㷨-_- Christian Desrosiers 
% Denoised = NLM4(Image,1,5,10);

% Results
toc
imshow([Noisy,Denoised],[]);
MSE = norm(Image-Denoised,'fro')/numel(Image);
PSNR = 10*log10(255^2/MSE)




