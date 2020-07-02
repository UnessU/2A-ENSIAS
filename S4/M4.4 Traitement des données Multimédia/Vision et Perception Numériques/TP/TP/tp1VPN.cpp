//============================================================================
// Name        : tp1_part1.cpp
// Author      : Azeddine
// Version     :
// Copyright   : 
// Description : charger image, la manipuler et l'enregistrer 
//				 Ainsi extraction de quelques informations tels que : couleur moyenne, histogrmmes, ...
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

	Mat source=imread("image/03.jpg",1);// ou Mat source = imread(argv[1], CV_LOAD_IMAGE_COLOR);
	
	if (source.empty()){
		cout <<"impossible de charger l'image "<<endl;
		return -1;
	}
	
// affichage
	namedWindow("image source");
	imshow("image source", source);

	// ecriture
	//vector<int> compression_params;
	imwrite("image/imageapres.png", source);//, compression_params);

// affiche de nombre de lignes et colonnes
	cout <<"Ligne : "<<source.rows <<"  Colonnes : "<< source.cols<<endl;

//affichage après conversion avec cvtColor
	Mat dest;
	cvtColor(source, dest, CV_RGB2GRAY);
	namedWindow("image dest");
	imshow("image dest", dest);

//Acces aux pixels de l'image
	Mat dest1;
	Vec3b pixel;
	int i, j;
	dest1.create(source.size(), CV_8U);

	for(i=0;i<source.rows;i++)
		for(j=0;j<source.cols;j++){
			pixel=source.at<Vec3b>(i,j);
			dest1.at<uchar>(i,j)=(uchar)(pixel.val[0]+pixel.val[1]+pixel.val[2])/3;
		}
	namedWindow("image dest 1");
	imshow("image dest 1", dest1);

//calcul de la couleur moyenne et de l'histogramme
	int hist[3][255];
	Vec3f moyenbgr;
		moyenbgr.val[0]=0;
		moyenbgr.val[1]=0;
		moyenbgr.val[2]=0;

		for(i=0;i<source.rows;i++)
			for(j=0;j<source.cols;j++){
				pixel=source.at<Vec3b>(i,j);
				hist[0][(pixel.val[0])]++;
				hist[1][(pixel.val[1])]++;
				hist[2][(pixel.val[2])]++;

				moyenbgr.val[0]+=pixel.val[0];
				moyenbgr.val[1]+=pixel.val[1];
				moyenbgr.val[2]+=pixel.val[2];

			}
		cout << "MoyenB :"<<moyenbgr.val[0]/(source.rows *source.cols)<<endl;
		cout << "MoyenG :"<<moyenbgr.val[1]/(source.rows *source.cols)<<endl;
		cout << "MoyenR :"<<moyenbgr.val[2]/(source.rows *source.cols)<<endl;

		cout << "Histogramme" <<endl;
		for(i=0;i<3;i++){
			for(j=0;j<source.cols;j++){
				cout << hist[i][j] <<"  ";
			}
			cout <<endl;
		}

//calcul d'histogramme avec fonction prédéfinie
		int bbins = 24, gbins = 24, rbins=24;
		int histSize[] = {bbins, gbins, rbins};
		float branges[] = { 0, 256 };
		float granges[] = { 0, 256 };
		float rranges[] = { 0, 256 };
		const float* ranges[] = {branges, granges, rranges };
		MatND hist1;
		int channels[] = {0, 1, 2};
		//int hist1[3][255];
		calcHist( &source, 1, channels, Mat(), hist1, 3, histSize, ranges,true,false );


	waitKey(0);
	return 1;
}
