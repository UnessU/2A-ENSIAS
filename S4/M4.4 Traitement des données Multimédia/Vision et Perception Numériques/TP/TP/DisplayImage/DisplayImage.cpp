#include <opencv2/highgui/highgui.hpp>


using namespace cv ;


int main(int argc , char ** argv)
{
	Mat img = imread(argv[1] , -1);

	if( img.empty() )
	{
		return -1 ;
	}
	namedWindow("ImageDisplayer" , WINDOW_AUTOSIZE);
	imshow("ImageDisplayer" , img);
	waitKey(0);
	destroyWindow("ImageDisplayer");
}
