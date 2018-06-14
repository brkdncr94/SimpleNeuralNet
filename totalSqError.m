function [squareError] = totalSqError(res,expected)
squareError = 0;
for i=1:length(res)
    squareError = squareError + ( (abs( res(i) - expected(i) )^2) );
end

end

