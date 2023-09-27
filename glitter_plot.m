%% Centroids and individuals
function glitter_plot(results,cps,labels,shape,name)

%Running the glitter plot! You need:
%    results: your results structure array from running STATIS
%    cps: a 1x2 vector of what components to plot (for example: cps = [1,2] to plot the first 2 components)
%    labels: your labels file/variable
%    shape: what shape you want. For maximum glitter, I like 'p'
%    name: the title of your plot

temp = (1:results.plotting.npart);
part_labs = cell(length(temp),1);
for i = 1:length(temp)
    part = temp(i);
    part_labs{i} = int2str(part);
end


%colormap = colours;
c = linspace(1,10,length(results.compromise.eigenvec)); %purdy colours

figure
title(name,'FontSize',16)
grid on 
hold on
for i = 1:results.plotting.nobs
    scatter(results.F(i,cps(1)),results.F(i,cps(2)),1000,c(i),'filled',shape)
    text(results.F(i,cps(1)),results.F(i,cps(2)), labels{i});%adding the text
end
for i = 1:results.plotting.npart
    x = results.plotting.RF(:,cps(1),i);
    y = results.plotting.RF(:,cps(2),i);
    scatter(x,y,100,c(1:results.plotting.nobs),shape,'filled')
end

