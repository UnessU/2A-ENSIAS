#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
using namespace cv;

int main(int argc, char *argv[])
{
       Mat input = imread("03.jpg");
    Mat imGray;
    cvtColor(input,imGray,CV_BGR2GRAY);
    Mat noise = Mat(imGray.size(),CV_64F);
    Mat result;
    normalize(imGray, result, 0.0, 1.0, CV_MINMAX, CV_64F);
    randn(noise, 0, 0.1);
    result = result + noise;
    normalize(result, result, 0.0, 1.0, CV_MINMAX, CV_64F);
    result.convertTo(result, CV_32F, 255, 0);
    imwrite("result.jpg",result);
   waitKey(0);
    return 1;
}



