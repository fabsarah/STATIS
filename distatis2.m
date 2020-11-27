function result = distatis2(D)
%% Distatis: comparing 3-way distance tables
% Based on Abdi et al., 2006: https://personal.utdallas.edu/~herve/Abdi-AVCC07_Pretty-tmp.pdf
% To run distatis, you need:
            % D: a 3-dimensional matrix of I*I observations matrices * k subjects
            % each matrix is a square (I*I) similarity or distance matrix (ie. the diagonal values need to be 1s or 0s)
            % the third dimension is prticipants, raters, etc.
%% Step 1: Get the Distance Matrix Dimensions. 
npart = size(D,3);% number of participants
nobs = size(D,1);% number of observations to be rated
dims = size(D,1)^2;%when we vectorize, we're going to need an I*I vector
result.plotting.npart = npart;
result.plotting.nobs = nobs;
%% Step 2: Get Sk (double-centred D)
[~, Sk] = get_sk(D);
result.Sk = Sk;
%% Step 3: Get C (k*k similarity matrix across all observations)
C = get_C(result.Sk,npart,dims);
result.C = C;
%% Step 4: Decompose C, calculate weights, and calculate the compromise matrix (S+)
% S+ is our original D matrix normalized and weighted by the
% eigen-decomposition of our participant*participant C matrix
[compromise, P, phi, weights] = get_compromise(C,D);

result.compromise.cmat = compromise;
result.compromise.eigen = {P phi};
%clear compromise P phi %make look nice
%% Step 4.5: Bootstrap Sojourn TBD
%nboot=100;% number of boots
%bsamp = rri_boot_order(npart,1,nboot,1);%calling the function "rri_boot_order" (in pls code) to get a matrix of boot indices
%boot_comp=zeros(nobs,nobs,nboot);
%for i=1:nboot
%    bD_3norm = D(:,:,bsamp(:,i)); %extract the sample based on the bsamp matrix
%    bWeights=weights(bsamp(:,i));
%    for k=1:npart
%        boot_comp(:,:,i)=boot_comp(:,:,i)+bWeights(k)*bD_3norm(:,:,k);%calculate bootstrapped Splus
%    end
%end
%result.boot.splus = boot_comp;%add it to the results file
%clear i bD_3norm bWeights k
%% Step 5: Decompose the compromise matrix and get F and the Projection Matrix
[pc, lc, F,RProj] = get_F(compromise);
result.compromise.eigenvec = pc;
result.compromise.eigenval = lc;
result.F = F;
result.RProj = RProj;
%% Step 6: Bootstrapped Projection Matrix (RProj) % TBD
%S_boot=nan(size(RProj,1),size(RProj,2),nboot);%uses nboot from above
%pc_dims = size(pc,2);
%for i = 1:nboot
%    temp_boot = boot_comp(:,1:pc_dims,i);%get the relevant boot matrix
%    S_boot(:,:,i)=temp_boot.*RProj;%multiply it by the projection
%end
%CI_1 = prctile(S_boot(:,1,:),5,3); %errorbar dimension 1
%CI_1(:,2) = prctile(S_boot(:,1,:),95,3);
%CI_2 = prctile(S_boot(:,2,:),5,3); %errorbar dimension 2
%CI_2(:,2) = prctile(S_boot(:,2,:),95,3);
%result.boot.confidence = {CI_1 CI_2};
%clear temp_boot i pc lc
 %% Step 7: RF Matrix (our original D matrix weighted by the projection matrix)
 result.plotting.RF = get_RF(F,D,RProj);
%% End of distatis computations
