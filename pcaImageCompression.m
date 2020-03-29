[img, map] = imread('lena512.bmp');
img = double(img);

%find principal components
[m,n] = size(img);
mn = mean(img, 2);
data = img - repmat(mn, 1, n);
covariance = 1/sqrt(n-1)*(data*data');
[pc, v] = eig(covariance);
v = diag(v);
[junk, rindices] = sort(-1*v);

index = 1;
i = 192;
while i > 1
    % truncate principal components to 192, 128, 96, 64, 48, 32, 24, 16,
    % 12, 8, 4, and 2 and extract from centered data
    vars = v(rindices(1:i));
    pcs = pc(:,rindices(1:i));
    y = pcs'*data;
    
    % create compressed image and add mean back in
    xx = pcs*y;
    xx = xx + repmat(mn, 1, n);
    filename = strcat(num2str(i),'.png');
    imwrite(xx, map, fullfile('./image_comp', filename));
    
    index = index + 1;
    i = i/2;
    if i == 6
        i = 128;
    end
end
