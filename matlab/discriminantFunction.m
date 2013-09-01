function [ output_args ] = discriminantFunction( kernel, element, trainingSet )
%DISCRIMINANTFUNCTION Computes the discriminant function value for the empiric bayesian classifier.
%   Computes the discriminant function value for the empiric bayesian
%   classifier with a kernel estimator for the specified element based 
%   on the given training set. It is computed considering all possible
%   features of the element and training set.
%   The result is a probability density of whether the element belongs to
%   the class representet by the training set members.

    N = length(trainingSet);
    numberOfFeatures = length(element);
    output_args = 1;
    bandwidth = selectBandwidthFor(trainingSet);
    
    for f=1:1:numberOfFeatures
        trainingFeatures = trainingSet(:,f);
        feature = element(f);
        sigma = 0;
        for i=1:1:N
            sigma = sigma + kernel( (feature-trainingFeatures(i)) / bandwidth(f) );
        end
        output_args = output_args * sigma / bandwidth(f);
    end

end