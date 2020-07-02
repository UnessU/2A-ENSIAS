#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "highgui.h"
#include <stdlib.h>
#include <stdio.h>

using namespace cv;

Mat monImage, erosion_dst, dilation_dst;

int erosion_elem = 0;
int erosion_size = 0;
int dilation_elem = 0;
int dilation_size = 0;
int const max_elem = 2;
int const max_kernel_size = 21;

/* Headers */
void Erosion(int, void*);
void Dilation(int, void*);

int main( int argc, char** argv )
{
  /* Charger l'image */
  monImage = imread("/home/ubuntucv/Pictures/Mikasa.jpg");

  /* Création des fenêtres */
  namedWindow("Erosion Demo", CV_WINDOW_AUTOSIZE );
  namedWindow("Dilation Demo", CV_WINDOW_AUTOSIZE );
  cvMoveWindow("Dilation Demo", monImage.cols, 0 );

  /* Trackbar de l'érosion */
  createTrackbar( "Element:\n 0: Rect \n 1: Cross \n 2: Ellipse", "Erosion Demo",
                  &erosion_elem, max_elem,
                  Erosion );

  createTrackbar( "Kernel size:\n 2n +1", "Erosion Demo",
                  &erosion_size, max_kernel_size,
                  Erosion );

  /* Trackbar de la dilatation */
  createTrackbar( "Element:\n 0: Rect \n 1: Cross \n 2: Ellipse", "Dilation Demo",
                  &dilation_elem, max_elem,
                  Dilation );

  createTrackbar( "Kernel size:\n 2n +1", "Dilation Demo",
                  &dilation_size, max_kernel_size,
                  Dilation );

  /* Par défaut */
  Erosion(0,0);
  Dilation(0,0);

  waitKey(0);
  return 0;
}

/* Fonction de l'érosion */
void Erosion(int, void*)
{
	int erosion_type;
	if(erosion_elem == 0)
	{ 
		erosion_type = MORPH_RECT;
	}
	else if(erosion_elem == 1)
	{
		erosion_type = MORPH_CROSS;
	}
	else if(erosion_elem == 2) 
	{
		erosion_type = MORPH_ELLIPSE;
	}

	Mat element = getStructuringElement(erosion_type,Size(2*erosion_size+1, 2*erosion_size+1), Point(erosion_size,erosion_size));

	/* Appliquer l'opération */
	erode(monImage, erosion_dst, element);
	imshow("Erosion Demo", erosion_dst);
}

/* Fonction de la dilatation */
void Dilation(int, void*)
{
	int dilation_type;
	if(dilation_elem == 0)
	{
		dilation_type = MORPH_RECT;
	}
	else if(dilation_elem == 1)
	{
		dilation_type = MORPH_CROSS; 
	}
	else if(dilation_elem == 2) 
	{
		dilation_type = MORPH_ELLIPSE;
	}

	Mat element = getStructuringElement(dilation_type, Size(2*dilation_size+1, 2*dilation_size+1), Point(dilation_size,dilation_size));
	
	/* Appliquer l'opération */
	dilate(monImage, dilation_dst, element);
	imshow("Dilation Demo", dilation_dst);
}
















