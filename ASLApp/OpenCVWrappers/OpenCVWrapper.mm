//
//  OpenCVWrapper.m
//  ASLApp
//
//  Created by Héctor J. Vázquez on 7/6/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

#import "OpenCVWrapper.h"

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

@implementation OpenCVWrapper

//Here we can use C++ code!!!

+(NSString *) openCVVersionString
{
    return [NSString stringWithFormat:@"OpenCV Version %s", CV_VERSION];
}

+(UIImage *) makeGrayFromImage:(UIImage *)image
{
    //Transform UIImage to cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    //If the image was already grayscale, return it
    if (imageMat.channels() == 1) return image;
    
    //Conver the cv::Mat image to gray
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, CV_BGR2GRAY);
    
    //Transform grayMat to UIImage and return
    return MatToUIImage(grayMat);
}


@end