%% Experimental Pieces
function glitter_plot(results, labels,shape,name)

temp = (1:results.plotting.npart);
part_labs = cell(length(temp),1);
for i = 1:length(temp)
    part = temp(i);
    part_labs{i} = int2str(part);
end


%colormap = colours;
c = linspace(1,10,length(results.compromise.eigenvec)); %purdy colours

figure
title(name)
grid on 
hold on
for i = 1:results.plotting.nobs
    scatter(results.F(i,1),results.F(i,2),1000,c(i),'filled',shape)
    text(results.F(i,1),results.F(i,2), labels{i});%adding the text
end
for i = 1:results.plotting.npart
    x = results.plotting.RF(:,1,i);
    y = results.plotting.RF(:,2,i);
    scatter(x,y,100,c(1:results.plotting.nobs),shape,'filled')
end

