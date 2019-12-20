% Phase correction and denoising of the complex spatial maps and TCs
% as outlined in Kuang-2018 Appendix A or Yu-2015
% Author: Asif Iqbal 10 Oct 2018
%%
function [DPC,XPC,XMask] = SM_Phase(D,X,St,phCutt,verb)
    % D contains complex PTCs
    % X contains the complex spatial maps
    % phCutt cut-off of phase
    % St = 1 - No DC present, 2 - DC present
    if ~exist('verb','var')
        verb = 1;
    end
   [n,K] = size(D);
   N = size(X,2);
   [XPC,XMask] = deal(zeros(K,N));
   DPC = zeros(size(D));   
   
   for ii = St:K
        d = D(:,ii);
        % Step 1
        A = [real(d),imag(d)]';
        CA = A*A'./n;
        [a,s,v] = svd(CA);
        theta = [acos(a(1,1)), asin(a(1,2)); asin(-a(2,1)), acos(a(2,2))]; rad2deg(theta);
        GG = repmat(d,1,4)*diag(exp(-1j*vec(theta)));   % to find the theta that maximizes real power
        GG = diag(real(GG)'*real(GG));
        [~,ind] = max(GG);
        the = theta(ind);
%         the = mean(angle(d));
        d = d * exp(-1j*the);
        x = X(ii,:) * exp(1j*the); 
        % forcing the maximum magnitude component on the +ve real axis  
        [~,bb] = max(abs(d));
        if abs(angle(d(bb))) > pi/2
            x = -1*x;
            d = -1*d;
        end          
        % phase masking to be done later. Mask generated here.
        xx = x;
        xx(abs(angle(x)) > phCutt) = 0;
        XMask(ii,:) = xx ~= 0;
        XPC(ii,:) = x;
        DPC(:,ii) = d;
        if verb == 1
            if ii == St;    figure; kk = 1; end
            subtightplot(K-St+1,2,kk); polarplot(D(:,ii),'r','LineWidth',2); hold on
            polarplot(DPC(:,ii),'b','LineWidth',2);
            kk = kk + 1;
            subtightplot(K-St+1,2,kk); polarplot(X(ii,:),'r','LineWidth',2); hold on
            polarplot(XPC(ii,:),'b','LineWidth',2);
            kk = kk + 1;
        end
   end
    
    
    
end