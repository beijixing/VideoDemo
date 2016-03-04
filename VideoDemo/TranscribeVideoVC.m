//
//  TranscribeVideoVC.m
//  VideoDemo
//
//  Created by ybon on 16/3/4.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "TranscribeVideoVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface TranscribeVideoVC ()<AVCaptureFileOutputRecordingDelegate, UIImagePickerControllerDelegate>
@property AVCaptureMovieFileOutput *output;

@property (nonatomic, strong)NSString *path;
@end

@implementation TranscribeVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"开始录制" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickVideoBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 400, 80, 40);
    [self.view addSubview:button];
    
    //1.创建视频设备(摄像头前，后)
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    //2.初始化一个摄像头输入设备(first是后置摄像头，last是前置摄像头)
    AVCaptureDeviceInput *inputVideo = [AVCaptureDeviceInput deviceInputWithDevice:[devices firstObject] error:NULL];
    //3.创建麦克风设备
    AVCaptureDevice *deviceAudio = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    //4.初始化麦克风输入设备
    AVCaptureDeviceInput *inputAudio = [AVCaptureDeviceInput deviceInputWithDevice:deviceAudio error:NULL];

    //5.初始化一个movie的文件输出
    AVCaptureMovieFileOutput *output = [[AVCaptureMovieFileOutput alloc] init];
    self.output = output; //保存output，方便下面操作
    //6.初始化一个会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    //7.将输入输出设备添加到会话中
    if ([session canAddInput:inputVideo]) {
         [session addInput:inputVideo];
        }
    if ([session canAddInput:inputAudio]) {
        [session addInput:inputAudio];
        }
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    //8.创建一个预览涂层
    AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    //设置图层的大小
    preLayer.frame = CGRectMake(0, 0, 320, 300);
    //添加到view上
    [self.view.layer addSublayer:preLayer];
    //9.开始会话
    [session startRunning];
}

#pragma mark - AVCaptureFileOutputRecordingDelegate
//录制完成代理
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {
    NSLog(@"完成录制,可以自己做进一步的处理");
    
    [self save: self.path];
}

//添加一个按钮：点击开始，停止录制视频，并设置录制视频的代理
- (void)clickVideoBtn:(UIButton *)sender {
 //判断是否在录制,如果在录制，就停止，并设置按钮title
 if ([self.output isRecording]) {
     [self.output stopRecording];
     [sender setTitle:@"录制" forState:UIControlStateNormal];
     return;
    }

 //设置按钮的title
 [sender setTitle:@"停止" forState:UIControlStateNormal];

 //10.开始录制视频
 //设置录制视频保存的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"myVidio.mov"];
    //转为视频保存的url
    self.path = path;
    NSURL *url = [NSURL fileURLWithPath:path];
    
 //开始录制,并设置控制器为录制的代理
 [self.output startRecordingToOutputFileURL:url recordingDelegate:self];

}

- (void)save:(NSString*)urlString{
//    long ind=[self fileSizeAtPath:[self.outputMp4URL path]];
//    NSLog(@"文件空间的大小为： 保存的   %ld",ind);
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:urlString]
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    if (error) {
                                        NSLog(@"Save video fail:%@",error);
                                    } else {
                                        NSLog(@"Save video succeed.");
                                        
                                    }
                                }];
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
