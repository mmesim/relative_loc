function [all_event_pairs,cut_event_pairs]=my_output(dtZ,dtE,dtN,stations,cc_thres,obs_thres,filename1,filename2)
%Final step- Create output for hypoDD and GrowClust
%cc values are sqauared for hypoDD output

%convert from cell to array 
dtZ=cell2mat(dtZ);dtE=cell2mat(dtE);dtN=cell2mat(dtN);
%add vector with 1 for P phases and 2 for S phases
all=[dtZ ones(length(dtZ),1); dtE 2*ones(length(dtE),1); dtN 2*ones(length(dtN),1)]; 

%Keep event pairs with CC above threshold
all=all(all(:,3)>=cc_thres,:);
%Find unique IDs
unid=unique(all(:,1:2),'rows');

all_event_pairs=cell(length(unid),1);
cut_event_pairs=cell(length(unid),1);
%Creat a cell with event pairs

parfor j=1:length(unid)
temp=all(all(:,1)==unid(j,1) & all(:,2)==unid(j,2),:);
%keep all event pairs - I haven't decided yet why
all_event_pairs{j,1}=temp;
%Keep event pairs with N obs [usually 8 is fine]
if length(temp(:,1))>=obs_thres
cut_event_pairs{j,1}=temp;
end

end
%---------------------------------------------------------------------------
%Finaly print output - boo!
fout1=fopen(filename1,'w');
fout2=fopen(filename2,'w');

cut_event_pairs=cut_event_pairs(~cellfun('isempty',cut_event_pairs));
for ii=1:length(cut_event_pairs)
%print header first '# ID1 ID2 0.0'
fprintf(fout1,'# %d %d 0.0 \n', cut_event_pairs{ii,1}(1,1) ,cut_event_pairs{ii,1}(1,2) );
fprintf(fout2,'# %d %d 0.0 \n', cut_event_pairs{ii,1}(1,1) ,cut_event_pairs{ii,1}(1,2) );

   for iii=1:length(cut_event_pairs{ii,1}(:,1))
   %Now print diff. times 'STA delay CC phase' 
    if cut_event_pairs{ii,1}(iii,6)==1; phase='P'; else phase='S'; end
    %hypoDD output - CC.^2
    fprintf(fout1,'%5s %7.4f %7.4f %s \n',stations{cut_event_pairs{ii,1}(iii,5)}, ...
    cut_event_pairs{ii,1}(iii,4), cut_event_pairs{ii,1}(iii,3).^2,phase );
    %GrowClust output - CC as is
    fprintf(fout2,'%5s %7.4f %7.4f %s \n',stations{cut_event_pairs{ii,1}(iii,5)}, ...
    cut_event_pairs{ii,1}(iii,4), cut_event_pairs{ii,1}(iii,3),phase );

    end
end
%close files and bye!
fclose(fout1);fclose(fout2);

end
