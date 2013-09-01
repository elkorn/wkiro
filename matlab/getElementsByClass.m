function [ output_args ] = getElementsByClass( array, class )
%GETELEMENTSBYCLASS Auxilliary function for empiricBayesianClassifier to get the vector of elements with specified class from the given array.

    result = [];
    for i=1:1:length(array)
        if(array(i,end) == class) 
            result(end+1, :) = array(i, :);
        end
    end
    output_args = result;
end