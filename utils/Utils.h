//
//  Utils.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 20.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Utils : NSObject

+(BOOL) isNullOrEmpty:(NSString*) str;
+(BOOL) allParamsNullOrEmpty:(NSDictionary*) params;
+(NSString *) stringFromMD5:(NSString*) string;

@end
