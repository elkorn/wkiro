function output_arg = kernel_gaussian(u)
%KERNEL_GAUSSIAN The gaussian kernel.
    e = exp(1);
    output_arg = (sqrt(2*pi)^-1)*(e^(-0.5*u^2));
end

