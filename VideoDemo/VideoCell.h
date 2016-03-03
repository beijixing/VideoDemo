//
//  VideoCell.h
//  VideoDemo
//
//  Created by 郑光龙 on 16/3/2.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAVPlayerView.h"

@interface VideoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet MyAVPlayerView *videoView;
@end
