# Gobar_image_filtering
This GUI programs uses the Gabor Filter with 5 scale (lambda,sigma,gama,psi) and 8 orientations (tetha=0:pi/4:2pi). 
The code filters the input image (or image stack in .tif format) with the 2D Gabor filter G described by :

        G(x,y,lambda,tetha,sigma,gama,psi)=exp(-pi*(x^2/sigma^2+(gama^2)*y^2/sigma^2))*(exp(1i*(2*pi/lambda*x+psi))-exp(-pi*(sigma/lambda)^2))

The term exp(-pi*(sigma/lambda)^2) is the inherent DC component as shown by: Movellan, J. R. - Tutorial on Gabor Filters. Tech. rep., 2002.
 

guide to GUI (Gobar_image_filtering):
download loadtiff.m,Gobar_image_filtering.m, and Gobar_image_filtering.fig files and put them in same directory.
run Gobar_image_filtering.m in matlab (the code is used in matlab 2017  and matlab 2020)
load tif image/stack using ¨Load an image¨ bottom then you can the image in Raw image axis (image intensity can be increased using Intensity (gain) slider)
You can define the right scales (lambda,sigma,gama,psi) in GUI and push ¨Run filter on images¨ to see the filtered images.
