function y = nrd( x )
%NRD Rule-of-thumb bandwidth chooser.
%   http://stat.ethz.ch/R-manual/R-patched/library/MASS/html/bandwidth.nrd.html      
% 1.34 and 1.06 are rule-of-thumb constants
    h = iqr(x,1,3) / 1.34; 
    y = 4 * 1.06 * min(sqrt(var(x)), h) * length(x)^(-1/5);
end

