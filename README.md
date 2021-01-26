# Gabor_image_filtering
This GUI programs uses the gabor filter with 5 scale (lambda,sigma,gama,psi) and 5 orientations (tetha=0:pi/4:pi). 
The code filters the input image (or image stack in .tif format) with the 2D gabor filter described by G:

        G(x,y,lambda,tetha,sigma,gama,psi)=exp(-pi*(x^2/sigma^2+(gama^2)*y^2/sigma^2))*(exp(1i*(2*pi/lambda*x+psi))-exp(-pi*(sigma/lambda)^2))

The term exp(-pi*(sigma/lambda)^2) is the inherent DC component as shown by: Movellan, J. R. - Tutorial on Gabor Filters. Tech. rep., 2002.
 

Guide to GUI (Gabor_image_filtering):
1) Download loadtiff.m,Gobar_image_filtering.m, and Gobar_image_filtering.fig files and put them in the same directory.
2) Run Gobar_image_filtering.m in Matlab (the code is used in matlab 2017  and matlab 2020)
3) Load tif image/stack using ¨Load an image¨ buttonthen you can see the image in Raw image axis (image intensity can be increased using Intensity (gain) slider)
4) You can define the right scales (lambda,sigma,gama,psi) in the GUI and push ¨Run filter on images¨ to see the filtered images and then save it with ''Save button''.
