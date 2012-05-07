clear all;
close all;

data_1_len = 120;
data_2_len = 15;

data_1 = importdata('Height resolution/TXT_20081020_test1.FCA');
data_2 = importdata('Height resolution/TXT_20081020_test2.FCA');

plotSNR(data_1, data_1_len, '150 m Height Resolution', 2);
plotSNR(data_2, data_2_len, '1200 m Height Resolution', 2);
set(figure(1000), 'Name', 'SNR (2008-10-20)');