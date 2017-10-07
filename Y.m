clc
close all;
clear all;

% Configuration
% Image = phantom;
% Image = imread('Liver.png');
% Image = imread('Kidney.png');
Image = imread('Cardiac.png');
Image = double(Image(:,:,1));
Image = Image+mean(Image(:));
Image = Image/max(Image(:));
Noisy = imnoise(Image,'speckle',0.16);
tic

% % Test1 Pixelwise NLM
% Denoised = PSNLM(Noisy,1,5,0.2);

% Test2 Blockwise NLM
Denoised1 = BSNLM(Noisy,1,5,0.8);

% Test3 Lee
Denoised2 = LEE(Noisy);

% Test4 KUAN
Denoised3 = KUAN(Noisy,50);

% Results
toc
% imshow([Image,Noisy,Denoised],[]);
imshow([Image],[]);
figure
imshow([Noisy],[]);
figure
imshow([Denoised1],[]);
figure
imshow([Denoised2],[]);
figure
imshow([Denoised3],[]);

% MSE = norm(Image-Denoised,'fro')/numel(Image);
% PSNR = 10*log10(255^2/MSE)

SNR0=SNR(Image,Noisy)
SNR1=SNR(Image,Denoised1)
SNR2=SNR(Image,Denoised2)
SNR3=SNR(Image,Denoised3)




