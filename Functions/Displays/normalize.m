function out_sig=normalize(sig)
sig=sig-min(sig);
out_sig=sig./abs(max(abs(sig)))-0.05;
end