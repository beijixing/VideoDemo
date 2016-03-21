//
//  Canceller.m
//  VideoDemo
//
//  Created by ybon on 16/3/15.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "Canceller.h"

@implementation Canceller
+(instancetype)sharedCanceller {
    static Canceller *canceller;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        canceller = [[Canceller alloc] init];
    });
    return  canceller;
}
@end
