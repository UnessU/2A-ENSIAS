#include <opencv2/opencv.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include<stdio.h>
using namespace cv;
using namespace std;

const int contrast_slider_max = 200;
int contrast_value = 100;
const int brightness_slider_max = 100;
int brightness_value = 0;
double alpha;
double beta;
Mat source, dst;
static void on_trackbar1(int, void*)
{
    alpha = (double)(1 - (double)brightness_value / brightness_slider_max);
    cout << "alpha : " << alpha << endl;
    Mat new_image = Mat::zeros(source.size(), source.type());
    source.convertTo(new_image, -1, alpha, beta);
    //3) - Apply Histogram Equalization
    //equalizeHist( new_image, new_image );
    imshow("/home/ubuntucv/Pictures/owl.jpg", new_image);

}

static void on_trackbar2(int, void*)
{
    beta = (double)(contrast_value - 100);
    cout << "beta : " << beta << endl;
    Mat new_image = Mat::zeros(source.size(), source.type());
    source.convertTo(new_image, -1, alpha, beta);
    //3) - Apply Histogram Equalization
       //equalizeHist( new_image, new_image );
    imshow("/home/ubuntucv/Pictures/owl.jpg", new_image);
}

int main() {///int argc, char** argv )
    String filename = "owl.jpg";
    String path = "/home/ubuntucv/Pictures/";
    source = imread(path + filename, 1);// ou Mat source = imread(argv[1], CV_LOAD_IMAGE_COLOR);
    if (source.empty()) {
        cout << "impossible de charger l'image " << endl;
        return -1;
    }

    int hist[3][255];
    Vec3f moyenbgr;
    Mat dest1;
    Vec3b pixel;
    //1)- Calcul de la moyenne
    dest1.create(source.size(), CV_8U);
    moyenbgr.val[0] = 0;
    moyenbgr.val[1] = 0;
    moyenbgr.val[2] = 0;

    for (int i = 0;i < source.rows;i++)
        for (int j = 0;j < source.cols;j++) {
            pixel = source.at<Vec3b>(i, j);
            hist[0][(pixel.val[0])]++;
            hist[1][(pixel.val[1])]++;
            hist[2][(pixel.val[2])]++;
            moyenbgr.val[0] += pixel.val[0];
            moyenbgr.val[1] += pixel.val[1];
            moyenbgr.val[2] += pixel.val[2];
        }
    cout << "Moyenne Blue :" << moyenbgr.val[0] / (source.rows * source.cols) << endl;
    cout << "Moyenne Green :" << moyenbgr.val[1] / (source.rows * source.cols) << endl;
    cout << "Moyenne Red :" << moyenbgr.val[2] / (source.rows * source.cols) << endl;

    imwrite(path + filename, source);



    //2)-
    namedWindow(path + filename);
    createTrackbar("Brightness", path + filename, &brightness_value, brightness_slider_max, on_trackbar1);
    createTrackbar("Contrast", path + filename, &contrast_value, contrast_slider_max, on_trackbar2);

    on_trackbar1(brightness_value, 0);
    on_trackbar2(contrast_value, 0);
    waitKey(0);
    return 0;
}