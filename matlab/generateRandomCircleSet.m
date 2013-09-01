function [ output_args ] = generateRandomCircleSet( xc, yc, radius, quantity, class )
%GENERATERANDOMCIRCLESET Creates a set of elements in a circular shape.
%   Parameters:
%   xc - the horizontal coordinate of the circle center
%   yc - the vertical coordinate of the circle center
%   radius - the radius of the circle
%   quantity - the number of elements to generate
%   [class] - the class which the elements should bear


    ns = round(1.28*quantity + 2.5*sqrt(quantity) + 100); % 4/pi = 1.2732
    x = rand(ns,1)*(2*radius) - radius;
    y = rand(ns,1)*(2*radius) - radius;
    I = find(sqrt(x.^2 + y.^2)<=radius);
    x = x(I(1:quantity)) + xc;
    y = y(I(1:quantity)) + yc;
    output_args = horzcat(x,y);

    % for t=1:quantity
    %     [x y] = randomInCircle(x,y,r);
    %     result(t,1) = x;
    %     result(t,2) = y;
    %     if (nargin > 4)
    %         result(t,3) = class;
    % end

    % output_args = result;
end

