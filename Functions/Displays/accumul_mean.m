function out_sig=accumul_mean(sig)
for i=1:max(size(sig))
out_sig(i)=mean(sig(1:i));
end
end