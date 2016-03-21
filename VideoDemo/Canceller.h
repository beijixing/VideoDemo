//
//  Canceller.h
//  VideoDemo
//
//  Created by ybon on 16/3/15.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Canceller : NSObject
@property(nonatomic, assign) BOOL shouldCancel;
+(instancetype)sharedCanceller;
@end
