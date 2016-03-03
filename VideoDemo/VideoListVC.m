//
//  VideoListVC.m
//  VideoDemo
//
//  Created by 郑光龙 on 16/3/2.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "VideoListVC.h"
#import "VideoCell.h"
#import "ViewController.h"
#import "MyAVPlayerView.h"

@interface VideoListVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation VideoListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self.videoList registerNib:[UINib nibWithNibName:@"VideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VideoCell"];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)addButtonClicked:(id)sender {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *videoCell = (VideoCell *)cell;
    NSString *fileName = [NSString stringWithFormat:@"test%ld", indexPath.row +1];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    AVPlayer *player = [self getPlayerWithFilePath:filePath];
    [videoCell.videoView setPlayer:player];
    [player play];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *videoCell = (VideoCell *)cell;
    [videoCell.videoView setPlayer:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    return cell;
}

- (AVPlayer *)getPlayerWithFilePath:(NSString *)filePath{
    NSURL *videoUrl = [NSURL fileURLWithPath:filePath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:videoUrl options:nil];
    AVPlayerItem *playerItem= [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    return player;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
