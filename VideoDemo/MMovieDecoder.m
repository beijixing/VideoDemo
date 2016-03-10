//
//  MMovieDecoder.m
//  VideoDemo
//
//  Created by ybon on 16/3/4.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "MMovieDecoder.h"
@interface MMovieDecoder ()
{
    CMSampleBufferRef oldSampleBuffer;
}
@end
@implementation MMovieDecoder
- (void)transformViedoPathToSampBufferRef:(NSString *)videoPath {
    // 获取媒体文件路径的 URL，必须用 fileURLWithPath: 来获取文件 URL
    NSLog(@"videoPath = %@", videoPath);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *fileUrl = [NSURL fileURLWithPath:videoPath];
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileUrl options:nil];
        NSError *error = nil;
        
        AVAssetReader *reader = [[AVAssetReader alloc] initWithAsset:asset error:&error];
        BOOL success = (reader != nil);
        if (!success) {
            NSLog(@"%@", error.description);
            return;
        }
        
        NSArray *videoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
        AVAssetTrack *videoTrack =[videoTracks objectAtIndex:0];
        
        int m_pixelFormatType;
        //     视频播放时，
        m_pixelFormatType = kCVPixelFormatType_32BGRA;
        // 其他用途，如视频压缩
//        m_pixelFormatType = kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange;
        
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        [options setObject:@(m_pixelFormatType) forKey:(id)kCVPixelBufferPixelFormatTypeKey];
        AVAssetReaderTrackOutput *videoReaderOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:options];
        
        [reader addOutput:videoReaderOutput];
        [reader startReading];
        
        // 要确保nominalFrameRate>0，之前出现过android拍的0帧视频
        while ([reader status] == AVAssetReaderStatusReading && videoTrack.nominalFrameRate > 0) {
            // 读取 video sample
            CMSampleBufferRef videoBuffer = [videoReaderOutput copyNextSampleBuffer];
            NSLog(@"videoBuffer");
            

            
            if (videoBuffer && self.delegate && [self.delegate respondsToSelector:@selector( mMoveDecoder: onNewVideoFrameReady:)]) {
                [self.delegate mMoveDecoder:self onNewVideoFrameReady:videoBuffer];
            }else{
                if (oldSampleBuffer) {
                    CFRelease(oldSampleBuffer);
                    oldSampleBuffer = nil;
                }
                break;
            }
            
            if (videoBuffer) {
                if (oldSampleBuffer) {
                    CFRelease(oldSampleBuffer);
                    oldSampleBuffer = nil;
                }
                oldSampleBuffer = videoBuffer;
            }else {
                break;
            }
            // 根据需要休眠一段时间；比如上层播放视频时每帧之间是有间隔的,这里的 sampleInternal 我设置为0.001
            [NSThread sleepForTimeInterval:CMTimeGetSeconds(videoTrack.minFrameDuration)];
        }
        // 告诉上层视频解码结束
//        
        if (self.delegate && [self.delegate respondsToSelector:@selector(mMoveDecoderOnDecoderFinished:)]) {
            [self.delegate mMoveDecoderOnDecoderFinished:self];
        }
    });
}

-(void)dealloc {
    if (oldSampleBuffer) {
        CFRelease(oldSampleBuffer);
        oldSampleBuffer = nil;
    }
}
@end
