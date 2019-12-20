% To display all the activations and time series from a dictionary and
% Sparse Coefficient matrix
% D = Dictionary;   X = Coeff Matrix
% Author: Asif Iqbal 10 Oct 2018
%%
function [h] = Disp_Act_Comp(D,X)

%% making activations positive
% ss = sign(mean(X,2));
% ss = sign(skewness(X'));
% X = diag(ss) * X;
% D = D * diag(ss);
% X = X+repmat(X(1,:),size(X,1),1);     D = D+repmat(D(:,1),1,size(D,2));
n = size(D,2);      
p = sqrt(size(X,2));
% h = figure('Position',[800,400,600,500]);
h=figure;
m = 1:3*n;
for i = 1:n
    s = m((3*(i-1))+1:(3*(i-1))+3);
    subplot(n,3,s(1));
    smap = (X(i,:)); %smap(abs(smap)<=2.6) = 0;
    imagesc(reshape(smap,p,p)); ylabel(i,'Rotation',0);  % or use imshow
    set(gca,'YTick',[]); set(gca,'XTick',[]);   colormap gray; axis image
    subplot(n,3,s(2:3));
    plot((D(:,i)),'LineWidth',1.5);  title(strcat('D_{',num2str(i),'}')); axis tight;
    set(gca,'YTick',[]); set(gca,'XTick',[]);  
end
end