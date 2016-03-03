//
//  MainViewController.m
//  VideoDemo
//
//  Created by ybon on 16/3/3.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "MainViewController.h"
#import "VideoListVC.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)avplayerButtonClick:(UIButton *)sender {
    VideoListVC *videoListVc = [[VideoListVC alloc] init];
    [self.navigationController pushViewController:videoListVc animated:YES];
}

- (IBAction)customPlayerButtonClick:(UIButton *)sender {
}
@end
