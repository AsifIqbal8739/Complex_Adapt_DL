function DC = normc_Comp(DC)
    normDC = sqrt(diag(DC'*DC));
    DC = DC * diag(normDC.^-1);
end