//
//  OpenCVWrapper.h
//  ASLApp
//
//  Created by Héctor J. Vázquez on 7/6/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

//Returns version of OpenCV
+(NSString *) openCVVersionString;

//Convert UIImage to Grayscale
+(UIImage *) makeGrayFromImage:(UIImage *) image;

//Initialize Camera
//+(void) initializeCamera:(self);

@end
