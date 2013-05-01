function test_kernel( input_fn, kernel_fn, bandwidths )
%TEST_KERNELS Summary of this function goes here
%   Detailed explanation goes here\
    n = length(bandwidths);
    width = ceil(n / 2);
    height = mod(n, 2) + 1;
for i = 1:n
    subplot(height,width, i)    
    plot(kde(input_fn,bandwidths(i),kernel_fn))
    title(sprintf('Bandwidth %d', i))
end

end

