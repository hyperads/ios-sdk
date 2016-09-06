//
//  ADFAdObject.h
//  AdFramework
//
//  Created by Mihael Isaev on 26/08/16.
//  Copyright © 2016 com.hyperadx.HADFramework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HADNetworkManager.h"
#import "HADMediaView.h"

@class HADMediaView;

@protocol HADAdObjectDelegate <NSObject>

@optional

- (void) HADAdObjectDidFailWithError:(NSError*)error;
- (void) HADAdObjectDidLoad;
- (void) HADAdObjectDidLoadBanner;
- (void) HADAdObjectDidLoadIcon;

@end

@interface HADAdObject : NSObject

@property (nonatomic, strong) HADMediaView *bannerContainer;
@property (nonatomic, strong) HADMediaView *iconContainer;

@property (nonatomic) NSArray *content;
@property (nonatomic) NSArray *types;

@property (nonatomic, strong) NSString *placementId;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *adTopic;

@property (nonatomic, strong) NSString *ageRating;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *ratingsCount;

@property (nonatomic, strong) NSString *cta;
@property (nonatomic, strong) NSString *bannerUrl;
@property (nonatomic, strong) NSString *iconUrl;

@property (nonatomic, strong) NSArray *showAdUrls;

@property (nonatomic, strong) NSString *clickUrl;
@property (nonatomic, strong) NSString *html;

@property (nonatomic) UInt32 closeTimer;

@property (nonatomic) BOOL showTrackingSent;

@property (nonatomic, weak) id <HADAdObjectDelegate> delegate;

- (void)loadNativeAd;
- (void)sendShowTrackingRequest;
- (void)bannerLoaded:(HADMediaView*)imageView;
- (void)iconLoaded:(HADMediaView*)imageView;
- (BOOL)handleClick;

@end
