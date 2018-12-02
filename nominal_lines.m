%% Nominal regular lines BB, FC, SEGB and SI %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all, close all
cd /Users/ddesbruy/Documents/MATLAB/DFO

lon_bb_first = -52.97;
lon_bb_last = -47.95;
lat_bb_first = 48.73;
lat_bb_last = 50.33;

lon_fc_first = -52.83;
lon_fc_last = -42.00;
lat_fc_first = 47;
lat_fc_last = 47;

lon_segb_first = -52.93;
lon_segb_last = -48.67;
lat_segb_first = 46.58;
lat_segb_last = 41.33;

lon_si_first = -55.65;
lon_si_last = -52.50;
lat_si_first = 53.23;
lat_si_last = 55.07;

sec = {'bb','fc','segb','si'};
save nominal_lines sec
for ss = 1:length(sec)
    
    evalc(sprintf('lon_first = lon_%s_first', sec{ss}));
    evalc(sprintf('lat_first = lat_%s_first', sec{ss}));
    evalc(sprintf('lon_last = lon_%s_last', sec{ss}));
    evalc(sprintf('lat_last = lat_%s_last', sec{ss}));
    lon_nominal = [];
    lat_nominal = [];
    
    seg_dist = dist([lon_first lon_last],[lat_first lat_last])/1e3;
    seg_nb_pts = round(seg_dist/3);
    seg_lat = linspace(lat_first,lat_last, seg_nb_pts);
    seg_lat(end) = [];
    seg_lon = linspace(lon_first, lon_last, seg_nb_pts);
    seg_lon(end) = [];
    lon_nominal = [lon_nominal seg_lon];
    lat_nominal = [lat_nominal seg_lat];
    
    dist_nominal = zeros(1,length(lon_nominal));
    dist_nominal(2:end) = 1.8520*dist_fischer(lat_nominal, lon_nominal);
    
    evalc(sprintf('lon_nominal_%s = lon_nominal', sec{ss}));
    evalc(sprintf('lat_nominal_%s = lat_nominal', sec{ss}));
    evalc(sprintf('dist_nominal_%s = cumsum(dist_nominal)', sec{ss}));
    
    save('nominal_lines', sprintf('lon_nominal_%s', sec{ss}),'-append')
    save('nominal_lines', sprintf('lat_nominal_%s', sec{ss}),'-append')
    save('nominal_lines', sprintf('dist_nominal_%s', sec{ss}),'-append')
end





