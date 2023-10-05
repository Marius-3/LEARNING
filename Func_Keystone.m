function [Data, f] = Func_Keystone(raw_Data, Nfast, Fs, Fc, raw_t)
%% 
% Input
% 脉冲压缩后数据  rawData 大小：Mslow*Nfast
% 快时间长度      Nfast
% 采样频率        Fs
% 载频            Fc
% 慢时间坐标轴    t = -T/2:1/PRF:T/2;  
% Ouput
% keystone变换后数据（距离校正），距离维频率坐标轴
%% 
R_fft_Data = fftshift(fft(raw_Data, Nfast, 2), 2);  %将原始数据沿距离维FFT，频率轴居中
f = linspace(-Fs/2, Fs/2, size(R_fft_Data, 2));  %f为距离维频率坐标轴
Data = zeros(size(R_fft_Data));   %存放keystone变换后的数据

for i = 1 : size(R_fft_Data, 2)  %遍历每列
    t = Fc / (Fc + f(i)) * raw_t;  %得到新时间点
    Data(:, i) = interp1(raw_t, R_fft_Data(:, i), t);  %按新得到的时间点做插值处理
end

I = isnan(abs(Data));  %返回插值导致出现NaN的位置，并赋零
Data(I) = 0;
end