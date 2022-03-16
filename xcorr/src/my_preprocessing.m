function [yZ_proc,yN_proc,yE_proc]=my_preprocessing(yZ,yN,yE,delta,type,co)
%Preprocessing
%Check if component exists and then
%(1) remove mean
%(2) remove trend
%(3) filter
%--------------------------------------------------------------------------
%Preallocate memory
yZ_proc=cell(1,length(yZ));
yN_proc=cell(1,length(yN));
yE_proc=cell(1,length(yE));

%first check that the variables exist
%then do preprocessing
%Z-component
if ~isempty(yZ)
yZ_proc=do_preprocess(yZ,delta,type,co);   
end
%E-W component
if ~isempty(yE)
yE_proc=do_preprocess(yE,delta,type,co);   
end
%N-S component
if ~isempty(yN)
yN_proc=do_preprocess(yN,delta,type,co);   
end


end