function y = kde(x, t, kernelfn)
%KDE kernel density estimation of a given function.
%   x - input function data
%   kernelfn - the kernel estimation function to be used

    n = length(x);
    nT = length(t);
    y = zeros(1,nT);
    h = nrd0(x);
    for i = 1 : nT
        for j = 1 : n
            y(i) = y(i) + kernelfn((t(i) - x(j))/h);
        end
    end
     y = y ./ (n*h);
end

