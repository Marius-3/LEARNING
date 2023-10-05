function [Data, f] = Func_Keystone(raw_Data, Nfast, Fs, Fc, raw_t)
%% 
% Input
% ����ѹ��������  rawData ��С��Mslow*Nfast
% ��ʱ�䳤��      Nfast
% ����Ƶ��        Fs
% ��Ƶ            Fc
% ��ʱ��������    t = -T/2:1/PRF:T/2;  
% Ouput
% keystone�任�����ݣ�����У����������άƵ��������
%% 
R_fft_Data = fftshift(fft(raw_Data, Nfast, 2), 2);  %��ԭʼ�����ؾ���άFFT��Ƶ�������
f = linspace(-Fs/2, Fs/2, size(R_fft_Data, 2));  %fΪ����άƵ��������
Data = zeros(size(R_fft_Data));   %���keystone�任�������

for i = 1 : size(R_fft_Data, 2)  %����ÿ��
    t = Fc / (Fc + f(i)) * raw_t;  %�õ���ʱ���
    Data(:, i) = interp1(raw_t, R_fft_Data(:, i), t);  %���µõ���ʱ�������ֵ����
end

I = isnan(abs(Data));  %���ز�ֵ���³���NaN��λ�ã�������
Data(I) = 0;
end