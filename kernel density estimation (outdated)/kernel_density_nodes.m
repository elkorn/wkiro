## kernel_density_nodes: for internal use by kernel_density - does calculations on nodes

function z = kernel_density_nodes(eval_points, data, do_cv, kernel, points_per_node)

    startblock = 1;
    endblock = rows(eval_points);

    # the block of eval_points this node does
    myeval = eval_points(startblock:endblock,:);
    nn = rows(myeval);
    n = rows(data);

    W = __kernel_weights(data, myeval, kernel);
    if (do_cv)
        W = W - diag(diag(W));
        z = sum(W,2) / (n-1);
    else
        z = sum(W,2) / n;
    endif

    if debug
        printf("z on node %d: \n", myrank);
        z'
    endif
endfunction


