//
//  CreditCardCheckResponse.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "ParameterCollection.h"

@interface CreditCardCheckResponse : SBJsonParser
{
    NSString* mStatus;
    NSString* mPseudoCardpan;
    NSString* mTruncatedCardpan;
    NSString* mErrorCode;
    NSString* mErrorMessage;
    NSString* mCustomerMessage;    
}

-(id) initWithString:(NSString*) json;
-(ParameterCollection*) getResponseAsDictionary;

@end
