//
//  PayoneRequestFactory.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "PayoneRequestFactory.h"


@implementation PayoneRequestFactory

+(CreditCardCheckRequest*) createCreditCardCheckRequest:(id<PayoneSdkProtocol>) delegate withKey: (NSString*) key andParameters:(ParameterCollection*) parameterCollection;
{            
    CreditCardCheckRequest* request = [[CreditCardCheckRequest new] autorelease];
    [request setKey:key];
    [request setParameterToDeliver:parameterCollection];
    [request runASync:delegate];

    return request;
}

+(PreAuthorizationRequest*) createPreAuthorizationRequest:(id<PayoneSdkProtocol>) delegate withKey: (NSString*) key andParameters:(ParameterCollection*) parameterCollection;
{
    PreAuthorizationRequest* request = [[PreAuthorizationRequest new] autorelease];
    [request setKey:key];
    [request setParameterToDeliver:parameterCollection];
    [request runASync:delegate];

    return request;
}

+(AuthorizationRequest*) createAuthorizationRequest:(id<PayoneSdkProtocol>) delegate withKey: (NSString*) key andParameters:(ParameterCollection*) parameterCollection;
{
    AuthorizationRequest* request = [[AuthorizationRequest new] autorelease ];
    [request setKey:key];
    [request setParameterToDeliver:parameterCollection];
    [request runASync:delegate];

    return request;
}

@end
