function [ f ] = music(array, Rxx)
    [U, lamda] = eig(Rxx,'vector');
    min_lamda = min(lamda);
    K = 0; % multiplicity of min-eigenvalue
    for i=1:length(lamda)
        if real(round(min_lamda,5)) == real(round(lamda(i),5))
            K = K + 1;
        end
    end
    N = size(Rxx,1);
    M = N - K; % number of sources
    Z = M; 
    f = zeros(180,1);
    theta = 0;
    directions = zeros(180,2);
    for i = 1:180
        directions(i,:) = [theta, 0];
        theta = theta + 1;
    end
    S = spv(array,directions);
    f = diag(real(S'*U(:,M+1:N)*U(:,M+1:N)'*S));
 end

