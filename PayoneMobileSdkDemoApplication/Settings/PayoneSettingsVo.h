//
//  SettingsVo.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 22.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <Foundation/Foundation.h>

enum POSettingsDefType 
{
    POSettingsDefTypeMid = 0,
    POSettingsDefTypePortalId,
    POSettingsDefTypeSubAccoountId,
    POSettingsDefTypeKey,
    POSettingsDefTypePassword,
    POSettingsDefTypePaymentOption,
    POSettingsDefTypePaymentMode,
};
typedef enum POSettingsDefType POSettingsDefType;

@interface PayoneSettingsVo : NSObject <NSCoding>
{
    
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* value;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, assign) POSettingsDefType type;
@property (nonatomic, assign) NSString* cellClass;

@end
