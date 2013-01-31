//
//  Utils.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 20.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "Utils.h"

@implementation Utils



+(BOOL) allParamsNullOrEmpty:(NSDictionary*) params
{
    BOOL empty = true;
    
    for (NSString* key in [params allKeys]) 
    {
        if([params objectForKey:key] != nil )
        {
            empty = false;
        }
        if ([[[params objectForKey:key] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])    
        {
            return true;
        }
    }
//    if (str == nil)
//    {
//        return true;
//    }
//    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])    
//    {
//        return true;
//    }
    
    return false;
}

+(BOOL) isNullOrEmpty:(NSString*) str
{
    if (str == nil)
    {
        return true;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])    
    {
        return true;
    }
    
    return false;
}

+ (NSString *) stringFromMD5:(NSString*) string
{    
    if(string == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [outputString appendFormat:@"%02x",outputBuffer[i]];
    }
    
    return [outputString autorelease];
}

@end
