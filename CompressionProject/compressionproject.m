% Compression Project
% Caitlin Butcher

% set the loss parameter, p, for compression
% lossParameter = 4, good
% lossParameter = 6, usable
% lossParameter = 8, noticeable distortion
lossParameter = 4;

% read in the image pg. 529

% log fence - image 2
y = imread('logfence.tif');


% declare variables rows, columns and set to y
size(y)
[rows, columns, colors]=size(y); 
x = y;
% Allow for viewing differences between compressed photo and original photo
z = y; 

% loop through to get the DCT matrix C pg. 528
C = zeros(8,8);
for i = 1:8
    for j = 1:8
        C(i,j) = cos((i-1)*(2*j-1)*pi/(2*8));
    end
end
C = sqrt(2/8)*C;
C(1,:)=C(1,:)/sqrt(2);

% Calculate Linear Quantization Matrix Q
Q = lossParameter * 8./hilb(8);

% zero matrix to hold photograph
photograph = zeros(rows,columns, 3); 

for plane = 1:3
    Xx = y(:,:,plane);
    
% Set C equal to 8x8 DCT matrix and then quantize in 8x8 blocks pg. 533
[rows, columns, colors]=size(y);
blocksi = rows / 8;
blocksj = columns / 8;
zeroMatrix = zeros(rows,columns);
for i = 1:blocksi
    for j = 1:blocksj
        Xd = double(Xx(1+(i-1)*8:i*8, 1+(j-1)*8:j*8));
        Xc = Xd - 128;
        Y = C*Xc*C';
        Yq = round(Y./Q);
        zeroMatrix(1+(i-1)*8:i*8, 1+(j-1)*8:j*8) = Yq;
    end
end

% Quantized Image
Yy = zeroMatrix;

% Recover the image after compression pg.533
for i = 1:blocksi
    for j = 1:blocksj
        Yq = double(Yy(1+(i-1)*8:i*8, 1+(j-1)*8:j*8));
        Ydq = Yq.*Q;
        Xdq = C'*Ydq*C;
        Xe = Xdq + 128;
        Xf = uint8(Xe);
        zeroMatrix(1+(i-1)*8:i*8, 1+(j-1)*8:j*8) = Xf;
    end
end

photograph(:,:,plane) = zeroMatrix; 

end

class(photograph)

% Compressed Photograph
figure('Name','Compressed Photograph');
imshow(uint8(photograph))

% Original Photograph
figure('Name', 'Original Photograph');
imshow(y);
