#include <math.h>

/* Function Definitions */
/*
 * Arguments    : double u
 *                double v
 * Return Type  : double
 */
double cosine_similarity(double u, double v)
{
  /*  Function Name: cosine_similarity */
  /*  */
  /*  Description: Calculates the cosine similarity between two hypervectors */
  /*  */
  /*  Arguments: */
  /*    u - first hypervector */
  /*    v - second hypervector */
  /*   */
  /*  Returns: */
  /*    sim - the cosine similarity between u and v (between -1 and 1) */
  /*  */
  return u * v / (fabs(u) * fabs(v));
}

/*
 * File trailer for cosine_similarity.c
 *
 * [EOF]
 */
