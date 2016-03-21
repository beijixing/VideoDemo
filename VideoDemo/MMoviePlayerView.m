//
//  MMoviePlayerView.m
//  VideoDemo
//
//  Created by ybon on 16/3/4.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "MMoviePlayerView.h"
#import "UIImage+ConvertToCGImageRef.h"

@interface MMoviePlayerView()
{
    CGImageRef _lastCgImage;
}
@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) MMovieDecoder *movieDecoder;
@end

@implementation MMoviePlayerView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
//        self.images = [[NSMutableArray alloc] init];
        self.movieDecoder = [[MMovieDecoder alloc] init];
        self.movieDecoder.sampleInternal = 0.001;
        self.movieDecoder.delegate = self;
    }
    return self;
}

- (void)mMoveDecoder:(MMovieDecoder *)movieDecoder onNewVideoFrameReady:(CMSampleBufferRef)videoBuffer {
    CGImageRef cgimage = [UIImage imageFromSampleBufferRef:videoBuffer];
    if (!(__bridge id)(cgimage)) {
        NSLog(@"cgimage fail");
        if (_lastCgImage) {
            CGImageRelease(_lastCgImage);
            _lastCgImage = nil;
        }
        return;
    }
//    [self.images addObject:((__bridge id)(cgimage))];
    
    typeof(self) __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf) {
            weakSelf.layer.contents = (__bridge id)cgimage;
        }
        if (_lastCgImage) {
            CGImageRelease(_lastCgImage);
            _lastCgImage = nil;
        }
        _lastCgImage = cgimage;
    });
    
}

- (void)mMoveDecoderOnDecoderFinished:(MMovieDecoder *)movieDecoder {
    NSLog(@"视频解档完成");
    // 得到媒体的资源
//    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:self.filePath] options:nil];
    // 通过动画来播放我们的图片
    
    typeof(self) __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf) {
            [weakSelf.movieDecoder transformViedoPathToSampBufferRef:self.filePath];
        }
//        weakSelf.layer.contents = nil;
        
//        float duration = asset.duration.value/asset.duration.timescale;
//        [imagesDict setObject:self.images forKey:self.filePath];
//        [durationDict setObject:[NSNumber numberWithFloat:duration] forKey:self.filePath];
//        [self playAnimationWithImages:self.images andDuration:duration];
//        [self.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (obj) {
//                obj = nil;
//            }
//        }];
    });
}

//结束播放
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop");
//    self.layer.contents = [self.images lastObject];
}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    [self.movieDecoder transformViedoPathToSampBufferRef:self.filePath];
    
}

//- (void)playAnimationWithImages:(NSArray *)images andDuration:(float)duration {
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
//    // asset.duration.value/asset.duration.timescale 得到视频的真实时间
//    animation.duration = duration;
//    animation.values = images;
//    animation.calculationMode = kCAAnimationDiscrete;
////    animation.removedOnCompletion = NO;
////    animation.fillMode = kCAFillModeForwards;
//    animation.repeatCount = MAXFLOAT;
//    animation.delegate = self;
//    [self.layer addAnimation:animation forKey:nil];
//}

- (void)dealloc {
    NSLog(@"dealloc11111");
    if (_lastCgImage) {
        CGImageRelease(_lastCgImage);
    }
    self.layer.contents = nil;
    self.movieDecoder = nil;
}



@end
