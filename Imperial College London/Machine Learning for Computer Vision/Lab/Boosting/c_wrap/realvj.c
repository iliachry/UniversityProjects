#include <stdio.h>
#include <math.h>
#include "mex.h"

#define IMG(I, J) img[(J)*imSizeX + (I)]
#define IMG2(I, J) img2[(J)*imSizeX + (I)]

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  const mxArray *weak, *imgs, *X;		/* parameters */
  int l_X;			/* length of X */
  int l_imgs;			/* length of imgs */
  int l_weak;			/* length of weak */
  const int *XDims;             /* dimensions of X */
  const int *weakDims;		/* dimensions of weak */

  double *res, *tmp_res;        /* result */
  
  double *weak_data, *tmp_weak;	/* pointer to weak's data */
  double *X_data;               /* pointer to X's data */
  
  int type;                     /* weak's parameters */
  double r_startX, r_startY;
  double r_endX, r_endY;
  
  int i, j;                     /* loop variables */
  
  double *img, *img2;           /* big integral images and images squared */
  const int *imDims;            /* dimensions of big image */
  int imSizeX, imSizeY;         /* size of big image */

  int winStartX, winStartY;     /* position of subwindow in the image */
  int winEndX, winEndY;
  int winSizeX, winSizeY;

  double mean;                  /* mean over subwindow */
  double mean2;			/* mean over subwindow of ii squared */
  double std;			/* standard deviation */
  
  int startX, startY;           /* coordinates of weak in image for specific */
  int endX, endY;               /* window */
  int halfX, halfY;
  int thirdX, thirdY, third2X, third2Y;
  
  double black, white;          /* amount of black and white */
  long int sizeW, sizeB;

  double prevImage;                /* control for manipulating big images */

  weak = prhs[0];
  imgs = prhs[1];
  X = prhs[2];

  l_imgs = mxGetNumberOfElements(prhs[1]);

  XDims = mxGetDimensions(X);
  l_X = XDims[1];
  X_data = mxGetPr(prhs[2]);
  
  weakDims = mxGetDimensions(weak);
  l_weak = weakDims[1];
  weak_data = mxGetPr(weak);

  plhs[0] = mxCreateDoubleMatrix(l_weak, l_X, mxREAL);
  res = mxGetPr(plhs[0]);
  tmp_res = res;

  prevImage = -1;
  
  for (j=0; j<l_X; j++)          /* for all subwindows from X */
    {
      if (prevImage != *X_data)
	{
	  img = mxGetPr(mxGetFieldByNumber(imgs, (int)(*X_data-1), 0));
	  img2 = mxGetPr(mxGetFieldByNumber(imgs, (int)(*X_data-1), 1));
	  imDims = mxGetDimensions(mxGetFieldByNumber(imgs,
						      (int)(*X_data-1),
						      0));
	  imSizeX = imDims[0];
	  imSizeY = imDims[1];

	  prevImage = *X_data;
	}

      for (i=0, tmp_weak=weak_data; i<l_weak; i++, tmp_weak+=7)          /* for all subwindows from X */
	{
	  /* load weak's parameters */
	  type = (int)*tmp_weak;
	  r_startX = tmp_weak[1];
	  r_startY = tmp_weak[2];
	  r_endX = tmp_weak[3];
	  r_endY = tmp_weak[4];

	  /* window parameters */
	  winStartX = (int)X_data[1] - 1;   /* C counts from 0 and Matlab from 1 */
	  winStartY = (int)X_data[2] - 1;
	  winEndX = (int)X_data[3] - 1;
	  winEndY = (int)X_data[4] - 1;

	  winSizeX = winEndX - winStartX + 1;
	  winSizeY = winEndY - winStartY + 1;
      
	  mean = (IMG(winEndX, winEndY) + IMG(winStartX, winStartY) -
		  IMG(winStartX, winEndY) - IMG(winEndX, winStartY)) /
	    ((double)((winSizeX*winSizeY)));
	  mean2 = (IMG2(winEndX, winEndY) + IMG2(winStartX, winStartY) -
		  IMG2(winStartX, winEndY) - IMG2(winEndX, winStartY)) /
	    (winSizeX*winSizeY);
	  std = sqrt(mean2 - mean*mean);

	  /* find coordinates of weak in this window */
	  startX = (int)(r_startX * (winSizeX-1) + winStartX);
	  startY = (int)(r_startY * (winSizeY-1) + winStartY);
	  endX = (int)(r_endX * (winSizeX-1) + winStartX);
	  endY = (int)(r_endY * (winSizeY-1) + winStartY);
	  halfX = (startX + endX)/2;
	  halfY = (startY + endY)/2;
	  thirdX = (2*startX + endX)/3;
	  thirdY = (2*startY + endY)/3;
	  third2X = (startX + 2*endX)/3;
	  third2Y = (startY + 2*endY)/3;
     
	  switch (type)
	    {
	     case 1:   /* vertical separation in half, black on left */
	       {
		 black =
		   IMG(halfX, endY) + IMG(startX, startY) -
		   IMG(startX, endY) - IMG(halfX, startY);
		 white =
		   IMG(endX, endY) + IMG(halfX, startY) -
		   IMG(halfX, endY) - IMG(endX, startY);
		 sizeB = (halfX - startX) * (endY - startY);
		 sizeW = (endX - halfX) * (endY - startY);
		 break;
	       }
	     case 2:   /* horizontal separation in half, black up */
	       {
		 black =
		   IMG(endX, halfY) + IMG(startX, startY) -
		   IMG(startX, halfY) - IMG(endX, startY);
		 white =
		   IMG(endX, endY) + IMG(startX, halfY) -
		   IMG(endX, halfY) - IMG(startX, endY);
		 sizeB = (endX - startX) * (halfY - startY);
		 sizeW = (endX - startX) * (endY - halfY);
		 break;
	       }
	     case 3:   /* horizontal 3-blocks separation, black in middle */
	       {
		 black =
		   IMG(third2X, endY) + IMG(thirdX, startY) -
		   IMG(thirdX, endY) - IMG(third2X, startY);
		 white =
		   IMG(thirdX, endY) + IMG(startX, startY) -
		   IMG(startX, endY) - IMG(thirdX, startY) +
		   IMG(endX, endY) + IMG(third2X, startY) -
		   IMG(third2X, endY) - IMG(endX, startY);
		 sizeB = (third2X - thirdX) * (endY - startY);
		 sizeW = (thirdX - startX) * (endY - startY) +
		   (endX - third2X) * (endY - startY);
		 break;
	       }
	     case 4:   /* vertical 3-blocks separation, black in middle */
	       {
		 black =
		   IMG(endX, third2Y) + IMG(startX, thirdY) -
		   IMG(startX, third2Y) - IMG(endX, thirdY);
		 white =
		   IMG(endX, thirdY) + IMG(startX, startY) -
		   IMG(startX, thirdY) - IMG(endX, startY) +
		   IMG(endX, endY) + IMG(startX, third2Y) -
		   IMG(startX, endY) - IMG(endX, third2Y);
		 sizeB = (endX - startX) * (third2Y - thirdY);
		 sizeW = (endX - startX) * (thirdY - startY) +
		   (endX - startX) * (endY - third2Y);
		 break;
	       }
	     case 5:   /* vert-horiz separation, upper left corner black */
	       {
		 black =
		   IMG(halfX, halfY) + IMG(startX, startY) -
		   IMG(startX, halfY) - IMG(halfX, startY) +
		   IMG(endX, endY) + IMG(halfX, halfY) -
		   IMG(halfX, endY) - IMG(endX, halfY);
		 white =
		   IMG(endX, halfY) + IMG(halfX, startY) -
		   IMG(halfX, halfY) - IMG(endX, startY) +
		   IMG(halfX, endY) + IMG(startX, halfY) -
		   IMG(startX, endY) - IMG(halfX, halfY);
		 sizeB = (halfX - startX) * (halfY - startY) +
		   (endX - halfX) * (endY - halfY);
		 sizeW = (endX - halfX) * (halfY - startY) +
		   (halfX - startX) * (endY - halfY);
		 break;
	       }
	    }
	  
	  *tmp_res++ = white/(sizeW*std) - black/(sizeB*std);
	} /* for (i=0;... */

      X_data += 5;             /* number of parameters of each window */
    } /* for (j=0;... */
}
  
