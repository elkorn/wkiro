function y = quantiles( input, qtls )
%QUANTILES Selects specified quantiles from an array of numbers.
  input = sort(input, 'ascend');
  n = length(input);
  nq = length(qtls);
  y = zeros(1,nq);
  for i = 1:nq
      q = qtls(i);
      if(q == 0 || 1/q > n)
          y(i) = input(1);
          continue;
      elseif (q == 1)
          y(i) = input(n);
          continue;
      end      
      index = q * n;
      lo = floor(index);
      hi = index - lo;
      a = input(lo);
      
      if(hi==0)
          y(i) = a;
      else
          y(i) = a + hi * (input(lo) - a);
      end
  end
 end

