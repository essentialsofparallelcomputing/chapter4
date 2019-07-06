#include <stdlib.h>
#include "malloc2D.h"

double **malloc2D(int jmax, int imax);

int main(int argc, char *argv[])
{
   int i, j;
   int imax=100, jmax=100;

   double **x = (double **)malloc2D(jmax,imax);

   // 1D access of the contiguous 2D array
   double *x1d=x[0];
   for (i = 0; i< imax*jmax; i++){
      x1d[i] = 0.0;
   }

   // 2D access of the contiguous 2D array
   for (j = 0; j< jmax; j++){
      for (i = 0; i< imax; i++){
         x[j][i] = 0.0;
      }
   }

}

double **malloc2D(int jmax, int imax)
{
   // first allocate a block of memory for the row pointers and the 2D array
   double **x = (double **)malloc(jmax*sizeof(double *) + jmax*imax*sizeof(double));

   // Now assign the start of the block of memory for the 2D array after the row pointers
   x[0] = (double *)x + jmax;

   // Last, assign the memory location to point to for each row pointer
   for (int j = 1; j < jmax; j++) {
      x[j] = x[j-1] + imax;
   }

   return(x);
}