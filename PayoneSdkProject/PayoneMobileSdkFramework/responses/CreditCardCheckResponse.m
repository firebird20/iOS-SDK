//
//  CreditCardCheckResponse.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "CreditCardCheckResponse.h"
#import "Utils.h"
#import "PayoneParameters.h"

@interface CreditCardCheckResponse (private)

-(void) parseJson:(NSString*) json;

@end

@implementation CreditCardCheckResponse

/** Response status (mandatory property)*/
-(id) initWithString:(NSString*) json
{
    if(self = [super init])
    {
        [self parseJson:json];
    }
    return self;
}


-(void) parseJson:(NSString*) json
{
    NSError* error = nil;
    NSDictionary* repsonseDictionary = [self objectWithString:json error:&error];

    if([repsonseDictionary objectForKey:PayoneParameters_STATUS])
    {
        mStatus = [repsonseDictionary objectForKey:PayoneParameters_STATUS];
    }
    else
    {
        mStatus = @"";
    }

    if([repsonseDictionary objectForKey:PayoneParameters_PSEUDOCARDPAN])
    {
        mPseudoCardpan = [repsonseDictionary objectForKey:PayoneParameters_PSEUDOCARDPAN];
    }
    else
    {
        mPseudoCardpan = @"";
    }

    if([repsonseDictionary objectForKey:PayoneParameters_TRUNCATEDCARDPAN])
    {
        mTruncatedCardpan = [repsonseDictionary objectForKey:PayoneParameters_TRUNCATEDCARDPAN];
    }
    else
    {
        mTruncatedCardpan = @"";
    }

    if([repsonseDictionary objectForKey:PayoneParameters_ERRORCODE])
    {
        mErrorCode = [repsonseDictionary objectForKey:PayoneParameters_ERRORCODE];
    }
    else
    {
        mErrorCode = @"";
    }

    if([repsonseDictionary objectForKey:PayoneParameters_ERRORMESSAGE])
    {
        mErrorMessage = [repsonseDictionary objectForKey:PayoneParameters_ERRORMESSAGE];
    }
    else
    {
        mErrorMessage = @"";
    }

    if([repsonseDictionary objectForKey:PayoneParameters_CUSTOMERMESSAGE])
    {
        mCustomerMessage = [repsonseDictionary objectForKey:PayoneParameters_CUSTOMERMESSAGE];
    }
    else
    {
        mCustomerMessage = @"";
    }
}

-(ParameterCollection*) getResponseAsDictionary
{
    ParameterCollection* result = [[ParameterCollection new]autorelease];
    
    [result addKey:PayoneParameters_STATUS withValue:  mStatus];
    
    if([mStatus isEqualToString: PayoneParameters_ResponseErrorCodes_VALID])
    {
        if(![Utils isNullOrEmpty: mPseudoCardpan])
        {
            [result addKey:PayoneParameters_PSEUDOCARDPAN withValue:  mPseudoCardpan];
        }
        
        if(![Utils isNullOrEmpty: mTruncatedCardpan])
        {
            [result addKey:PayoneParameters_TRUNCATEDCARDPAN withValue:  mTruncatedCardpan];
        }
    }
    else
    {
        if(![Utils isNullOrEmpty: mErrorCode])
        {
            [result addKey:PayoneParameters_ERRORCODE withValue:  mErrorCode];
        }
        
        if(![Utils isNullOrEmpty: mErrorMessage])
        {
            [result addKey:PayoneParameters_ERRORMESSAGE withValue:  mErrorMessage];
        }
        
        if(![Utils isNullOrEmpty: mCustomerMessage])
        {
            [result addKey:PayoneParameters_CUSTOMERMESSAGE withValue:  mCustomerMessage];
        }
    }
    
    return result;
}

@end
