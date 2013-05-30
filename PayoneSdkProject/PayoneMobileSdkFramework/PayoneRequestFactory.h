//
//  PayoneRequestFactory.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditCardCheckRequest.h"
#import "PreAuthorizationRequest.h"
#import "AuthorizationRequest.h"
#import "ParameterCollection.h"

#include "PayoneMobileSdk.h"

@interface PayoneRequestFactory : NSObject

+(CreditCardCheckRequest*) createCreditCardCheckRequest:(id<PayoneSdkProtocol>) delegate withKey: (NSString*) key andParameters:(ParameterCollection*) parameterCollection;
+(PreAuthorizationRequest*) createPreAuthorizationRequest:(id<PayoneSdkProtocol>) delegate withKey: (NSString*) key andParameters:(ParameterCollection*) parameterCollection;
+(AuthorizationRequest*) createAuthorizationRequest:(id<PayoneSdkProtocol>) delegate withKey: (NSString*) key andParameters:(ParameterCollection*) parameterCollection;

@end
