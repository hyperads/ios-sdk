//
//  ADFEventManager.h
//  AdFramework
//
//  Created by Mihael Isaev on 26/08/16.
//  Copyright © 2016 com.hyperadx.HADFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HADEventType) {
    
//  Authenticate events
    HADEventTypeRegistration = 101,
    HADEventTypeLogin,
    HADEventTypeOpen,
    
//  eCommerce events
    HADEventTypeAddToWishlist = 201,
    HADEventTypeAddToCart,
    HADEventTypeAddedPaymentInfo,
    HADEventTypeReservation,
    HADEventTypeCheckoutInitiated,
    HADEventTypePurchase,
    
//  Content events
    HADEventTypeSearch = 301,
    HADEventTypeContentView,
    
//  Gaming events
    HADEventTypeTutorialCompleted = 401,
    HADEventTypeLevelAchieved,
    HADEventTypeAchievementUnlocked,
    HADEventTypeSpentCredit,
    
//  Social events
    HADEventTypeInvite = 501,
    HADEventTypeRated,
    HADEventTypeShare

};

@interface HADEventManager : NSObject

+ (void) trackEventType:(HADEventType)type;



@end
