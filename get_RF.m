function RF = get_RF(F,D,RProj)
% we compute the min and max values of the projections
% for the axes because it is useful for the graphs
npart = size(D,3);% number of participants
nobs = size(D,1);% number of observations to be rated

minF=min(F);
maxF=max(F);

[~,Nfactors]=size(F);
RF=zeros(nobs,Nfactors,npart);
 for k=1:npart
  temp=D(:,:,k)*RProj; %multiplying our original matrix by the projection matrix
  RF(:,:,k)=temp;
  minF=min([minF;temp]);
  maxF=max([maxF;temp]); 
 end
 
end  