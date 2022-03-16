function  [npairsZ,npairsE,npairsN,yZ_cut,yE_cut,yN_cut]=my_correlation(yZ_proc,yE_proc,yN_proc,P_Bpick_win,P_Apick_win,S_Bpick_win,S_Apick_win,headerE,headerN,headerZ,idE,idN,idZ,sta_id)
%First check if the component is not empty
%then do:
%(1) Create event pairs
%(2) Cut waveforms around arrival time
%(3) Do correlations 

npairsZ=[];npairsE=[];npairsN=[];
yZ_cut=[];yE_cut=[];yN_cut=[];

%do Z
if ~isempty(yZ_proc)
pairsZ=my_pairs(yZ_proc); %!! These are not the IDs. just pairs. Will be replaced with IDs later.
yZ_cut=my_cut_waveforms(yZ_proc,P_Bpick_win,P_Apick_win, headerZ);
npairsZ=do_xcor(yZ_cut,headerZ(1).DELTA,(extractfield(headerZ,'A'))',pairsZ,idZ,sta_id);    
end

% %do E-W
if ~isempty(yE_proc)
pairsE=my_pairs(yE_proc); %!! These are not the IDs. just pairs. Will be replaced with IDs later.
yE_cut=my_cut_waveforms(yE_proc,S_Bpick_win,S_Apick_win, headerE);
npairsE=do_xcor(yE_cut,headerE(1).DELTA,(extractfield(headerE,'T0'))',pairsE,idE,sta_id);    
end
% 
% %do N-S
if ~isempty(yN_proc)
pairsN=my_pairs(yN_proc); %!! These are not the IDs. just pairs. Will be replaced with IDs later.
yN_cut=my_cut_waveforms(yN_proc,S_Bpick_win,S_Apick_win, headerN);
npairsN=do_xcor(yN_cut,headerN(1).DELTA,(extractfield(headerN,'T0'))',pairsN,idN,sta_id);   
end

end