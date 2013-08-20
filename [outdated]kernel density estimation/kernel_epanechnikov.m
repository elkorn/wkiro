function output_arg = kernel_epanechnikov(u)
%KERNEL_EPANECHNIKOV The Epanechnikov kernel.
    output_arg = (3/4)*(1 - u^2)*(abs(u) <= 1);
end

