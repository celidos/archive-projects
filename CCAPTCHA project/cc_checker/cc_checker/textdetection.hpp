#ifndef TEXTDETECTION_HPP_INCLUDED
#define TEXTDETECTION_HPP_INCLUDED

#include "trg.hpp"

using namespace std;
using namespace cv;

void DetectLetters(Mat img, int &resultpaste, bool DisplayOrNot = false)
{
    uint8_t* pixelPtr = (uint8_t*)img.data;
    int cn = img.channels();
    //Scalar_<uint8_t> bgrPixel;

    vector <vector<trg::Rgb>> Matrix;
    vector<trg::Rgb> empt(img.cols);
    Matrix.assign(img.rows, empt);
    for (int i = 0; i < img.rows; i++)
    {
        //Matrix.push_back(empt);
        for (int j = 0; j < img.cols; j++)
        {
            trg::Rgb temp;
            temp.r = pixelPtr[i*img.cols*cn + j*cn + 2]; // R
            temp.b = pixelPtr[i*img.cols*cn + j*cn + 0]; // B
            temp.g = pixelPtr[i*img.cols*cn + j*cn + 1]; // G
            Matrix[i][j] = temp;
            // do something with BGR values...
        }
    }
    vector< trg::Rect> r  = get_textlike_regions(Matrix);
    resultpaste =  r.size();

    if (DisplayOrNot && resultpaste != 0)
    {
        Mat imgcopy = img.clone();
        for (int i = 0; i < r.size(); i++)
            rectangle(imgcopy, Point(r[i].x1, r[i].y1), Point(r[i].x2, r[i].y2), Scalar(0, 255, 0), 3);
        namedWindow("Letter");
        imshow("Letter", imgcopy);
        waitKey(0);
        destroyWindow("Letter");
        imshow("Letter", imgcopy);
    }


}

/*void DetectLetters(Mat img, int &resultpaste, bool DisplayOrNot = false)
{
    vector <Rect> boundRect;
    Mat img_gray, img_sobel, img_threshold, element;

    cvtColor(img, img_gray, CV_BGR2GRAY);
    Sobel(img_gray, img_sobel, CV_8U, 1, 0, 3, 1, 0, BORDER_DEFAULT);
    threshold(img_sobel, img_threshold, 0, 255, CV_THRESH_OTSU + CV_THRESH_BINARY);
    element = getStructuringElement(MORPH_RECT, Size(17, 3));
    morphologyEx(img_threshold, img_threshold, CV_MOP_CLOSE, element); //Does the trick
    vector< vector< Point> > contours;
    findContours(img_threshold, contours, 0, 1);
    vector<vector<Point> > contours_poly(contours.size());
    for (int i = 0; i < contours.size(); ++i)
        if (contours[i].size() > 100)
        {
            approxPolyDP( Mat(contours[i]), contours_poly[i], 3, true );
            Rect appRect( boundingRect( Mat(contours_poly[i]) ));
            if (appRect.width>appRect.height)
                boundRect.push_back(appRect);
        }
    resultpaste = boundRect.size();
    if (DisplayOrNot && resultpaste != 0)
    {
        Mat imgcopy = img.clone();
        for (int i = 0; i < boundRect.size(); i++)
            rectangle(imgcopy, boundRect[i], Scalar(0, 255, 0), 3, 8, 0);
        namedWindow("Letter");
        imshow("Letter", imgcopy);
        waitKey(0);
        destroyWindow("Letter");
        imshow("Letter", imgcopy);
    }

}*/

#endif // TEXTDETECTION_HPP_INCLUDED
