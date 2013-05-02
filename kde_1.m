function y = kde_1( x1, x, kernelfn )
%KDE_1 kernel density estimation of a given value.
%KDE 
%   x - input function data
%   kernelfn - the kernel estimation function to be used

    n = 1;
    y = zeros(1,n);
    h = nrd(x);
    for i = 1 : n
        for j = 1 : length(x)
            y(i) = y(i) + kernelfn((x1 - x(j))/h);
        end
    end
    
    y = y ./ (n*h);
end

