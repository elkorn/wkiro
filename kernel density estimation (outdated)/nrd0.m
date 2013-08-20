function y = nrd0(x)
%NRD0 alternative bandwidth selector.
%   x - input function data
    hi = sqrt(var(x));
    lo = min(hi, iqr(x,1,3) / 1.34);
    if ~lo
        lo = hi;
        if ~lo
            lo = abs(x(2));
            if ~lo
                lo = 1;
            end
        end
    end
    y = 0.9 * lo * (length(x)^(-1/5));
end