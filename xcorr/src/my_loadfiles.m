function   [yN,yE,yZ,headerN,headerE,headerZ,idZ,idE,idN]=my_loadfiles(mydata,station)
%list all sac files in "STATION"/ directory
%and loop through them to read sac files

% Define structures - This fix here solves the issue with variable length
% sac headers. This can happen if the header contains info about the
% station coordiantes and the event coordinates. Specifically, if you open
% this files with sac automaticaly adds new entries regarding azimuth and
% backazimuth. That menas that if you open a few files to visualize the
% waveforms then the headers will not have the same length as those that
% were never touched. 
%the idea was taken from my template detection code
headerZ = struct('DELTA',{}, 'A', {}, 'EVLA',{}, ...
                   'EVLO',{}, 'EVDP', {}, ...
                    'MAG',{}, 'NZYEAR',{}, 'NZJDAY',{}, ...
                    'STLA',{}, 'STLO',{}, 'STEL', {}, ...
                    'KSTNM', {}, 'KCMPNM',{}, 'KNETWK', {} );

headerE = struct('DELTA',{}, 'T0', {}, 'EVLA',{}, ...
                   'EVLO',{}, 'EVDP', {}, ...
                    'MAG',{}, 'NZYEAR',{}, 'NZJDAY',{}, ...
                    'STLA',{}, 'STLO',{}, 'STEL', {}, ...
                    'KSTNM', {}, 'KCMPNM',{}, 'KNETWK', {} );

headerN = struct('DELTA',{}, 'T0', {}, 'EVLA',{}, ...
                   'EVLO',{}, 'EVDP', {}, ...
                    'MAG',{}, 'NZYEAR',{}, 'NZJDAY',{}, ...
                    'STLA',{}, 'STLO',{}, 'STEL', {}, ...
                    'KSTNM', {}, 'KCMPNM',{}, 'KNETWK', {} );

%define variables to avoid problems later
idZ=[];idE=[];idN=[];
yZ={};yE={};yN={};


data_path=sprintf('%s/%s/*',mydata,station);
listing=dir(data_path);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..
%--------------------------------------------------
j=1;jj=1;jjj=1;
for i=1:length(listing)
filename=sprintf('%s/%s/%s',mydata,station,listing(i).name);
[D,~,header]=rdsac(filename);    
splitfilename=strsplit(listing(i).name,'.');
%Comment --- The filename should be something like 
%         ID NETWORK STATION CHANNEL SAC
%         eg. 001.UU.FORU.HHZ.sac
%--------------------------------------------------
    if splitfilename{1,4}(3) == 'Z'    
    %------- add waveforms to a signle cell -----------
    yZ{1,j}=D;
    %------- add headers to a signle structure --------
    %Upadated to keep specific entries
    headerZ(j)=struct('DELTA',header.DELTA, 'A', header.A, 'EVLA', header.EVLA, ...
                   'EVLO',header.EVLO, 'EVDP', header.EVDP , ...
                    'MAG',header.MAG, 'NZYEAR',header.NZYEAR, 'NZJDAY',header.NZJDAY, ...
                    'STLA', header.STLA, 'STLO', header.STLO, 'STEL', header.STEL, ...
                    'KSTNM', header.KSTNM, 'KCMPNM', header.KCMPNM , 'KNETWK', header.KNETWK );
    
    idZ(j,1)=str2double(splitfilename{1,1});
    j=j+1;
    elseif splitfilename{1,4}(3) == 'E' || splitfilename{1,4}(3) == '1' 
    %------- add waveforms to a signle cell -----------
    yE{1,jj}=D;
    %------- add headers to a signle structure --------
    %Upadated to keep specific entries
    headerE(jj)=struct('DELTA',header.DELTA, 'T0', header.T0, 'EVLA', header.EVLA, ...
                   'EVLO',header.EVLO, 'EVDP', header.EVDP , ...
                    'MAG',header.MAG, 'NZYEAR',header.NZYEAR, 'NZJDAY',header.NZJDAY, ...
                    'STLA', header.STLA, 'STLO', header.STLO, 'STEL', header.STEL, ...
                    'KSTNM', header.KSTNM, 'KCMPNM', header.KCMPNM , 'KNETWK', header.KNETWK );
    idE(jj,1)=str2double(splitfilename{1,1}); 
    jj=jj+1;
     elseif splitfilename{1,4}(3) == 'N' || splitfilename{1,4}(3) == '2' 
    %------- add waveforms to a signle cell -----------
    yN{1,jjj}=D;
    %------- add headers to a signle structure --------
    %Upadated to keep specific entries
    headerN(jjj)=struct('DELTA',header.DELTA, 'T0', header.T0, 'EVLA', header.EVLA, ...
                   'EVLO',header.EVLO, 'EVDP', header.EVDP , ...
                    'MAG',header.MAG, 'NZYEAR',header.NZYEAR, 'NZJDAY',header.NZJDAY, ...
                    'STLA', header.STLA, 'STLO', header.STLO, 'STEL', header.STEL, ...
                    'KSTNM', header.KSTNM, 'KCMPNM', header.KCMPNM , 'KNETWK', header.KNETWK );
    
    idN(jjj,1)=str2double(splitfilename{1,1});         
    jjj=jjj+1;  
    end
end



%--------------------------------------------------
end

