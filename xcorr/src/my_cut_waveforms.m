function ycut=my_cut_waveforms(y,pick_Bwin,pick_Awin, header)
%Cut waveforms around arrival time
%Arrival time is already in header

for j=1:length(y)
%check component    
if header(1).KCMPNM(3)=='Z'
start=round((header(j).A-pick_Bwin)./header(1).DELTA); %start before pick
stop=round((header(j).A+pick_Awin)./header(1).DELTA); %window after pick
elseif header(1).KCMPNM(3)=='E' || header(1).KCMPNM(3)=='N'   
start=round((header(j).T0-pick_Bwin)./header(1).DELTA); %start before pick
stop=round((header(j).T0+pick_Awin)./header(1).DELTA); %window after pick
end
%padding zeros
if stop<length(y{1,j})
    temp1=y{1,j}(start:stop);
    temp1=temp1-mean(temp1);
    ycut{:,j}=temp1;
else
    temp2=[y{1,j}(start:end); zeros(stop-length(y{1,j}),1)];
    temp2=temp2-mean(temp2);
    ycut{:,j}=temp2;
end


end
end