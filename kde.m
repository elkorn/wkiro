function y = kde(x, kernelfn)
%KDE kernel density estimation of a given function.
%   x - input function data
%   kernelfn - the kernel estimation function to be used

    n = length(x);
    y = zeros(1,n);
    h = nrd(x);
    for i = 1 : n
        for j = 1 : n
            y(i) = y(i) + kernelfn((x(i) - x(j))/h);
        end
    end
    
    y = y ./ (n*h);
end

