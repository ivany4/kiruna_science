clear all;
close all;

data_1_len = 120;
data_2_len = 15;

data_1 = importdata('Height resolution/TXT_20081020_test1.FCA');
data_2 = importdata('Height resolution/TXT_20081020_test2.FCA');

figure
ax(1) = plotSNR(data_1, data_1_len, 'SNR for a 150 m Height Resolution (2008-10-20)', 1,2,1);
ax(2) = plotSNR(data_2, data_2_len, 'SNR for a 1200 m Height Resolution (2008-10-20)', 1,2,2);

h = colorbar;
set(h, 'Position', [.924 .11 .0381 .8150])
for i = 1:2
    pos = get(ax(i), 'Position');
    set(ax(i), 'Position', [pos(1) pos(2) 0.85*pos(3) pos(4)]);
end;