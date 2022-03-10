
%PART A
G = zeros(8,8); 
C = zeros(8,8); 
b = zeros(8,1); 
R1 =1;
R2 = 2;
c = 0.25;
R3=10;
L=0.2;
alpha = 100;
R4=0.1;
R0 = 1000;

G(1,1) = 1/R1;
G(2,1) = -1/R1;
G(1,2) = -1/R1;
G(2,2) = 1/R1+1/R2;
G(3,3) = 1/R3;
G(4,4)=1/R4;
G(5,5)=1/R0+1/R4;
G(4,5)=-1/R4;
G(5,4)=-1/R4;
G(1,6)=1;
G(6,1)=1;
G(7,2)=1;
G(2,7)=1;
G(3,7)=-1;
G(7,3)=-1;
G(8,3)=-alpha/R3;
G(8,4)=1;
G(4,8)=1;

C(1,1)=c;
C(2,2)=c;
C(1,2)=-c;
C(2,1)=-c;
C(7,7)=-L;

%Part B:  For the DC Case
inputV = linspace(-10,10,100);
v3 = zeros(length(inputV),1);
v0 = zeros(length(inputV),1);
for count = 1:length(inputV)
    b(6)=inputV(count);
    X=G\b;
    v3(count) = X(3);
    v0(count) = X(5);
end

figure(1)
plot(inputV,v3);
xlabel('V1')
ylabel('V3')
title('V3 vs V1')

figure(2)
plot(inputV,v0);
xlabel('V1')
ylabel('V0')
title('V0 vs V1')

% PART C: For the AC Case Sweep, Plot frequency
f = linspace(0, 10000, 1000);
v0 = zeros(length(f),1);
gainDB=zeros(length(f),1);
for count=1:length(f)
    X=[];
    s = 1i*2*pi*f(count);
    X=inv((G+((s).*C)))*b; 
    v0(count) = abs(X(5));   
    
    gainDB(count) = 20*log10(abs(X(5))/abs(X(1)));
end

figure(3)
plot(2*pi*f,v0);
xlabel('Frequency (rads/sec)')
ylabel('V0')
title('Plot of AC with v0')

figure(4)
plot(2*pi*f, gainDB);
xlabel('Frequency ')
ylabel('Gain')
title('AC plot of Gain');

% PART D: Plot for the Histogram 
v0 = zeros(length(f),1);
gainDB=zeros(length(f),1);
for count=1:length(gainDB)
    X=[];
    perturbation = randn()*0.05;
    C(1,1)=c*perturbation;
    C(2,2)=c*perturbation;
    C(1,2)=-c*perturbation;
    C(2,1)=-c*perturbation;

    s = 1i*2*pi*1;
    X=inv((G+((s).*C)))*b; 
    v0(count) = abs(X(5));   
    gainDB(count) = 20*log10(abs(X(5))/abs(X(1)));
end
figure;
hist(gainDB,80);
xlabel('The gain')
ylabel('The count')
title('Histogram showing gain on C')


