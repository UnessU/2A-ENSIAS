//============================================================================
// Name        : afficheimage.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================



#include <opencv2/opencv.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include<stdio.h>
using namespace cv;
using namespace std;

int main(){///int argc, char** argv )

	Mat source=imread("lena.jpg",1);  //Mat source; source = imread(argv[1], CV_LOAD_IMAGE_COLOR);

	if (source.empty()){
		cout <<"impossible de charger l'image "<<endl;
		return -1;
	}

// affichage
	namedWindow("image source", WINDOW_AUTOSIZE);
	imshow("image source", source);


	//properties

	cout << "source = "<< endl << " " << source << endl << endl;

	//separation de l image
	 vector<Mat> bgr_planes;
	 split( source, bgr_planes );

	 /// Establish the number of bins
	   int histSize = 256;

	   /// Set the ranges ( for B,G,R) )
	   float range[] = { 0, 256 } ;
	   const float* histRange = { range };

	   bool uniform = true; bool accumulate = false;

	     Mat b_hist, g_hist, r_hist;

	     /// Compute the histograms:
	     calcHist( &bgr_planes[0], 1, 0, Mat(), b_hist, 1, &histSize, &histRange, uniform, accumulate );
	     calcHist( &bgr_planes[1], 1, 0, Mat(), g_hist, 1, &histSize, &histRange, uniform, accumulate );
	     calcHist( &bgr_planes[2], 1, 0, Mat(), r_hist, 1, &histSize, &histRange, uniform, accumulate );


	     // Draw the histograms for B, G and R
	       int hist_w = 512; int hist_h = 400;
	       int bin_w = cvRound( (double) hist_w/histSize );

	       Mat histImage( hist_h, hist_w, CV_8UC3, Scalar( 0,0,0) );

	       /// Normalize the result to [ 0, histImage.rows ]
	       normalize(b_hist, b_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat() );
	       normalize(g_hist, g_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat() );
	       normalize(r_hist, r_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat() );


	       /// Draw for each channel
	       for( int i = 1; i < histSize; i++ )
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

	       /// Display
	       namedWindow("calcHist Demo", CV_WINDOW_AUTOSIZE );
	       imshow("calcHist Demo", histImage );

	       int HistR[257] = {0};
	           int HistG[257] = {0};
	           int HistB[257] = {0};
	           for (int i = 0; i < source.rows; i++)
	               for (int j = 0; j < source.cols; j++)
	               {
	                   Vec3b intensity = source.at<Vec3b>(Point(j, i));
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
	           namedWindow("Red Histogram");
	           namedWindow("Green Histogram");
	           namedWindow("Blue Histogram");
	           imshow("Red Histogram", HistPlotR);
	           imshow("Green Histogram", HistPlotG);
	           imshow("Blue Histogram", HistPlotB);


	// ecriture
	//vector<int> compression_params;
	//imwrite("image/imageapres.png", source);//, compression_params);

  waitKey(0);

  return 0;
}

