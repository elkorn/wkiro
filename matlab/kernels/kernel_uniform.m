function output_arg = kernel_uniform(u)
%kernel_uniform The uniform kernel.

    output_arg = 0.5 * (abs(u) <= 1);
end

