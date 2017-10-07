function SNR = SNR(Image,Denoised)

Num = Image.^2+Denoised.^2;
Num = sum(Num(:));
Den = (Image-Denoised).^2;
Den = sum(Den(:));
SNR = 20*log10(Num/Den);
end


