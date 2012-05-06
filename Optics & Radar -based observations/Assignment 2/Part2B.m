clear all;
close all;

data_3_len = 110;
data_4_len = 111;
data_5_len = 120;

data_3 = importdata('Codes/TXT_20081020_test3.FCA');
data_4 = importdata('Codes/TXT_20081020_test4.FCA');
data_5 = importdata('Codes/TXT_20081020_test5.FCA');

%% Compare coding techniques
plotSNR(data_3, data_3_len, 'Barker coding data', '2008-10-20', 3);
plotSNR(data_4, data_4_len, 'complementary coding data', '2008-10-20', 3);
plotSNR(data_5, data_5_len, 'uncoded data', '2008-10-20', 3);

%% Estimate horizontal wind values and directions
plotWind(data_3, data_3_len, 'Barker coding', '2008-10-20', 3);
plotWind(data_4, data_4_len, 'complementary coding', '2008-10-20', 3);
plotWind(data_5, data_5_len, 'uncoded', '2008-10-20', 3);