//
//  UIImage+ConvertToCGImageRef.h
//  VideoDemo
//
//  Created by ybon on 16/3/4.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (ConvertToCGImageRef)
+ (CGImageRef)imageFromSampleBufferRef:(CMSampleBufferRef)sampleBufferRef;
@end
