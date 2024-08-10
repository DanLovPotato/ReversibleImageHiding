%% % Generate a random binary watermark of specified capacity
function Watermark = Gwatermark(WatermarkCapacity)
    Watermark = round(rand(1, WatermarkCapacity));
end
