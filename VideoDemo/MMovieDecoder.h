//
//  MMovieDecoder.h
//  VideoDemo
//
//  Created by ybon on 16/3/4.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class MMovieDecoder;
@protocol MMovieDecoderDelegate <NSObject>

- (void)mMoveDecoder:(MMovieDecoder *)movieDecoder onNewVideoFrameReady:(CMSampleBufferRef)videoBuffer;
- (void)mMoveDecoderOnDecoderFinished:(MMovieDecoder *)movieDecoder;

@end

@interface MMovieDecoder : NSObject
@property (nonatomic, assign) float sampleInternal;
@property (nonatomic, assign) id<MMovieDecoderDelegate>delegate;
@property (nonatomic, copy) NSString *videoPath;
- (void)transformViedoPathToSampBufferRef:(NSString *)videoPath;
@end
