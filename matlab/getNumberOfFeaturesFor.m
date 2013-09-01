function [ output_args ] = getNumberOfFeaturesFor( input_args )
%GETNUMBEROFFEATURES Extracts the number of element features from a collection of data.

    output_args = length(input_args(1,:)) - 1;
end

