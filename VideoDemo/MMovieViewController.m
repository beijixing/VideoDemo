//
//  MMovieViewController.m
//  VideoDemo
//
//  Created by ybon on 16/3/4.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "MMovieViewController.h"
#import "MMoviePlayerView.h"
#import "MMovieTableViewCell.h"

@interface MMovieViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGRect videoFrame;
}
@end

@implementation MMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    
//    MMoviePlayerView *moviView = [[MMoviePlayerView alloc] initWithFrame:CGRectMake(100, 160, 200, 150)];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test7" ofType:@"mp4"];
//    moviView.filePath = filePath;
//    moviView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:moviView];
    
    [self.movieTable registerNib:[UINib nibWithNibName:@"MMovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    MMovieTableViewCell* videoCell = [self.movieTable dequeueReusableCellWithIdentifier:@"cell"];
    videoFrame = videoCell.playerView.frame;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MMovieTableViewCell *moviCell = (MMovieTableViewCell *)cell;
    
    MMoviePlayerView *moviView = [[MMoviePlayerView alloc] initWithFrame:videoFrame];
    NSString *fileName;
    if (indexPath.row <6) {
       fileName = [NSString stringWithFormat:@"test%ld", indexPath.row +1];
    }else if (indexPath.row <12){
        fileName = [NSString stringWithFormat:@"test%ld", indexPath.row - 5];
    }else {
         fileName = [NSString stringWithFormat:@"test%ld", indexPath.row - 11];
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    moviView.filePath = filePath;
    NSArray *subViews = moviCell.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    [moviCell addSubview:moviView];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MMovieTableViewCell *moviCell = (MMovieTableViewCell *)cell;
    NSArray *subViews = moviCell.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
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
