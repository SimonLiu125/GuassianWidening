clear all;

%This is to generate graph with 100 NStates
filename = input('Which File?(do not include extension) ','s');
M=load(char([filename,'.txt']));

%Inputs
%Spectrum Finess
DP = input('Please specify desired number of data points ')
%Where the x axis starts
Start = input('Please specify the shortest wavelength for the spectrum ');
%Where the x axis ends
End = input('Please specify the longest wavelength for the spectrum ');
%Specify the FWHM of the spectrum
w = input('Please specify FWHM for the spectrum ');

%Reading data into matrices.
Abs=M(:,1)';
Int=M(:,2)';

%Generating tranformation matrix
lines=ndims(Abs);
Trm=ones(DP,lines);
x=linspace(Start,End,DP)';

%Transformating data matrices
AbsT=Trm.*Abs;
IntT=Trm.*Int;
xT=Trm.*x;

%Gaussian broadening
yT=IntT.*exp(-4*log(2)*(xT.-AbsT).*(xT.-AbsT)/w^2);

%Summation over each data point.
y=sum(yT,2);


%Save results matrix
Results=[x,y];
save('-ascii', char(['Results',filename,'-spec.txt']), 'Results');

%Figure configuraion
Fig = figure;
plot(x,y,'k','linewidth',2);
title(char(['Spectrum of ',filename]),"fontsize", 14);
xlabel('Wavelength / nm','fontsize',12);
ylabel('Intensity','fontsize',12);
box off;

%Save image
saveas(Fig,char(['UV-Vis spectrum of ',filename]),'png');



