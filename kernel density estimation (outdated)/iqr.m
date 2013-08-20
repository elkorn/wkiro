function y = iqr( input, lo, hi )
%IQR Interquartile range - measure of the difference between given upper 
%    and lower quartiles.  
%   input   - input value range
%   lo      - lower quartile (1-4)
%   hi      - upper quartile (1-4)
    qrtls = quantiles(input, [lo,hi].*0.25);
    y = qrtls(2) - qrtls(1);
end

