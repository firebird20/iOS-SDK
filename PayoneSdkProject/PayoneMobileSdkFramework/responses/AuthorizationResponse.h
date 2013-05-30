//
//  AuthorizationResponse.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 20.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "ParameterCollection.h"

@interface AuthorizationResponse :  SBJsonParser
{
    NSString* mStatus;
    NSString* mTxId;
    NSString* mUserId;
    NSString* mRedirectId;
    NSString* mClearingBankAccountHolder;
    NSString* mClearingBankCountry;
    NSString* mClearingBankAccount;
    NSString* mClearingBankCode;
    NSString* mClearingBankIBAN;
    NSString* mClearingBankBIC;
    NSString* mClearingBankCity;
    NSString* mClearingBankName;
    NSString* mErrorCode;
    NSString* mErrorMessage;
    NSString* mCustomerMessage;
    
}

-(id) initWithString:(NSString*) json;
-(ParameterCollection*) getResponseAsDictionary;

@end
