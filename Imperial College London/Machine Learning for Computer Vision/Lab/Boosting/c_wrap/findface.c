#include <stdio.h>
#include <math.h>
#include "mex.h"

/* function findface
   parameters:
   prhs[0] .... image
       [1] .... 7xN array of classificators
       [2] .... 1xN array of alphas
   return:
   plhs[0] .... found faces (5xN array)
*/


double *ii(unsigned char *img, unsigned long width, unsigned long height)
{
  double *ii, *ii_ret;
  double *prev_line;
  int posY, posX;
  double s;
  
  ii_ret = ii = mxCalloc(height*width, sizeof(double));
  if (!ii) return NULL;

  prev_line = ii;
  
  *ii = *img;

  img++;
  ii++;
  for (posX = 1; posX < height; posX++)
    {
      *ii = *img + *(ii-1);
      ii++;
      img++;
    }

  for (posY = 1; posY < width; posY++)
  {
    s = 0;
    for (posX = 0; posX < height; posX++)
      {
	s += *img;
	*ii = s + *prev_line;

	ii++;
	img++;
	prev_line++;
      }
  }

  return ii_ret;
}


double *ii2(unsigned char *img, unsigned long width, unsigned long height)
{
  double *ii, *ii_ret;
  double *prev_line;
  int posY, posX;
  double s;
  
  ii_ret = ii = mxCalloc(height*width, sizeof(double));
  if (!ii) return NULL;
  
  prev_line = ii;
  
  *ii = *img * *img;

  img++;
  ii++;
  for (posX = 1; posX < height; posX++)
    {
      *ii = *img * *img + *(ii-1);
      ii++;
      img++;
    }

  for (posY = 1; posY < width; posY++)
  {
    s = 0;
    for (posX = 0; posX < height; posX++)
      {
	s += *img * *img;
	*ii = s + *prev_line;

	ii++;
	img++;
	prev_line++;
      }
  }

  return ii_ret;
}

#define IMG(I, J) img[(J)*img_height + (I)]
#define IMG2(I, J) img2[(J)*img_height + (I)]
#define HALFX halfX = (startX + endX)/2;
#define HALFY halfY = (startY + endY)/2;
#define THIRDX thirdX = (2*startX + endX)/3;
#define THIRDY thirdY = (2*startY + endY)/3;
#define THIRD2X third2X = (startX + 2*endX)/3;
#define THIRD2Y third2Y = (startY + 2*endY)/3;


