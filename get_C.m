function C = get_C(Sk,npart,dims)
% C is a similarity matrix by participant (it collapses across the I
% dimension and gives you a k*k matrix of participant similarity across all
% observations)
Svec = nan(npart,dims);
for i = 1:npart
    temp = Sk(:,:,i);
    temp = temp(:)';
    Svec(i,:) = temp;%vectorize the standardized matrix by participant
end
clear i
%normalizing the matrix to unit (n = npart) length:
SS = sqrt(sum(Svec.^2,2));
SS_new = SS*ones(1,dims);
SS_final = Svec./SS_new; 
C = SS_final*SS_final'; %participant*participant similarity matrix
clear SS SS_new SS_final %make look nice
end
