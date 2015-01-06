//
//  DeviceModel.m
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/11/14.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel


//@"i386"      on 32-bit Simulator
//@"x86_64"    on 64-bit Simulator
//@"iPod1,1"   on iPod Touch
//@"iPod2,1"   on iPod Touch Second Generation
//@"iPod3,1"   on iPod Touch Third Generation
//@"iPod4,1"   on iPod Touch Fourth Generation
//@"iPhone1,1" on iPhone
//@"iPhone1,2" on iPhone 3G
//@"iPhone2,1" on iPhone 3GS
//@"iPad1,1"   on iPad
//@"iPad2,1"   on iPad 2
//@"iPad3,1"   on 3rd Generation iPad
//@"iPhone3,1" on iPhone 4
//@"iPhone4,1" on iPhone 4S
//@"iPhone5,1" on iPhone 5 (model A1428, AT&T/Canada)
//@"iPhone5,2" on iPhone 5 (model A1429, everything else)
//@"iPad3,4" on 4th Generation iPad
//@"iPad2,5" on iPad Mini
//@"iPhone5,3" on iPhone 5c (model A1456, A1532 | GSM)
//@"iPhone5,4" on iPhone 5c (model A1507, A1516, A1526 (China), A1529 | Global)
//@"iPhone6,1" on iPhone 5s (model A1433, A1533 | GSM)
//@"iPhone6,2" on iPhone 5s (model A1457, A1518, A1528 (China), A1530 | Global)
//@"iPad4,1" on 5th Generation iPad (iPad Air) - Wifi
//@"iPad4,2" on 5th Generation iPad (iPad Air) - Cellular
//@"iPad4,4" on 2nd Generation iPad Mini - Wifi
//@"iPad4,5" on 2nd Generation iPad Mini - Cellular
//@"iPhone7,1" on iPhone 6 Plus
//@"iPhone7,2" on iPhone 6

+(NSString*)model{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString* iPhoneMachine =  [NSString stringWithCString: systemInfo.machine encoding: NSUTF8StringEncoding];
    NSString * model = nil;
    if ([iPhoneMachine containsString:@"iPhone2"]) {
        model = @"iPhone 3GS";
    } else if([iPhoneMachine containsString:@"iPhone3"]){
        model = @"iPhone 4";
    }else if([iPhoneMachine containsString:@"iPhone4"]){
        model = @"iPhone 4s";
    }else if([iPhoneMachine isEqualToString:@"iPhone5,1"]||
             [iPhoneMachine isEqualToString:@"iPhone5,2"]
             ){
        model = @"iPhone 5";
    }else if([iPhoneMachine isEqualToString:@"iPhone5,3"]||
             [iPhoneMachine isEqualToString:@"iPhone5,4"]
             ){
        model = @"iPhone 5c";
    }else if([iPhoneMachine containsString:@"iPhone6"]){
        model = @"iPhone 5s";
    }else if([iPhoneMachine isEqualToString:@"iPhone7,1"]){
        model = @"iPhone 6";
    }
    else if([iPhoneMachine isEqualToString:@"iPhone7,2"]){
        model = @"iPhone 6 Plus";
    }
    
    
    
    
    return model;
}
+(NSString*)getFreeDiskSpace{
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
//        NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    NSString *capacity = [NSString stringWithFormat:@"%llu",(((totalFreeSpace/1024ll)/1024ll)/1024ll)];
    
    return capacity;
}
+(NSString*)getTotalDiskSpace{
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
//        NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    NSString *capacity = [NSString stringWithFormat:@"%llu",(((totalSpace/1024ll)/1024ll)/1024ll)];
    
    return capacity;

}


+ (NSString *)machine
{
    static NSString *machine = nil;
    
    // we keep name around (its like 10 bytes....) forever to stop lots of little mallocs;
    if(machine == nil)
    {
        char * name = nil;
        size_t size;
        
        // Set 'oldp' parameter to NULL to get the size of the data
        // returned so we can allocate appropriate amount of space
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        
        // Allocate the space to store name
        name = malloc(size);
        
        // Get the platform name
        sysctlbyname("hw.machine", name, &size, NULL, 0);
        
        // Place name into a string
        machine = [NSString stringWithUTF8String:name];
        // Done with this
        free(name);
    }
    
    return machine;
}

+(BOOL)hasVibration
{
    NSString * machine = [DeviceModel machine];
    
    if([[machine uppercaseString] rangeOfString:@"IPHONE"].location != NSNotFound)
    {
        return YES;
    }
    
    return NO;
}

@end
