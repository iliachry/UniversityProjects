#include "mex.h"

/* function findparthresh
   parameters:
*/
    
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  const mxArray *evals, *pos_thresh;		/* parameters */
  double *edata, *ptdata;

  double *out_thresh, *out_parity, *out_sum;

  double *Y, *Ytmp;

  double *D, *Dtmp;		/* distribution */
  
  int l_evals;			/* length of evals */
  const int *eDims;             /* dimensions of vector */

  int l_pt;
  const int *pDims;

  /*unsigned long count_1, count_m1;*/
  double count_1, count_m1;

  double best_thresh;

  double a, b;

  double best_sum, best_parity;
  double cur_thresh, cur_sum, cur_parity;

  double sum_1_right, sum_1_left, sum_m1_right, sum_m1_left;

  int i;

  /*
    prhs[0] ... l_evals x 2 matrix, where first column are realvj results on
    all samples from TS sorted in ascending order and second column are
    corresponding correct results from {-1, 1}. In the third column are
    corresponding distribution values.
  */
  evals = prhs[0];
  eDims = mxGetDimensions(evals);
  l_evals = eDims[0];
  edata = mxGetPr(evals);

  Y = edata + l_evals;

  D = edata + 2*l_evals;

  /*
    prhs[1] ... vector of possible thresholds. They are between each two
    subsequent distinct values in the first column of prhs[0]
  */
  pos_thresh = prhs[1];
  pDims = mxGetDimensions(pos_thresh);
  l_pt = pDims[1];
  ptdata = mxGetPr(pos_thresh);

  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
  out_thresh = mxGetPr(plhs[0]);
  plhs[1] = mxCreateDoubleMatrix(1, 1, mxREAL);
  out_parity = mxGetPr(plhs[1]);
  plhs[2] = mxCreateDoubleMatrix(1, 1, mxREAL);
  out_sum = mxGetPr(plhs[2]);

  /* beginning of computation kernel */
  
  best_thresh = *ptdata;

  count_1 = count_m1 = 0;

  for (i=0, Ytmp = Y, Dtmp = D; i<l_evals; i++)
    if (*Ytmp++ == 1)
      count_1 += *Dtmp++;
    else
      count_m1 += *Dtmp++;

  sum_1_right = count_1;
  sum_1_left = 0;
  sum_m1_right = count_m1;
  sum_m1_left = 0;
  
  while (*edata <= best_thresh)
    {
      if (*Y == 1)
	{
	  sum_1_right -= *D;
	  sum_1_left += *D;
	}
      if (*Y == -1)
	{
	  sum_m1_right -= *D;
	  sum_m1_left += *D;
	}
      edata++;
      Y++;
      D++;
    }

  a = sum_1_right + sum_m1_left;
  b = sum_1_left + sum_m1_right;
  
  if (a < b)
    {
      best_sum = a;
      best_parity = -1;
    }
  else
    {
      best_sum = b;
      best_parity = 1;
    }

  for(i=1; i<l_pt; i++)
    {
      cur_thresh = *ptdata++;
    
      while (*edata <= cur_thresh)
	{
	  if (*Y == 1)
	    {
	      sum_1_right -= *D;
	      sum_1_left += *D;
	    }
	  if (*Y == -1)
	    {
	      sum_m1_right -= *D;
	      sum_m1_left += *D;
	    }
	  edata++;
	  Y++;
	  D++;
	}
    
      a = sum_1_right + sum_m1_left;
      b = sum_1_left + sum_m1_right;

      if (a < b)
	{
	  cur_sum = a;
	  cur_parity = -1;
	}
      else
	{
	  cur_sum = b;
	  cur_parity = 1;
	}

      if (cur_sum < best_sum)
	{
	  best_sum = cur_sum;
	  best_parity = cur_parity;
	  best_thresh = cur_thresh;
	}
    } /* for... */
  
  *out_thresh = best_thresh;
  *out_parity = best_parity;
  *out_sum = best_sum;
}
