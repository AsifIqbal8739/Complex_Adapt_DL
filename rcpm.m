function [uEst, vEst] = rcpm(X, lambda, nberPMIter)
% Regularized Complex Power Method (RCPM)
% 
% inputs:
% X: (nxp) complex matrix to approximate (rank-1 approximation)
% lambda: regularization parameter (controls also the shrinkage)
% nberPMIter: number of power method iterations
% outputs:
% uEst, vEst: estimates of vectors u and v s.t.:
% ||X-u*v^H||^2_F + lambda*||v||_1 is minimum
% Author: Mohamed Nait-Meziane
% Update: 25/02/2018

[~, p] = size(X);
vEst = ones(p,1)+1j*ones(p,1); % initialization

for kk = 1:nberPMIter
    uEst = (X*vEst)/(vEst'*vEst);
    uEst = uEst./norm(uEst);
    
    alpha = norm(uEst)^2;
    theta = lambda/(2*alpha);
    w = (X'*uEst)/alpha;
%     normW = abs(w);

    % Shrinkage
    vEst = w.*max(0,1-theta./abs(w));
%     vEst(normW<=theta) = 0;
    
    % Test if all elements of v are zero then break out of loop
    if norm(vEst) == 0
        break;
    end
end