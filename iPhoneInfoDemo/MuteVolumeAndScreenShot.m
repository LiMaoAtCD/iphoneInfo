//
//  MuteVolumeAndScreenShot.m
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/12/15.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

#import "MuteVolumeAndScreenShot.h"

@implementation MuteVolumeAndScreenShot

//+(BOOL)isMuted {
//    CFStringRef route;
//    UInt32 routeSize = sizeof(CFStringRef);
//    
//    OSStatus status = AudioSessionGetProperty(kAudioSessionProperty_AudioRoute,&routeSize,&route);
//    if (status == kAudioSessionNoError) {
//        if (route == NULL || !CFStringGetLength(route)) {
//            return TRUE;
//        }
//    }
//     return FALSE;
//}
//            
//- (BOOL)addMutedListener
//    {
////            OSStatus s = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange,
////                                                         audioRouteChangeListenerCallback,
////                                                         audioRouteChangeListenerCallback,
////                                                         self);
//        OSStatus status = AudioSessionGetProperty(kAudioSessionProperty_AudioRouteChange, kAudioSessionProperty_AudioRouteChange, (__bridge void *)(self));
//            return status == kAudioSessionNoError;
//}
//
//void audioRouteChangeListenerCallback (void *inUserData,
//                                       AudioSessionPropertyID inPropertyID,
//                                       UInt32 inPropertyValueSize,
//                                       const void *inPropertyValue
//                                       )
//{
//    if (inPropertyID != kAudioSessionProperty_AudioRouteChange) return;
//    BOOL muted = [MuteVolumeAndScreenShot isMuted];
//    // add code here
//    
//    
//}
//
//- (float)volume
//{
//    return [[MPMusicPlayerController applicationMusicPlayer] volume];
//}
//
//- (void)setVolume:(float)newVolume
//{
//    [[MPMusicPlayerController applicationMusicPlayer] setVolume:newVolume];
//}
//
//- (BOOL)addHardKeyVolumeListener
//{
//    OSStatus s = AudioSessionAddPropertyListener(kAudioSessionProperty_CurrentHardwareOutputVolume,
//                                                 audioVolumeChangeListenerCallback,
//                                                 self);
//    return s == kAudioSessionNoError;
//}
//
//void audioVolumeChangeListenerCallback (void *inUserData,
//                                        AudioSessionPropertyID inPropertyID,
//                                        UInt32 inPropertyValueSize,
//                                        const void *inPropertyValue)
//{
//    if (inPropertyID != kAudioSessionProperty_CurrentHardwareOutputVolume) return;
//    Float32 value = *(Float32 *)inPropertyValue;
//    MediaVolume *mediaVolume = (MediaVolume *)inUserData;
//    // add code here
//}
@end
