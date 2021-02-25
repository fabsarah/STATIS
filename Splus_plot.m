function Splus_plot(results, labels, name)
%% Step 7: Plotting the centroids
%We're plotting the centred mean locations of all the songs (Splus, which
%is pc in this script) with the participants grouped around those means
%(which is Sk (cell) or D_3norm) in this script)
c = linspace(1,10,length(results.compromise.eigenvec)); %purdy colours

figure
scatter(results.F(:,1),results.F(:,2),90,c,'filled','d')%plotting the centrepoint from the eigendecomposition of the compromise matrix
hold on
%errorbar(results.F(:,1),results.F(:,2),results.boot.confidence{1,2}(:,1),results.boot.confidence{1,2}(:,2),results.boot.confidence{1,1}(:,1),results.boot.confidence{1,1}(:,2),'.')%unclear of x and y here
grid on
text(results.F(:,1),results.F(:,2), labels);%adding the text
title(name,'FontSize',16)
