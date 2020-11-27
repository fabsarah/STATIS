function [H, Sk] = get_sk(D)
%% Step 2: Get Sk (double-centred D)

npart = size(D,3);% number of participants
nobs = size(D,1);% number of observations to be rated

Sk = zeros(nobs,nobs,npart);%pre-allocating Sk
H = zeros(nobs,nobs,npart); %pre-allocating H (for the function, not the results file)

for i = 1:npart
    rowm = mean(D(:,:,i),2);%get the mean of each row
    small_H = D(:,:,i)-rowm;%subtract it from the original
    colm = mean(small_H,1);%get the mean of each column
    small_H = small_H-colm;%subtract column mean from row-centred data
    H(:,:,i) = small_H./2; %divide it by 2
    sck = norm(H(:,:,i));%normalizing the H value (Sck_normalized)
    Sk(:,:,i) = H(:,:,i)/sck;%put it into the cell
end
clear i rowm small_H colm sck %make look nice
end