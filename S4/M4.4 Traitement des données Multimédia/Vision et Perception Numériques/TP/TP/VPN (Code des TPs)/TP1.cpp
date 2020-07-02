//============================================================================
/*
 BOUKROUH Insaf
 DAOUDI Wissal
 GL1
*/
//============================================================================



#include <opencv2/opencv.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include<stdio.h>

using namespace cv;
using namespace std;

int main()
{
	Mat imGray1, imGray2;

	/* Charger une image en couleur */ 
	Mat monImage = imread("/home/ubuntucv/Pictures/Mikasa.jpg");
	imGray1 = imread("/home/ubuntucv/Pictures/Mikasa.jpg");

	/* L'afficher */ 
	imshow("Mon image", monImage);

	/* Les propriétés de l'image */
	cout << "Width  : " << monImage.cols << endl; // cout << "Width  : " << monImage.size().width << endl;
	cout << "Height : " << monImage.rows << endl; // cout << "Height : " << monImage.size().height << endl;
	
	/* Histogrammes */

	vector<Mat> bgr_planes;
	split(monImage, bgr_planes );
	int histSize = 256;
	float range[] = { 0, 256 } ;
	const float* histRange = {range};
	bool uniform = true; bool accumulate = false;
	Mat b_hist, g_hist, r_hist;

	calcHist( &bgr_planes[0], 1, 0, Mat(), b_hist, 1, &histSize, &histRange, uniform, accumulate );
	calcHist( &bgr_planes[1], 1, 0, Mat(), g_hist, 1, &histSize, &histRange, uniform, accumulate );
	calcHist( &bgr_planes[2], 1, 0, Mat(), r_hist, 1, &histSize, &histRange, uniform, accumulate );

	int hist_w = 512; int hist_h = 400;
	int bin_w = cvRound( (double) hist_w/histSize );

	Mat histImage( hist_h, hist_w, CV_8UC3, Scalar( 0,0,0) );

	normalize(b_hist, b_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat() );
	normalize(g_hist, g_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat() );
	normalize(r_hist, r_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat() );


	for(int i = 1; i < histSize; i++ )
	{
		line( histImage, Point( bin_w*(i-1), hist_h - cvRound(b_hist.at<float>(i-1)) ) ,
	                            Point( bin_w*(i), hist_h - cvRound(b_hist.at<float>(i)) ),
	                            Scalar( 255, 0, 0), 2, 8, 0  );
		line( histImage, Point( bin_w*(i-1), hist_h - cvRound(g_hist.at<float>(i-1)) ) ,
	                            Point( bin_w*(i), hist_h - cvRound(g_hist.at<float>(i)) ),
	                            Scalar( 0, 255, 0), 2, 8, 0  );
		line( histImage, Point( bin_w*(i-1), hist_h - cvRound(r_hist.at<float>(i-1)) ) ,
	                            Point( bin_w*(i), hist_h - cvRound(r_hist.at<float>(i)) ),
	                            Scalar( 0, 0, 255), 2, 8, 0  );
	}

	imshow("calcHist Demo", histImage);

	int HistR[257] = {0};
	int HistG[257] = {0};
	int HistB[257] = {0};
	for (int r = 0; r < monImage.rows; r++)
		for (int c = 0; c < monImage.cols; c++)
	        {
			Vec3b intensity = monImage.at<Vec3b>(Point(r,c));
			int Red = intensity.val[2];
			int Green = intensity.val[1];
			int Blue = intensity.val[0];
			HistR[Red] = HistR[Red]+1;
			HistB[Blue] = HistB[Blue]+1;
			HistG[Green] = HistG[Green]+1;
		}
	Mat HistPlotR (500, 256, CV_8UC3, Scalar(0, 0, 0));
	Mat HistPlotG (500, 256, CV_8UC3, Scalar(0, 0, 0));
	Mat HistPlotB (500, 256, CV_8UC3, Scalar(0, 0, 0));
	
	for (int i = 0; i < 256; i=i+2)
	{
        	line(HistPlotR, Point(i, 500), Point(i, 500-HistR[i]), Scalar(0, 0, 255),1,8,0);
        	line(HistPlotG, Point(i, 500), Point(i, 500-HistG[i]), Scalar(0, 255, 0),1,8,0);
        	line(HistPlotB, Point(i, 500), Point(i, 500-HistB[i]), Scalar(255, 0, 0),1,8,0);
    	}

	imshow("Red Histogram", HistPlotR);
	imshow("Green Histogram", HistPlotG);
	imshow("Blue Histogram", HistPlotB);



	/* Convertir en niveaux de gris*/

	// Méthode 1 : Gray = (R+G+B)/3

	for(int i = 0; i < monImage.rows; i++)
	{
		for(int j = 0; j < monImage.cols; j++)
		{
			for(int c(0); c < 3; c++)
			{
				imGray1.at<Vec3b>(i,j).val[c] = 
				(monImage.at<Vec3b>(i,j).val[0] + monImage.at<Vec3b>(i,j).val[1] + monImage.at<Vec3b>(i,j).val[2])/3;
			}		
		}
	}
	imshow("imGray (methode 1)",imGray1);
	
	// Méthode 2 : la fonction prédéfinie cvtColor
	Mat gray;
	cvtColor(monImage, imGray2, CV_BGR2GRAY);
	imshow("imGray (methode 2)",imGray2);

	/* Sauvegarder l'image */
	imwrite("/home/ubuntucv/Pictures/imGray1.jpg",imGray1);
	imwrite("/home/ubuntucv/Pictures/imGray2.jpg",imGray2);

	waitKey(0);

  return 0;
}


