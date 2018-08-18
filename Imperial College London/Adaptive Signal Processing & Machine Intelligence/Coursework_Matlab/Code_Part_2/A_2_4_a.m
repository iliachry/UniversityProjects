%% 2.4.a

clear all; close all; clc; 

load Trial1.mat; load Trial2.mat; load Trial3.mat

xRRI1 = detrend(xRRI1);
xRRI2 = detrend(xRRI2);
xRRI3 = detrend(xRRI3);

[Px1, f1] = periodogram(xRRI1, rectwin(length(xRRI1)), 2^13, 4);
[Px2, f2] = periodogram(xRRI2, rectwin(length(xRRI2)), 2^13, 4);
[Px3, f3] = periodogram(xRRI3, rectwin(length(xRRI3)), 2^13, 4);

subplot(1,3,1)
plot(f1, mag2db(Px1)); text(0.1274, -25, '\downarrow 0.1274');
text(0.3822, -35, '\downarrow 0.3822'); text(0.7644, -60, '\downarrow 0.7644');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Standard Periodogram of RRI 1';''}); set(gca, 'FontSize', 14 );
ylim([-180, 0])

subplot(1,3,2)
plot(f2, mag2db(Px2)); text(0.4155, -35, '\downarrow 0.4155');
text(0.83, -60, '\downarrow 0.83');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Standard Periodogram of RRI 2';''}); set(gca, 'FontSize', 14 );
ylim([-180, 0])

subplot(1,3,3)
plot(f3, mag2db(Px3)); text(0.125, -5, '\downarrow 0.125');
text(0.25, -35, '\downarrow 0.25'); text(0.375, -50, '\downarrow 0.375');
text(0.5, -60, '\downarrow 0.5'); text(0.625, -70, '\downarrow 0.625');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Standard Periodogram of RRI 3';''}); set(gca, 'FontSize', 14 );
ylim([-180, 0])

[Px1, f1] = pwelch(xRRI1, rectwin(200), 0 , 2^13, 4);
[Px2, f2] = pwelch(xRRI2, rectwin(200), 0 , 2^13, 4);
[Px3, f3] = pwelch(xRRI3, rectwin(200), 0 , 2^13, 4);

figure;
subplot(2,3,1)
plot(f1, mag2db(Px1)); text(0.1274, -25, '\downarrow 0.1274');
text(0.3822, -35, '\downarrow 0.3822'); text(0.7644, -60, '\downarrow 0.7644');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Welch Periodogram of RRI 1';'50 s'}); set(gca, 'FontSize', 14 );
ylim([-180, 0])

subplot(2,3,2)
plot(f1, mag2db(Px2)); text(0.4155, -35, '\downarrow 0.4155');
text(0.83, -60, '\downarrow 0.83');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Welch Periodogram of RRI 2';'50 s'}); set(gca, 'FontSize', 14 );
ylim([-180, 0])

subplot(2,3,3)
plot(f1, mag2db(Px3)); text(0.125, -5, '\downarrow 0.125');
text(0.25, -35, '\downarrow 0.25'); text(0.375, -50, '\downarrow 0.375');
text(0.5, -60, '\downarrow 0.5'); text(0.625, -70, '\downarrow 0.625');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Welch Periodogram of RRI 3';'50 s'}); set(gca, 'FontSize', 14 );
ylim([-180, 0])

[Px1, f1] = pwelch(xRRI1, rectwin(600), 0 , 2^13, 4);
[Px2, f2] = pwelch(xRRI2, rectwin(600), 0 , 2^13, 4);
[Px3, f3] = pwelch(xRRI3, rectwin(600), 0 , 2^13, 4);

subplot(2,3,4)
plot(f1, mag2db(Px1)); text(0.1274, -25, '\downarrow 0.1274');
text(0.3822, -35, '\downarrow 0.3822'); text(0.7644, -60, '\downarrow 0.7644');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Welch Periodogram of RRI 1';'150 s'}); set(gca, 'FontSize', 14 );
ylim([-180, 0])

subplot(2,3,5)
plot(f1, mag2db(Px2));text(0.4155, -35, '\downarrow 0.4155');
text(0.83, -60, '\downarrow 0.83');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Welch Periodogram of RRI 2';'150 s'}); set(gca, 'FontSize', 14 );
ylim([-180, 0])

subplot(2,3,6)
plot(f1, mag2db(Px3)); text(0.125, -5, '\downarrow 0.125');
text(0.25, -35, '\downarrow 0.25'); text(0.375, -50, '\downarrow 0.375');
text(0.5, -60, '\downarrow 0.5'); text(0.625, -70, '\downarrow 0.625');
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'Welch Periodogram of RRI 3';'150 s'}); set(gca, 'FontSize', 14 );
ylim([-180, 0])
