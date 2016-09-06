//
//  HADMediaView.h
//  HADFramework
//
//  Created by Mihael Isaev on 26/08/16.
//  Copyright © 2016 com.hyperadx.HADFramework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HADNetworkManager.h"
#import "HADNativeAd.h"

typedef void(^HADGetImageCompletionBlock)(NSError *error, UIImage *image);

@interface HADMediaView : UIView

@property (nonatomic) BOOL rectWasDrawed;

-(void)loadHADBanner:(HADNativeAd*)nativeAd animated:(BOOL)animated completion:(HADGetImageCompletionBlock)completion;
-(void)loadHADIcon:(HADNativeAd*)nativeAd animated:(BOOL)animated completion:(HADGetImageCompletionBlock)completion;

@end
