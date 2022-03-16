function npairs=do_xcor(y,delta,picks,pairs,id,sta_id)
%Do cross correlation
%and calculate delay and CC


parfor k=1:length(pairs(:,1))
%Correlation
%-----------------------------------------    
[cc,lags]=xcorr(y{1,pairs(k,1)},y{1,pairs(k,2)},'coeff');
[~,index]=max(cc);
ccm=cc(index);
%delay=lags(index).*delta;
if index>2; points=2; elseif index<=2; points=1; end
delay=my_subsample(cc,lags,delta,index,points);
%Correct for travel time difference. 
ndelay=picks(pairs(k,1))+delay-picks(pairs(k,2))

% save correlations and delays for each pair
npairs(k,:)=[id(pairs(k,1)) id(pairs(k,2)) ccm ndelay sta_id];

end
end