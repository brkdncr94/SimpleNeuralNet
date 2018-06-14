function [out] = bipolarSigmoidDerivative(in)
out = zeros(1, length(in));
for i=1:length(in)
   x = bipolarSigmoid(in(i));
   out(i) = (1 + x)*(1 - x)*(1/2);
   %out(i) = bipolarSigmoid(in(i))*(1 - bipolarSigmoid(in(i))); %binary version
end
end


