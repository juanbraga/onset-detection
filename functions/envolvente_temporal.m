function env=envolvente_temporal(x,fs)

W=(2*10)/fs;
[b,a]=butter(2,W);
env=filter(b,a,abs(x));

% figure, freqz(b,a,256)
% figure, plot(x,'r'), hold on, grid on,
% plot(env), title('Envolvente Temporal Pasabajos'),
% hold off, grid on;

% env = sliding_rms(abs(x), 1024, 512, 0);
% aux=0:512:length(x);
% figure, plot(x,'r'), hold on, grid on,
% plot(aux(1:end-(length(aux)-length(env))),env), title('Envolvente Temporal Sliding RMS'),
% hold off, grid on;

