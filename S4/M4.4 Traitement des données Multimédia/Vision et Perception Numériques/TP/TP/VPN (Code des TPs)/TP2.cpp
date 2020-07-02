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
    Mat imOriginal = imread("/home/ubuntucv/Pictures/Mikasa.jpg");
    Mat imGray;
    Mat imBruit;

    /* Affichage de l'image imOriginale */
    imshow("imOriginal",imOriginal);


    /* Convertion en image à niveaux de gris */
    cvtColor(imOriginal,imGray,CV_BGR2GRAY);

    /* Ajout du bruit blanc gaussien à notre image à niveaux de gris */
    cv::Mat noise = Mat(imGray.size(),CV_64F);
    normalize(imGray, imBruit, 0.0, 1.0, CV_MINMAX, CV_64F);
    cv::randn(noise, 0, 0.1);
    imBruit = imBruit + noise;

    imshow("imGray avec bruit blanc gaussien",imBruit);
    normalize(imBruit, imBruit, 0.0, 1.0, CV_MINMAX, CV_64F);
    imBruit.convertTo(imBruit, CV_32F, 255, 0);
    cv::imwrite("/home/ubuntucv/Pictures/imBruit.jpg",imBruit);


    /* Filtre 1 (voisinage 3*3) */

    int i, j;
    for(i = 1; i < imOriginal.rows-1; i++)
	{
    	for(j = 1; j < imOriginal.cols-1; j++)
    	{
    		imOriginal.at<Vec3b>(i,j).val[0] = 
		(imOriginal.at<Vec3b>(i-1,j-1).val[0] + imOriginal.at<Vec3b>(i-1,j).val[0] + imOriginal.at<Vec3b>(i-1,j+1).val[0]
                 + imOriginal.at<Vec3b>(i,j-1).val[0] + imOriginal.at<Vec3b>(i,j).val[0] + imOriginal.at<Vec3b>(i,j+1).val[0]
                 + imOriginal.at<Vec3b>(i+1,j-1).val[0] + imOriginal.at<Vec3b>(i+1,j).val[0] + imOriginal.at<Vec3b>(i+1,j+1).val[0])/9;

    		imOriginal.at<Vec3b>(i,j).val[1] = 
		(imOriginal.at<Vec3b>(i-1,j-1).val[1] + imOriginal.at<Vec3b>(i-1,j).val[1] +imOriginal.at<Vec3b>(i-1,j+1).val[1]
                 + imOriginal.at<Vec3b>(i,j-1).val[1] + imOriginal.at<Vec3b>(i,j).val[1] + imOriginal.at<Vec3b>(i,j+1).val[1]
                 + imOriginal.at<Vec3b>(i+1,j-1).val[1] + imOriginal.at<Vec3b>(i+1,j).val[1] + imOriginal.at<Vec3b>(i+1,j+1).val[1])/9;

    		imOriginal.at<Vec3b>(i,j).val[2] = 
		(imOriginal.at<Vec3b>(i-1,j-1).val[2] + imOriginal.at<Vec3b>(i-1,j).val[2] + imOriginal.at<Vec3b>(i-1,j+1).val[2]
                + imOriginal.at<Vec3b>(i,j-1).val[2] + imOriginal.at<Vec3b>(i,j).val[2] + imOriginal.at<Vec3b>(i,j+1).val[2]
                 + imOriginal.at<Vec3b>(i+1,j-1).val[2] + imOriginal.at<Vec3b>(i+1,j).val[2] + imOriginal.at<Vec3b>(i+1,j+1).val[2])/9;

    	}
	}
      imshow("imOriginal avec filtre 1",imOriginal);
      imwrite("/home/ubuntucv/Pictures/imFiltre1.jpg",imOriginal);

    /* Filtre 2 */

    for(i = 1; i < imOriginal.rows-1; i++)
	{
    	for(j = 1; j < imOriginal.cols-1; j++)
    	{
    		imOriginal.at<Vec3b>(i,j).val[0] = ( imOriginal.at<Vec3b>(i,j).val[0] - 
		(imOriginal.at<Vec3b>(i-1,j-1).val[0] + imOriginal.at<Vec3b>(i-1,j).val[0] 
		+ imOriginal.at<Vec3b>(i-1,j+1).val[0] + imOriginal.at<Vec3b>(i,j-1).val[0] 
		+ imOriginal.at<Vec3b>(i,j+1).val[0] + imOriginal.at<Vec3b>(i+1,j-1).val[0] 
		+ imOriginal.at<Vec3b>(i+1,j).val[0] + imOriginal.at<Vec3b>(i+1,j+1).val[0]) ) * 8;

    		imOriginal.at<Vec3b>(i,j).val[1] = ( imOriginal.at<Vec3b>(i,j).val[1] - 
		(imOriginal.at<Vec3b>(i-1,j-1).val[1] + imOriginal.at<Vec3b>(i-1,j).val[1] 
		+ imOriginal.at<Vec3b>(i-1,j+1).val[1] + imOriginal.at<Vec3b>(i,j-1).val[1] 
		+ imOriginal.at<Vec3b>(i,j+1).val[1] + imOriginal.at<Vec3b>(i+1,j-1).val[1] 
		+ imOriginal.at<Vec3b>(i+1,j).val[1] + imOriginal.at<Vec3b>(i+1,j+1).val[1]) ) * 8;

    		imOriginal.at<Vec3b>(i,j).val[2] = ( imOriginal.at<Vec3b>(i,j).val[2] - 
		(imOriginal.at<Vec3b>(i-1,j-1).val[2] + imOriginal.at<Vec3b>(i-1,j).val[2] 
		+ imOriginal.at<Vec3b>(i-1,j+1).val[2] + imOriginal.at<Vec3b>(i,j-1).val[2] 
		+ imOriginal.at<Vec3b>(i,j+1).val[2] + imOriginal.at<Vec3b>(i+1,j-1).val[2] 
		+ imOriginal.at<Vec3b>(i+1,j).val[2] + imOriginal.at<Vec3b>(i+1,j+1).val[2]) ) * 8;

    	}
	}
      imshow("imOriginal avec filtre 2",imOriginal);
      imwrite("/home/ubuntucv/Pictures/imFiltre2.jpg",imOriginal); 

    /* Filtre 3 */
    int encore = 0;
    int aide;
	
    for(i = 1; i < imOriginal.rows-1; i++)
	{
    	for(j = 1; j < imOriginal.cols-1; j++)
    	{
		int valeurs[9];
		
		for (int c(0); c < 3; c++)
		{
			valeurs[0] = imOriginal.at<Vec3b>(i,j).val[c];
			valeurs[1] = imOriginal.at<Vec3b>(i-1,j-1).val[c];
			valeurs[2] = imOriginal.at<Vec3b>(i-1,j).val[c];
			valeurs[3] = imOriginal.at<Vec3b>(i-1,j+1).val[c];
			valeurs[4] = imOriginal.at<Vec3b>(i,j-1).val[c];
			valeurs[5] = imOriginal.at<Vec3b>(i,j+1).val[c];
			valeurs[6] = imOriginal.at<Vec3b>(i+1,j-1).val[c];
			valeurs[7] = imOriginal.at<Vec3b>(i+1,j).val[c];
			valeurs[8] = imOriginal.at<Vec3b>(i+1,j+1).val[c];
			do
			{
				encore = 0;
				for(int k(0); k < 9; k++)
				{
					if(valeurs[k] > valeurs[k+1])
					{
						aide = valeurs[k];
						valeurs[k] = valeurs[k+1];
						valeurs[k+1] = aide;
						encore = 1;
					}
				} 
			} while(encore == 1);
		
			imOriginal.at<Vec3b>(i,j).val[c] = valeurs[4];
		}

    	}
	}
      imshow("imOriginal avec filtre 3",imOriginal);
      imwrite("/home/ubuntucv/Pictures/imFiltre3.jpg",imOriginal);
      cv::waitKey(0);
      waitKey(0);
      return 0;

}


