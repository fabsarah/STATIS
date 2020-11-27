function [compromise, P, phi,weights] = get_compromise(C,D)

npart = size(D,3);% number of participants
nobs = size(D,1);% number of observations to be rated

[P,phi] = eigen(C);%get the eigen decomposition of C
weights=P(:,1)/sum(abs(P(:,1)));

compromise=zeros(nobs,nobs); %pre-allocate the compromise matrix (=Splus)
for k=1:npart
  compromise=compromise+weights(k)*D(:,:,k);%normalized matrix weighted by eigen decomposition of our participant*participant similarity matrix C
end
end