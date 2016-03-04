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

@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) MMovieDecoder *movieDecoder;

@end

@implementation MMoviePlayerView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        self.images = [[NSMutableArray alloc] init];
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
        return;
    }
    [self.images addObject:((__bridge id)(cgimage))];
    CGImageRelease(cgimage);
}

- (void)mMoveDecoderOnDecoderFinished:(MMovieDecoder *)movieDecoder {
    NSLog(@"视频解档完成");
    // 得到媒体的资源
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:self.filePath] options:nil];
    // 通过动画来播放我们的图片
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    // asset.duration.value/asset.duration.timescale 得到视频的真实时间
    animation.duration = asset.duration.value/asset.duration.timescale;
    animation.values = self.images;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:nil];
    // 确保内存能及时释放掉
    [self.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) {
            obj = nil;
        }
    }];
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
@end
