//
//  AVPlayerView.m
//  VideoDemo
//
//  Created by 郑光龙 on 16/3/2.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "MyAVPlayerView.h"

@interface MyAVPlayerView ()
//@property (nonatomic, strong)AVPlayerLayer *playerLayer;
@end

@implementation MyAVPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame])
    {
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer*)[self layer] player];
}

@end
