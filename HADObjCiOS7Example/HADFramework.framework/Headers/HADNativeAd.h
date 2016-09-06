//
//  ADFNativeAd.h
//  AdFramework
//
//  Created by Mihael Isaev on 26.08.2016
//  Copyright © 2016 com.hyperadx.HADFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HADNativeAdDelegate.h"
#import "HADAdObject.h"

@class HADAdObject;

@interface HADNativeAd : NSObject

@property (nonatomic, strong) HADAdObject* adObject;

@property (nonatomic, strong) NSString* placementId;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* adTopic;
@property (nonatomic, strong) NSString* ageRating;
@property (nonatomic, strong) NSNumber* rating;
@property (nonatomic, strong) NSString* ratingsCount;
@property (nonatomic, strong) NSString* cta;

@property (nonatomic, weak) id<HADNativeAdDelegate> delegate;

- (id) initWithPlacementId:(NSString *)plcId delegate:(id<HADNativeAdDelegate>)delegate;
- (id) initWithPlacementId:(NSString *)plcId content:(NSArray*)content delegate:(id<HADNativeAdDelegate>)delegate;
- (id) initWithPlacementId:(NSString *)plcId content:(NSArray*)content types:(NSArray*)types delegate:(id<HADNativeAdDelegate>)delegate;
- (void) loadAd;

- (void) handleClick;
+(NSString*) sdkVersion;

@end
