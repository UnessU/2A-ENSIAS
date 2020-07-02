#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>

using namespace std;
using namespace cv;

int main()
{
	/* Charger l'image */
	Mat monImage = imread("/home/ubuntucv/Pictures/Mikasa.jpg");

	/* Créer la fenêtre */
	namedWindow("My window", 1);

	/* Trackbar de luminosité */
	int iSliderValue1 = 50;
	createTrackbar("Brightness", "My window", &iSliderValue1, 100);

	/* Trackbar de contraste */
	int iSliderValue2 = 50;
	createTrackbar("Contrast", "My window", &iSliderValue2, 100);

	while (true)
	{
		Mat dst;
		int iBrightness  = iSliderValue1 - 50;
		double dContrast = iSliderValue2 / 50.0;
		monImage.convertTo(dst, -1, dContrast, iBrightness); 

		imshow("My window", dst);
	
		int iKey = waitKey(50);

		if (iKey == 27)
		{
			break;
		}
	}

      return 0;
}
