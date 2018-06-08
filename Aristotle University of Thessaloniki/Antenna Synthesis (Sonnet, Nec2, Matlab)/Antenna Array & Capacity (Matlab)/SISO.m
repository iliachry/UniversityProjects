% %1-6
% 
%MIMO = Capacity_MIMO(8,8,0.5,0.5,100,100,10);
% 
% C = zeros(1,41);
% 
% for i = 1:41
%     C(i) = log2(i);
% end
% 
% plot(MIMO);
% hold on
% plot(C);
% grid on 
% xlabel('SNR')
% ylabel('Capacity')
% legend('8*8','1*1')

%7-8

%
% d = 1/40:1/40:1
% 
% 
% for i = 1:length(d)
%     C = Capacity_MIMO(8,8,d(i),d(i),100,100,10);
%     MIMO(i)=C(20);
% end
% 
% plot(d,MIMO)
% xlabel('Dipoles Distance');
% ylabel('Capacity')
% title('SNR = 20 dB')
% grid on

%9-10
% 
% scatterers = 10:10:400
% 
% 
% for i = 1:length(scatterers)
%     C = Capacity_MIMO(8,8,0.5,0.5,100,scatterers(i),10);
%     MIMO(i)=C(20);
% end
% 
% plot(scatterers,MIMO)
% xlabel('Number of Scatterers');
% ylabel('Capacity')
% title('SNR = 20 dB')
% grid on

%11

d = 1/10:1/10:5


for i = 1:length(d)
    C = Capacity_MIMO(8,8,d(i),d(i),100,100,10);
    MIMO(i)=C(20);
end

plot(d,MIMO)
xlabel('Dipoles Distance');
ylabel('Capacity')
title('SNR = 20 dB')
grid on



