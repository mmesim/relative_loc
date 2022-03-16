function  ndelay=my_subsample(cc,lags,delta,index,points)
%Subsample 
%-------------------------------------------
%Grab five two points before and after CCmax
x=lags(index-points:index+points)';
y=cc(index-points:index+points);
%Fit parabola
[p,S]=polyfit(x,y,2);
%Do new y values
xnew=min(x):0.01:max(x);
ynew=polyval(p,xnew,S);
%Find maximum CC and get delay time
[~,ind]=max(ynew);
ndelay=xnew(ind).*delta;


end