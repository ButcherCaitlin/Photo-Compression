# Photo-Compression
Compresses and reconstitutes images using Matlab.


A loss parameter, variable 'p', is used for compression. To change the compression/quality of the image, change the loss parameter. 

Generally, the larger the loss parameter the more distortion the image will have upon recovering after compressing.

The image to be compressed is read on line 13, with "y = imread('logfence.tif');", this can be also be changed to compress different images.
