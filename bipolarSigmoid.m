function [out] = bipolarSigmoid(in)
out = zeros(1, length(in));
for i=1:length(in)
   out(i) = (2/ (1 + exp(-in(i))) ) - 1;
   %out(i) = tanh(in(i)/2);
   %out(i) = 1/ (1 + exp(-in(i))); %binary version
end
end