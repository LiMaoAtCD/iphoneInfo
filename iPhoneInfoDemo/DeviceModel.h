//
//  DeviceModel.h
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/11/14.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <sys/sysctl.h>
@interface DeviceModel : NSObject

+(NSString*)model;
+(NSString*)getFreeDiskSpace;
+(NSString*)getTotalDiskSpace;
+(BOOL)hasVibration;
@end
