fid = fopen('training.txt');

N = 2; % number of input neurons
M = 1; % number of output neurons
H = 4; % number of neurons in hidden layer
Q = 4; % number of input vectors
alpha = 0.2; % learning rate

input = zeros(1, N); % input vector (row vector)
expOut = zeros(1, M); % this vector will store the expected output vector of each input
sensitivity1 = zeros(1,H); % sensitivity
sensitivity2 = zeros(1,M); % sensitivity 

weights1 = rand(N, H)-0.5; % weights of layer 1 (hidden layer)
bias1 = rand(1, H)-0.5; % bias of layer 1 (hidden layer)
weights2 = rand(H, M)-0.5; % weights of layer 2 (output layer)
bias2 = rand(1, M)-0.5; %bias of layer 2 (output layer)

loopCount = 0;
totSqErr = 0;
oldTotSqErr = 99; % this value is arbitrary

tolerable = false;
while ~tolerable
    while ~feof(fid)
        if ~tolerable
            
            line = fgetl(fid);
            newStr = split(line);
            arr = str2double(newStr);
    
            for i = 1 : N
                input(i) = arr(i); % first N elements of each line is the input vector
            end
            for i = 1 : M
                expOut(i) = arr(N+i); % last M elements of each line is the expected output vector
            end
            
            y1 = (input*weights1)+ bias1;
            activation1 = bipolarSigmoid(y1); % activation of hidden layer 1, input of output layer (1 by H row vector)
            
            y2 = (activation1*weights2) + bias2;
            activation2 = bipolarSigmoid(y2); % output from the output layer (1 by M row vector)
            
            totSqErr = totSqErr + totalSqError(activation2,expOut);
                
            sensitivity2 = (activation2 - expOut)*bipolarSigmoidDerivative(y2); % row vector (1 by M)
                
            der = bipolarSigmoidDerivative(y1);
            w = sensitivity2*weights2;
            for j=1:H
                sensitivity1(j) = der(j)*sum(w(j,:)); % row vector (1 by H)
            end
                
            %************
            newWeights1 = weights1 - alpha*transpose(input)*sensitivity1;
            newBias1 = bias1 - (alpha*sensitivity1);
            
            newWeights2 = weights2 - alpha*transpose(activation1)*sensitivity2;                
            newBias2 = bias2 - (alpha*sensitivity2);
            
            bias1 = newBias1;
            bias2 = newBias2;
            weights1 = newWeights1;
            weights2 = newWeights2;
            %************  
                         
        else
            line = fgetl(fid);
        end
        
    end
    
    if (totSqErr < 0.05)
        tolerable = true;
    else
        totSqErr = 0;
    end
    %tolerable = true; % this line will make the program stop after 1 epoch
    loopCount = loopCount + 1;
    frewind(fid); % this returns the marker to the beginning of the file
end
fclose(fid);

disp("Hidden Layer Weights:");
disp(weights1);
disp("Hidden Layer Bias:");
disp(bias1);
disp("Output Layer Weights:");
disp(weights2);
disp("Output Layer Bias:");
disp(bias2);
disp("Number of Epochs");
disp(loopCount);

