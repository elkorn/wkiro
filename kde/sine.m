function y = sine( Fs, F )
%SINE Summary of this function goes here
%   Detailed explanation goes here
  t=0:1/Fs:15-1/Fs;
 Amp=0.5;
 y=Amp*sin(2*pi*t*F);
end

