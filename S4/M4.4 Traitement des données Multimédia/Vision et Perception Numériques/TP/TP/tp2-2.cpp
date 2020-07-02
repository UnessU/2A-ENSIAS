#include <opencv2/opencv.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include<stdio.h>
using namespace cv;
using namespace std;

int main() {///int argc, char** argv )

	String filename = "index.jpeg";
	String path = "/home/ubuntucv/Pictures/";

	Mat source = imread(path + filename, 1);// ou Mat source = imread(argv[1], CV_LOAD_IMAGE_COLOR);

	if (source.empty()) {
		cout << "impossible de charger l'image " << endl;
		return -1;
	}

	// affichage
	namedWindow("image source");
	imshow("image source", source);

	// ecriture
	//vector<int> compression_params;
	imwrite("image/imageapres.png", source);//, compression_params);

// affiche de nombre de lignes et colonnes
	cout << "Ligne : " << source.rows << "  Colonnes : " << source.cols << endl;

	//affichage après conversion avec cvtColor
	Mat src;
	cvtColor(source, src, CV_RGB2GRAY);
	namedWindow("image grayscale");
	imshow("image grayscale", src);
	// creation de MAT destination
	Mat dst1;
	Mat dst2;
	Mat dst3;
	Mat dst4;

	for (int j = 1; j <= 51; j = j + 2) {
		//Lissage homogene
		blur(source, dst1, Size(j, j));
		//Lissage gaussien Gaussianblur()
		GaussianBlur(source, dst2, Size(j, j), 0, 0);
		//Lissage median medianblur()
		medianBlur(source, dst3, j);
		//Lissage bilateral bilateralFiltrer()
		bilateralFilter(source, dst4, j, 80, 80);
		//affichage des diff lissages
		imshow("Lissage homogene blur()", dst1);
		imshow("Lissage gaussien Gaussianblur()", dst2);
		imshow("Lissage median medianblur()", dst3);
		imshow("Lissage bilateral bilateralFiltrer()", dst4);

		waitKey(1000);

	}



	return 1;
}
