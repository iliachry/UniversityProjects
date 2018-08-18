#include <stdio.h>
#include "mex.h"

/* Integral image */

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  double *ii, *prev_line;
  unsigned char *img;
  int sizeX, sizeY;
  const int *imDims;
  int posY, posX;
  double s;
  
  img = (unsigned char *)mxGetData(prhs[0]);
  imDims = mxGetDimensions(prhs[0]);
  sizeX = imDims[0];
  sizeY = imDims[1];

  plhs[0] = mxCreateDoubleMatrix(sizeX, sizeY, mxREAL);
  ii = mxGetPr(plhs[0]);

  prev_line = ii;
  
  *ii = *img;

  img++;
  ii++;
  for (posX = 1; posX < sizeX; posX++)
    {
      *ii = *img + *(ii-1);
      ii++;
      img++;
    }

  for (posY = 1; posY < sizeY; posY++)
  {
    s = 0;
    for (posX = 0; posX < sizeX; posX++)
      {
	s += *img;
	*ii = s + *prev_line;

	ii++;
	img++;
	prev_line++;
      }
  }
  
}
