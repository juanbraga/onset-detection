%onset-detection 

clear all, close all;

addpath ./dataset
addpath ./dataset/adler_thestudyoforchestration
addpath ./dataset/mirex_competition/sounds/
addpath ./dataset/mirex_competition/goodlabels/
addpath ./functions

wavname = 'sax1.wav';
labelsname = 'sax1.mat';
% filename='allegromolto_dvoraksymph9_firstmovement.wav';
% filename='drum_slowbeat.wav';

[x,fs,nbits]=wavread(wavname);
t=0:1/fs:(length(x)-1)/fs;  

labels=load(labelsname);

figure('Name', 'SoundWave'), plot(t, x, 'r'), grid on,
title('SoundWave'), xlabel('seg'), ylabel('amplitude');
% axis tight, hold on,
axis([0 max(t) -1 1]), hold on,
for i=1:length(labels.labels_time)
    aux_label=labels.labels_time(i);
    line([aux_label aux_label], [-1 1]);
end
hold off

%%
window_length1 = 2*2048;
hop1 = window_length1/2;
nfft1 = 2*window_length1;
n_overlap1 = window_length1 - hop1;

[S1,F1,T1]=spectrogram(x(:,1),window_length1,n_overlap1,nfft1,fs,'yaxis');
logS1=10*log10(abs(S1));

figure('Name','Espectrograma'), imagesc(T1,F1,logS1), axis xy,
title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)');
hold on,
for i=1:length(labels.labels_time)
    aux_label=labels.labels_time(i);
    line([aux_label aux_label], [0 22050]);
end
hold off

%%
window_length2 = 64;
hop2 = window_length2/2;
nfft2 = 2*window_length2;
n_overlap2 = window_length2 - hop2; 

[S2,F2,T2]=spectrogram(x(:,1),window_length2,n_overlap2,nfft2,fs,'yaxis');
logS2=20*log10(abs(S2));

figure('Name','Espectrograma'), imagesc(T2,F2,logS2), axis xy,
title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)');
hold on,
for i=1:length(labels.labels_time)
    aux_label=labels.labels_time(i);
    line([aux_label aux_label], [0 22050]);
end
hold off

%%
SF1=spectral_flux(S1);

figure('Name','SpectralFlux'), 
subplot(2,1,1), plot(t, x, 'r'), grid on,
title('SoundWave'), xlabel('seg'), ylabel('amplitude');
axis([0 max(t) -1 1]), hold on,
for i=1:length(labels.labels_time)
    aux_label=labels.labels_time(i);
    line([aux_label aux_label], [-1 1]);
end
hold off
subplot(2,1,2), plot(T1(1:end-1),SF1), grid on,
title('SpectralFlux'), xlabel('seg'), ylabel('amplitude');
axis tight;

%%
SF2=spectral_flux(S2);

figure('Name','SpectralFlux'), 
subplot(2,1,1), plot(t, x, 'r'), grid on,
title('SoundWave'), xlabel('seg'), ylabel('amplitude');
axis([0 max(t) -1 1]), hold on,
for i=1:length(labels.labels_time)
    aux_label=labels.labels_time(i);
    line([aux_label aux_label], [-1 1]);
end
hold off
subplot(2,1,2), plot(T2(1:end-1),SF2), grid on,
title('SpectralFlux'), xlabel('seg'), ylabel('amplitude');
axis tight;