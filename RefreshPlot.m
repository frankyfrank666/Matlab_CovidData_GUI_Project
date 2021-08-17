app.cumulative
app.cases
app.xdays
app.countriesSelected
app.stateSelected
app.count

yyaxis(app.UIAxes,'left');
cla(app.UIAxes);
app.UIAxes.YLabel.String =  "Cases";
app.UIAxes.YLim = [0 inf];

yyaxis(app.UIAxes,'right');
cla(app.UIAxes);
app.UIAxes.YLabel.String =  "Number of Death";
app.UIAxes.YLim = [0 inf];

title(app.UIAxes,(app.cumulative + " Number of " + ...
app.cases + " in " + app.stateSelected + " " + app.countriesSelected + ...
" (" + int2str(app.xdays)+ "-day mean)"));


data_row = 1;
for i = 1:1:length(app.countries)
    if isequal(app.countries{i},app.countriesSelected) && isequal(app.state{i},app.stateSelected)
        data_row = i;
        break
    end
end
data_row

if isequal(app.cumulative,'Cumulative')
    if isequal(app.cases,'Both')
        Y = app.CumCas(data_row,:);
        yyaxis(app.UIAxes,'left');
        bar(app.UIAxes,datetime(app.dates),movmean(Y,app.xdays));
        Y = app.CumDet(data_row,:);
        yyaxis(app.UIAxes,'right');
        plot(app.UIAxes,datetime(app.dates),movmean(Y,app.xdays),'color','r');
    elseif isequal(app.cases,'Death')
        Y = app.CumDet(data_row,:);
        yyaxis(app.UIAxes,'right');
        plot(app.UIAxes,datetime(app.dates),movmean(Y,app.xdays),'color','r');
    elseif isequal(app.cases,'Cases')
        Y = app.CumCas(data_row,:);
        yyaxis(app.UIAxes,'left');
        bar(app.UIAxes,datetime(app.dates),movmean(Y,app.xdays));
    end
    
elseif isequal(app.cumulative,'Daily')
    if isequal(app.cases,'Both')
        Y = app.DailyCas(data_row,:);
        yyaxis(app.UIAxes,'left');
        bar(app.UIAxes,datetime(app.dates),movmean(Y,app.xdays));
        Y = app.DailyDet(data_row,:);
        yyaxis(app.UIAxes,'right');
        plot(app.UIAxes,datetime(app.dates),movmean(Y,app.xdays),'color','r');
    elseif isequal(app.cases,'Death')
        Y = app.DailyDet(data_row,:);
        yyaxis(app.UIAxes,'right');
        plot(app.UIAxes,datetime(app.dates),movmean(Y,app.xdays),'color','r');
    elseif isequal(app.cases,'Cases')
        Y = app.DailyCas(data_row,:);
        yyaxis(app.UIAxes,'left');
        bar(app.UIAxes,datetime(app.dates),movmean(Y,app.xdays));
    end
end

app.UIAxes.YAxis(1).Exponent = 0;
app.UIAxes.YAxis(2).Exponent = 0;

app.count = app.count + 1;

return

