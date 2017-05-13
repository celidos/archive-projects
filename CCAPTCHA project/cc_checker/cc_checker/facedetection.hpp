#ifndef FACEDETECTION_HPP_INCLUDED
#define FACEDETECTION_HPP_INCLUDED

#include <vector>
#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

using namespace std;
using namespace cv;

String face_cascade_name = "haarcascade_frontalface_alt.xml";
CascadeClassifier face_cascade;

void DetectFaces(Mat frame, int &resultpaste, bool DisplayOrNot = false)
{
    std::vector<Rect> faces;
    Mat frame_gray;

    cvtColor( frame, frame_gray, CV_BGR2GRAY );
    equalizeHist( frame_gray, frame_gray );

    face_cascade.detectMultiScale(frame_gray, faces, 1.04, 1, 0|CV_HAAR_SCALE_IMAGE ); //, Size(30, 30) );
    resultpaste = faces.size();
    if (DisplayOrNot && resultpaste != 0)
    {
        Mat imgcopy = frame.clone();
        for (size_t i = 0; i < faces.size(); i++)
        {
            Point center( faces[i].x + faces[i].width*0.5, faces[i].y + faces[i].height*0.5 );
            ellipse( imgcopy, center, Size( faces[i].width*0.5, faces[i].height*0.5), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0);
        }
        namedWindow("Face");
        imshow("Face", imgcopy);
        waitKey(0);
        destroyWindow("Face");
        imshow("Face", imgcopy);
    }
}

#endif // FACEDETECTION_HPP_INCLUDED
