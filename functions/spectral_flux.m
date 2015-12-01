function SF = spectral_flux(S)

[m,n]=size(S);
auxDif=zeros(m,n-1);

for i=1:(n-1)
    auxDif(:,i)=abs(S(:,i+1))-abs(S(:,i));
end

auxSF=zeros(1,n-1);
for i=1:n-1
    for j=1:m
        auxSF(i)=auxSF(i)+half_wave_rectifier(auxDif(j,i))^2;
    end
end

SF=auxSF;
