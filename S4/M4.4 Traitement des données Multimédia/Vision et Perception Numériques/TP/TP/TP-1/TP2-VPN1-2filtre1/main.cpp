#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
using namespace cv;


int main(int argc, char *argv[])
{
    Mat source= imread("result.jpg",1);
    int i, j;

//Filtre moyen avec un voisinage de 3*3
/*
    for(i=1;i<source.rows-1;i++)
			for(j=1;j<source.cols-1;j++){
                    source.at<Vec3b>(i,j).val[0]=(source.at<Vec3b>(i-1,j-1).val[0]+source.at<Vec3b>(i-1,j).val[0]+source.at<Vec3b>(i-1,j+1).val[0]
                                            +source.at<Vec3b>(i,j-1).val[0]+source.at<Vec3b>(i,j).val[0]+source.at<Vec3b>(i,j+1).val[0]
                                            +source.at<Vec3b>(i+1,j-1).val[0]+source.at<Vec3b>(i+1,j).val[0]+source.at<Vec3b>(i+1,j+1).val[0])/9;
                    source.at<Vec3b>(i,j).val[1]=(source.at<Vec3b>(i-1,j-1).val[1]+source.at<Vec3b>(i-1,j).val[1]+source.at<Vec3b>(i-1,j+1).val[1]
                                            +source.at<Vec3b>(i,j-1).val[1]+source.at<Vec3b>(i,j).val[1]+source.at<Vec3b>(i,j+1).val[1]
                                            +source.at<Vec3b>(i+1,j-1).val[1]+source.at<Vec3b>(i+1,j).val[1]+source.at<Vec3b>(i+1,j+1).val[1])/9;
                    source.at<Vec3b>(i,j).val[2]=(source.at<Vec3b>(i-1,j-1).val[2]+source.at<Vec3b>(i-1,j).val[2]+source.at<Vec3b>(i-1,j+1).val[2]
                                            +source.at<Vec3b>(i,j-1).val[2]+source.at<Vec3b>(i,j).val[2]+source.at<Vec3b>(i,j+1).val[2]
                                            +source.at<Vec3b>(i+1,j-1).val[2]+source.at<Vec3b>(i+1,j).val[2]+source.at<Vec3b>(i+1,j+1).val[2])/9;

				}
imwrite("result2.jpg",source);
*/
//Filtre  (-8 + 1*voisinage)

    for(i=1;i<source.rows-1;i++)
			for(j=1;j<source.cols-1;j++){
                    source.at<Vec3b>(i,j).val[0]=-source.at<Vec3b>(i,j).val[0]
                                           -(source.at<Vec3b>(i-1,j-1).val[0]+source.at<Vec3b>(i-1,j).val[0]+source.at<Vec3b>(i-1,j+1).val[0]
                                            +source.at<Vec3b>(i,j-1).val[0]+source.at<Vec3b>(i,j+1).val[0]
                                            +source.at<Vec3b>(i+1,j-1).val[0]+source.at<Vec3b>(i+1,j).val[0]+source.at<Vec3b>(i+1,j+1).val[0]);
               /*      source.at<Vec3b>(i,j).val[1]=8*source.at<Vec3b>(i,j).val[1]
                                            -(source.at<Vec3b>(i-1,j-1).val[1]+source.at<Vec3b>(i-1,j).val[1]+source.at<Vec3b>(i-1,j+1).val[1]
                                            +source.at<Vec3b>(i,j-1).val[1]+source.at<Vec3b>(i,j+1).val[1]
                                            +source.at<Vec3b>(i+1,j-1).val[1]+source.at<Vec3b>(i+1,j).val[1]+source.at<Vec3b>(i+1,j+1).val[1]);
                /*    source.at<Vec3b>(i,j).val[1]=(source.at<Vec3b>(i-1,j-1).val[1]+source.at<Vec3b>(i-1,j).val[1]+source.at<Vec3b>(i-1,j+1).val[1]
                                            +source.at<Vec3b>(i,j-1).val[1]+source.at<Vec3b>(i,j).val[1]+source.at<Vec3b>(i,j+1).val[1]
                                            +source.at<Vec3b>(i+1,j-1).val[1]+source.at<Vec3b>(i+1,j).val[1]+source.at<Vec3b>(i+1,j+1).val[1])/9;
                    source.at<Vec3b>(i,j).val[2]=(source.at<Vec3b>(i-1,j-1).val[2]+source.at<Vec3b>(i-1,j).val[2]+source.at<Vec3b>(i-1,j+1).val[2]
                                            +source.at<Vec3b>(i,j-1).val[2]+source.at<Vec3b>(i,j).val[2]+source.at<Vec3b>(i,j+1).val[2]
                                            +source.at<Vec3b>(i+1,j-1).val[2]+source.at<Vec3b>(i+1,j).val[2]+source.at<Vec3b>(i+1,j+1).val[2])/9;
*/
				}
    imwrite("result3.jpg",source);



   waitKey(0);
    return 1;
}





