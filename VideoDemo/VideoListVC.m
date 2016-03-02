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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    return cell;
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
