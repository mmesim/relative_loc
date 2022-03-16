function   [yN,yE,yZ,headerN,headerE,headerZ,idZ,idE,idN]=my_loadfiles(mydata,station)
%list all sac files in "STATION"/ directory
%and loop through them to read sac files

%define variables to avoid problems later
idZ=[];idE=[];idN=[];
yZ={};yE={};yN={};
flag1=0;flag2=0;flag3=0;

data_path=sprintf('%s/%s/*',mydata,station);
listing=dir(data_path);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..
%--------------------------------------------------
j=1;jj=1;jjj=1;
for i=1:length(listing)
filename=sprintf('%s/%s/%s',mydata,station,listing(i).name);
[D,~,H]=rdsac(filename);    
splitfilename=strsplit(listing(i).name,'.');
%Comment --- The filename should be something like 
%         ID NETWORK STATION CHANNEL SAC
%         eg. 001.UU.FORU.HHZ.sac
%--------------------------------------------------
    if splitfilename{1,4}(3) == 'Z'    
    %------- add waveforms to a signle cell -----------
    yZ{1,j}=D;
    %------- add headers to a signle structure --------
    headerZ(j)=H;
    idZ(j,1)=str2double(splitfilename{1,1});
    j=j+1;flag1=1;
    elseif splitfilename{1,4}(3) == 'E' || splitfilename{1,4}(3) == '1' 
    %------- add waveforms to a signle cell -----------
    yE{1,jj}=D;
    %------- add headers to a signle structure --------
    headerE(jj)=H;
    idE(jj,1)=str2double(splitfilename{1,1}); 
    jj=jj+1;flag2=1;
     elseif splitfilename{1,4}(3) == 'N' || splitfilename{1,4}(3) == '2' 
    %------- add waveforms to a signle cell -----------
    yN{1,jjj}=D;
    %------- add headers to a signle structure --------
    headerN(jjj)=H;
    idN(jjj,1)=str2double(splitfilename{1,1});         
    jjj=jjj+1; flag3=1;   
    end
end

% avoid ghost headers
if flag1==0; headerZ=struct([]);end
if flag2==0; headerE=struct([]);end
if flag3==0; headerN=struct([]);end

%--------------------------------------------------
end

