function [stations,dtE,dtN,dtZ]=my_setup(workers,mydata)
%Setup for waveform cc
%Start parallel pool - Set paths - List stations

parpool('local',workers); %Start parallel pool
%list stations
data_path=sprintf('%s/*',mydata);
listing=dir(data_path);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..

%Preallocate memory
stations=cell(length(listing),1);

for i=1:length(listing)
stations{i,:}=listing(i).name;
end

%Preallocate memory
dtZ=cell(length(stations),1);
dtE=cell(length(stations),1);
dtN=cell(length(stations),1);

end