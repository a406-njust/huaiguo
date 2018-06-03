function PixelPeak = subPixelPeak(left, center, right)
divisor = 2*center-right-left;
if divisor == 0
    PixelPeak = 0;
else
    PixelPeak = 0.5*(right-left)/divisor;
end

end