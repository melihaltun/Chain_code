
% @fileName findChainCode.m
% @author Melih Altun @2014

%finds chain  code representation of a blob boundry
%input must be a 8 connected binary perimeter image 

function [chainCode, chainCodeMap] = findChainCode (perimeter) 
sz=size(perimeter);
chainCodeMap=zeros(sz(1),sz(2));
[sy, sx]=find(perimeter==1,1);  %find the starting point
startPt = [sy sx];
currentPt = startPt;
%directions = [0 1; 1 1; 1 0; 1 -1; 0 -1; -1 -1; -1 0; -1 1]; % directions incrementing in clockwise direction
directions = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1]; % directions incrementing in counter-clockwise direction
dir=8;      % start with north-east direction
chainCodeIndex=1;
while(1)
    for i=1:8
        nextPt=currentPt+directions(dir,:);
        validPosn=0;
        if (nextPt(1)>0 && nextPt(2)>0 && nextPt(1)<=sz(1) && nextPt(2)<=sz(2))
            validPosn=1; % check if next point falls within the image boundries
        end
        if(validPosn && perimeter(nextPt(1),nextPt(2))==1)  %record if next point is on the perimeter       
            chainCode(chainCodeIndex)=dir;
            chainCodeMap(currentPt(1),currentPt(2))=dir;
            chainCodeIndex=chainCodeIndex+1;
            currentPt=nextPt; %advance to the next point
            dir=dir-3; %set next direction to the one after the opposite direction of current
            if(dir<1)   %so that it does not go back and forth between two points and get stuck
                dir=dir+8;  
            end
            break;
        else  % if next point is not on the perimeter advance to the next direction
            dir=dir+1;     
            if (dir>8)
                dir=1;
            end
        end
    end
    if (isequal(currentPt,startPt))
        break;      % end when starting point is reached after a circulation
    end
end
chainCode = chainCode';

% References:
% - S. Theodaridis, K. Koutroumbas "Pattern Recognition 4th Edition", (2009), Ch.7 Sec. 3.2 Chain codes
% - H. Freeman "Computer processing of line drawing images",Comput. Surveys 6 (1) (1974) 57-97
