//
//  MMovieTableViewCell.h
//  VideoDemo
//
//  Created by 郑光龙 on 16/3/7.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import <UIKit/UIKit.h>MyAVPlayerView
#import "MMoviePlayerView.h"

@interface MMovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MMoviePlayerView *playerView;

@end
