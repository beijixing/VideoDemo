//
//  MMovieViewController.m
//  VideoDemo
//
//  Created by ybon on 16/3/4.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "MMovieViewController.h"
#import "MMoviePlayerView.h"

@interface MMovieViewController ()

@end

@implementation MMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    
    MMoviePlayerView *moviView = [[MMoviePlayerView alloc] initWithFrame:CGRectMake(100, 160, 200, 150)];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test7" ofType:@"mp4"];
    moviView.filePath = filePath;
    moviView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:moviView];
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
