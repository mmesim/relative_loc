function y_proc=do_preprocess(y,delta,type,co)
%(1) remove trend
%(2) remove remove
%(3) filter
%------------------------------------------------
parfor i=1:length(y)  
temp=y{1,i};
%01. remove trend
yr=my_detrend(temp,1);
%02. remove mean
ym=yr-mean(yr);
%03. filter
yf=my_filter(ym,type,delta,co);
y_proc{1,i}=yf;
end