double classify(double *cl, int cl_size, double *alpha,
		double *img, double *img2, int img_width, int img_height,
		unsigned long* win)
{
  int type;                     /* weak's parameters */
  double r_startX, r_startY;
  double r_endX, r_endY;
  double parity, thresh;

  unsigned long winStartX, winStartY; /* position of subwindow in the image */
  unsigned long winEndX, winEndY;
  unsigned long winSizeX, winSizeY;
  
  double mean;                  /* mean over subwindow */
  double mean2;			/* mean over subwindow of ii squared */
  double std;			/* standard deviation */
  
  int startX, startY;           /* coordinates of weak in image for specific */
  int endX, endY;               /* window */
  int halfX, halfY;
  int thirdX, thirdY, third2X, third2Y;
  
  double black, white;          /* amount of black and white */
  int sizeW, sizeB;

  double *tmp_weak;		/* pointer to weak's data */
  
  double result = 0;
  
  int i;
  
  /*  ev = vj(cl(:, H(:,1)), imgs, X);
      result = sign(H(:,2)' * ev);*/

  /*printf("classify...\n");*/
  
  /* window parameters */
  winStartX = win[0];
  winStartY = win[1];
  winEndX = win[2];
  winEndY = win[3];
  
  winSizeX = winEndX - winStartX + 1;
  winSizeY = winEndY - winStartY + 1;

  mean = (IMG(winEndX, winEndY) + IMG(winStartX, winStartY) -
	  IMG(winStartX, winEndY) - IMG(winEndX, winStartY)) /
    (winSizeX*winSizeY);
  mean2 = (IMG2(winEndX, winEndY) + IMG2(winStartX, winStartY) -
	   IMG2(winStartX, winEndY) - IMG2(winEndX, winStartY)) /
    (winSizeX*winSizeY);
  std = sqrt(mean2 - mean*mean);

  /*printf("mean: %f, mean2: %f, std: %f\n", mean, mean2, std);*/
  
  for (i=0, tmp_weak=cl; i<cl_size; i++)         
    {
      /* load weak's parameters */
      type = (int)*tmp_weak++;
      r_startX = *tmp_weak++;
      r_startY = *tmp_weak++;
      r_endX = *tmp_weak++;
      r_endY = *tmp_weak++;
      thresh = *tmp_weak++;
      parity = *tmp_weak++;
	  
      /* find coordinates of weak in this window */
      startX = (int)(r_startX * (winSizeX-1) + winStartX);
      startY = (int)(r_startY * (winSizeY-1) + winStartY);
      endX = (int)(r_endX * (winSizeX-1) + winStartX);
      endY = (int)(r_endY * (winSizeY-1) + winStartY);

      switch (type)
	{
	 case 1:   /* vertical separation in half, black on left */
	   {
	     HALFX;
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
	     HALFY;
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
	     THIRDX;
	     THIRD2X;
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
	     THIRDY;
	     THIRD2Y;
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
	     HALFX;
	     HALFY;
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
      
      /*      if (((white - sizeW*mean) - (black - sizeB*mean)) / ((sizeW + sizeB) * 255) * parity > (parity * thresh))*/
      if (((white/(sizeW*std) - black/(sizeB*std)) * parity) > (parity * thresh))
	result += *alpha++;
      else
	result -= *alpha++;
	  
    } /* for (i=0;... */

  /*  return ((result > 0) ? 1 : -1);*/
  return result;
}



void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  const mxArray *img, *cl, *alpha;		/* parameters */
  unsigned long posX, posY, endX, endY;
  
  const int *imgDims;
  unsigned long img_width, img_height;
  unsigned char *img_data;

  typedef struct Soutput{
    double X[4];
    struct Soutput *prev;
  } Soutput;
  struct Soutput *output = NULL, *tmpoutput;
  int out_length = 0;
  double *out_data;

  double *iimg, *iimg2;

  const int *clDims;
  unsigned long cl_count;
  double *cl_data;

  double *alpha_data;

  unsigned long maxSize;
  unsigned long width, height;
  unsigned long stepX, stepY;

  long total, rfalse;

  double result;

  unsigned long X[4];

  /*printf("------------ new image ----------- \n");*/
  
  img = prhs[0];
  imgDims = mxGetDimensions(img);
  img_height = imgDims[0];
  img_width = imgDims[1];
  img_data = (unsigned char *)mxGetData(img);

  cl = prhs[1];
  clDims = mxGetDimensions(cl);
  cl_count = clDims[1];
  cl_data = mxGetPr(cl);

  alpha = prhs[2];
  alpha_data = mxGetPr(alpha);

  iimg = ii(img_data, img_width, img_height);
  iimg2 = ii2(img_data, img_width, img_height);

  /*printf("II done\n");*/
  
  

  if (img_height < img_width) 
    maxSize = img_height;
  else 
    maxSize = img_width;

  width = 24; 
  height = 24;
  stepX = height/10;
  stepY = width/10;

  /*  false_pos = [];*/

  total = 0;			/* number of tested subwindows */
  rfalse = 0;			/* number of false detections */
  while (width <= maxSize)
    {
      for (posX=0; posX<(img_height-width+1); posX += stepX)
	for (posY=0; posY<(img_width-height+1); posY += stepY)
	  {
	    /*printf("1\n");*/
	    endX = posX + width - 1;
	    endY = posY + height - 1;
	    *X = posX;
	    X[1] = posY;
	    X[2] = endX;
	    X[3] = endY;
	    total++;
	    if ((result = classify(cl_data, cl_count, alpha_data,
				   iimg, iimg2, img_width, img_height, X)) > 0)
	      {
		rfalse = rfalse + 1;
		/* save found face */
		tmpoutput = (struct Soutput *)mxCalloc(1, sizeof(struct Soutput));
		tmpoutput->prev = output;
		tmpoutput->X[0] = X[0]+1; /* Matlab counts from 1!!! */
		tmpoutput->X[1] = X[1]+1;
		tmpoutput->X[2] = X[2]+1;
		tmpoutput->X[3] = X[3]+1;
		output = tmpoutput;
		out_length++;
		/*printf("%d %d %d %d %f\n", *X, X[1], X[2], X[3], result);*/
	      }
	  }

      width = width * 1.25;
      height = height * 1.25;
      stepX = height/10;
      stepY = width/10;
    }

  if (out_length)
    {
      plhs[0] = mxCreateDoubleMatrix(5, out_length, mxREAL);
      out_data = mxGetPr(plhs[0]);
      while (output)
	{
	  *out_data++ = 1;
	  memcpy(out_data, output->X, sizeof(double) * 4);
	  tmpoutput = output->prev;
	  mxFree(output);
	  output = tmpoutput;
	  out_data += 4;
	}
    }
  else
    plhs[0] = mxCreateDoubleMatrix(0, 0, mxREAL);
  

  printf("total: %ld found: %d\n", total, rfalse);

  mxFree(iimg);
  mxFree(iimg2);

  /*printf("II free\n");*/
}
