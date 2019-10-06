function out_sig=derive_sig(sig,x)
out_sig=diff(sig)./diff(x);
end