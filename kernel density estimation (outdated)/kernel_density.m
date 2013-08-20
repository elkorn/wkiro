## kernel_density: multivariate kernel density estimator
##
## usage:
##       dens = kernel_density(eval_points, data, bandwidth)
##
## inputs:
##       eval_points: PxK matrix of points at which to calculate the density
##       data: NxK matrix of data points
##       bandwidth: positive scalar, the smoothing parameter. The fit
##               is more smooth as the bandwidth increases.
##       kernel (optional): string. Name of the kernel function. Default is
##               Gaussian kernel.
##       prewhiten bool (optional): default false. If true, rotate data
##               using Choleski decomposition of inverse of covariance,
##               to approximate independence after the transformation, which
##               makes a product kernel a reasonable choice.
##       do_cv: bool (optional). default false. If true, calculate leave-1-out
##                density for cross validation
## outputs:
##       dens: Px1 vector: the fitted density value at each of the P evaluation points.
##
## References:
## Wand, M.P. and Jones, M.C. (1995), 'Kernel smoothing'.
## http://www.xplore-stat.de/ebooks/scripts/spm/html/spmhtmlframe73.html

function z = kernel_density(eval_points, data, bandwidth, kernel, prewhiten, do_cv)

    if nargin < 2; error("kernel_density: at least 2 arguments are required"); endif

    n = rows(data);
    k = columns(data);

    # set defaults for optional args
    if (nargin < 3) bandwidth = (n ^ (-1/(4+k))); endif # bandwidth - see Li and Racine pg. 26
    if (nargin < 4) kernel = "kernel_normal"; endif # what kernel?
    if (nargin < 5) prewhiten = false; endif    # automatic prewhitening?
    if (nargin < 6) do_cv = false; endif        # ordinary or leave-1-out

    nn = rows(eval_points);
    n = rows(data);
    if prewhiten
        H = bandwidth*chol(cov(data));
    else
        H = bandwidth;
    endif

    # Inverse bandwidth matrix H_inv
    H_inv = inv(H);

    # weight by inverse bandwidth matrix
    eval_points = eval_points*H_inv;
    data = data*H_inv;

    points_per_node = nn;  do the all on this node
    z = kernel_density_nodes(eval_points, data, do_cv, kernel, points_per_node, computenodes, debug);
    z = z*det(H_inv);
endfunction
