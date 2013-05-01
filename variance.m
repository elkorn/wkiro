function out = variance(in)
%VARIANCE Knuth's variance algorithm
    n = 1;
    mean = 0;
    M2 = 0;
    
    for i = 1 : length(in)
       x = in(i);
       delta = x - mean;
       mean = mean + delta/n;
       M2 = M2 + delta * (x - mean);
       n = n+1;
    end
    
    out = M2 / (n-1);
end

