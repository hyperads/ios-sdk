//
//  ADFNativeAdDelegate.h
//  AdFramework
//
//  Created by Mihael Isaev on 26/08/16.
//  Copyright © 2016 com.hyperadx.HADFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HADNativeAd;

@protocol HADNativeAdDelegate <NSObject>

@optional

- (void) HADNativeAdDidFail:(HADNativeAd*)nativeAd withError:(NSError*)error;
- (void) HADNativeAdDidLoad:(HADNativeAd*)nativeAd;
- (void) HADNativeAdDidClick:(HADNativeAd*)nativeAd;

@end
