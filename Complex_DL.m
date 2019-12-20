% wrapper for rcpm
% Author: Asif Iqbal 10 Oct 2018
%% 
function [D_Conv,E_ConvN,E_ConvG,D,X] = Complex_DL(YY,DC,St,lambda,Data,noIt,verb)
% D_Conv - Dictionary Convergence
% E_ConvN - Data fitting w.r.t. noisy dataset YY
% E_ConvG - Data fitting w.r.t. Original dataset Data
if ~exist('verb','var') 
    verb = 0; 
end
tol = 0.001;
nberPMIter = 10; % nber of Power-Method iterations
nberIter = noIt; % number of times to repeat the estimation
[D_Conv,E_ConvN,E_ConvG] = deal(zeros(1,noIt));
% Search for solutions
X = pinv(DC)*YY;
D = DC;
K = size(D,2);
for iter = 1:nberIter
    D0 = D;
    for k = St:K
        Z = YY - (D*X - D(:,k)*X(k,:));
        [dEst, xEst] = rcpm(Z, lambda, nberPMIter);
        D(:,k) = dEst;
        X(k,:) = xEst';
    end
    D_Conv(iter) = CConv(D0,D);
    E_ConvN(iter) = CConv(YY,D*X);
    E_ConvG(iter) = CConv(Data,D*X);
    if verb == 1
        fprintf('Iteration: %d, D_Conv: %0.3f, E_ConvN: %0.3f, E_ConvG: %0.3f\n', iter, ...
            D_Conv(iter),E_ConvN(iter),E_ConvG(iter));
    end
    if D_Conv(iter) < tol
        break;
    end
end

end

%% Function for convergence calculation
function CC = CConv(D0,D1)
    CC = norm(D0 - D1,'fro')/norm(D0,'fro');
end