//
//  ADFNetworkManager.h
//  AdFramework
//
//  Created by Mihael Isaev on 26/08/16.
//  Copyright © 2016 com.hyperadx.HADFramework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HADAdObject.h"
#import "HADEventManager.h"

typedef void(^HADCompletionBlock)(NSError *error, id responseObject);
typedef void(^HADURLResponseCompletionBlock)(NSError *error, NSURLResponse *responseObject);
typedef void(^HADGetImageCompletionBlock)(NSError *error, UIImage *image);

typedef NS_ENUM(NSInteger, HADAdContent) {
    HADAdContentTitle,
    HADAdContentDescription,
    HADAdContentBanner,
    HADAdContentIcon
};

typedef NS_ENUM(NSInteger, HADAdType) {
    HADAdTypeNative,
    HADAdTypeHTML,
    HADAdTypeInterstitial
};

typedef NS_ENUM(NSInteger, HADAdOrientation) {
    HADAdOrientationPortrait,
    HADAdOrientationLandscape
};

@class HADAdObject;

@interface HADNetworkManager : NSObject 

@property (nonatomic, strong) NSString *userAgent;

+ (instancetype) manager;

-(void) getAdWithContent:(NSArray*)content types:(NSArray*)types placementId:(NSString*)placementId nativeAd:(HADAdObject*)nativeAd completion:(HADCompletionBlock)completion;
-(void) sendViewMessageToUrl:(NSURL*)urlMessage completion:(HADURLResponseCompletionBlock)completion;
-(void) loadImage:(NSString*)imageUrl completion:(HADGetImageCompletionBlock)completion;
-(void)trackEvent:(HADEventType)eventId;

- (NSError*)errorWithMessage:(NSString*)message;

+ (NSString*) sdkVersion;

@end
