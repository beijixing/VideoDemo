//
//  MMoviePlayerView.h
//  VideoDemo
//
//  Created by ybon on 16/3/4.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMovieDecoder.h"

@interface MMoviePlayerView : UIView<MMovieDecoderDelegate>
@property(nonatomic, copy) NSString *filePath;

- (void)mMoveDecoder:(MMovieDecoder *)movieDecoder onNewVideoFrameReady:(CMSampleBufferRef)videoBuffer;
- (void)mMoveDecoderOnDecoderFinished:(MMovieDecoder *)movieDecoder;

@end
