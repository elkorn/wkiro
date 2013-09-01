function [ output_args ] = selectBandwidthFor( array )
%SELECTBANDWITHFOR Selects bandwith for specified features from the elements belonging to the given collection.

    N = length(array);
    numberOfFeatures = getNumberOfFeaturesFor(array);
    output_args = zeros(1, numberOfFeatures);

    for i=1:1:numberOfFeatures
        % 3.486 * std() is just one of the possible rule of thumb methods 
        % to compute the bandwidth
        output_args(i) = 3.486 * std(array(:,i) ,1) / sqrt(N);
    end
end

