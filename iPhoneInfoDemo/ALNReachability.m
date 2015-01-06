//
//  ALNReachability.m
//  LocalClient
//
//  Created by AlienLi on 14/12/3.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

#import "ALNReachability.h"

@implementation ALNReachability

+(NSString *)getNetWorkStates{
    
    UIApplication *application = [UIApplication sharedApplication];
    
    NSArray *children = [[[application valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    NSString *state;
    int netType = 0;
    
    //获取到网络返回码
    
    for (id child in children) {
        
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}

@end
