//
//  AuthorizationResponses.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 20.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "AuthorizationResponse.h"
#import "Utils.h"

@interface AuthorizationResponse (private)

-(void) parseJson:(NSString*) json;

@end

@implementation AuthorizationResponse


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
     
     if([repsonseDictionary objectForKey:PayoneParameters_TXID])
     {
         mTxId = [repsonseDictionary objectForKey:PayoneParameters_TXID];
     }
     else 
     {
         mTxId = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_USERID])
     {
         mUserId = [repsonseDictionary objectForKey:PayoneParameters_USERID];
     }
     else 
     {
         mUserId = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_REDIRECTURL])
     {
         mRedirectId = [repsonseDictionary objectForKey:PayoneParameters_REDIRECTURL];
     }
     else 
     {
         mRedirectId = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKACCOUNTHOLDER])
     {
         mClearingBankAccountHolder = [repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKACCOUNTHOLDER];
     }
     else 
     {
         mClearingBankAccountHolder = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKCOUNTRY])
     {
         mClearingBankCountry = [repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKCOUNTRY];
     }
     else 
     {
         mClearingBankCountry = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKACCOUNT])
     {
         mClearingBankAccount = [repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKACCOUNT];
     }
     else 
     {
         mClearingBankAccount = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKCODE])
     {
         mClearingBankCode = [repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKCODE];
     }
     else 
     {
         mClearingBankCode = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKIBAN])
     {
         mClearingBankIBAN = [repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKIBAN];
     }
     else 
     {
         mClearingBankIBAN = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKBIC])
     {
         mClearingBankBIC = [repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKBIC];
     }
     else 
     {
         mClearingBankBIC = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKCITY])
     {
         mClearingBankCity = [repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKCITY];
     }
     else 
     {
         mClearingBankCity = @"";
     }
     
     if([repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKNAME])
     {
         mClearingBankName = [repsonseDictionary objectForKey:PayoneParameters_CLEARING_BANKNAME];
     }
      
     {
         mClearingBankName = @"";
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

//public ParameterCollection GetResponseAsDictionary()
-(ParameterCollection*) getResponseAsDictionary
{
    ParameterCollection* result = [[[ParameterCollection alloc] init] autorelease];
    
    [result addKey:PayoneParameters_STATUS withValue:mStatus];
    
    if([mStatus isEqualToString: PayoneParameters_ResponseErrorCodes_APPROVED] ||
       [mStatus isEqualToString:PayoneParameters_ResponseErrorCodes_REDIRECT])
    {
        if(![Utils isNullOrEmpty: mTxId ])
        {
            [result addKey:PayoneParameters_TXID withValue: mTxId];
        }
        
        if(![Utils isNullOrEmpty: mUserId])
        {
            [result addKey:PayoneParameters_USERID withValue: mUserId];
        }
        
        if([ mStatus isEqualToString:PayoneParameters_ResponseErrorCodes_REDIRECT ])
        {
            if(![Utils isNullOrEmpty: mRedirectId])
            {
                [result addKey:PayoneParameters_REDIRECTURL withValue: mRedirectId];
            }
        }
        
        if(![Utils isNullOrEmpty: mClearingBankAccountHolder])
        {
            [result addKey:PayoneParameters_CLEARING_BANKACCOUNTHOLDER withValue: mClearingBankAccountHolder];
        }
        
        if(![Utils isNullOrEmpty: mClearingBankCountry])
        {
            [result addKey:PayoneParameters_CLEARING_BANKCOUNTRY withValue: mClearingBankCountry];
        }
        
        if(![Utils isNullOrEmpty: mClearingBankAccount])
        {
            [result addKey:PayoneParameters_CLEARING_BANKACCOUNT withValue: mClearingBankAccount];
        }
        
        if(![Utils isNullOrEmpty: mClearingBankCode])
        {
            [result addKey:PayoneParameters_CLEARING_BANKCODE withValue: mClearingBankCode];
        }
        
        if(![Utils isNullOrEmpty: mClearingBankIBAN])
        {
            [result addKey:PayoneParameters_CLEARING_BANKIBAN withValue: mClearingBankIBAN];
        }
        
        if(![Utils isNullOrEmpty: mClearingBankBIC])
        {
            [result addKey:PayoneParameters_CLEARING_BANKBIC withValue: mClearingBankBIC];
        }
        
        if(![Utils isNullOrEmpty: mClearingBankCity])
        {
            [result addKey:PayoneParameters_CLEARING_BANKCITY withValue: mClearingBankCity];
        }
        
        if(![Utils isNullOrEmpty: mClearingBankName])
        {
            [result addKey:PayoneParameters_CLEARING_BANKNAME withValue: mClearingBankName];
        }
    }
    else
    {
        if(![Utils isNullOrEmpty: mErrorCode])
        {
            [result addKey:PayoneParameters_ERRORCODE withValue: mErrorCode];
        }
        
        if(![Utils isNullOrEmpty: mErrorMessage])       {
            [result addKey:PayoneParameters_ERRORMESSAGE withValue: mErrorMessage];
        }
        
        if(![Utils isNullOrEmpty: mCustomerMessage])
        {
            [result addKey:PayoneParameters_CUSTOMERMESSAGE withValue: mCustomerMessage];
        }
    }
    
    return result;
}

@end
