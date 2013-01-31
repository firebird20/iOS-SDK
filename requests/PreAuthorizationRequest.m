//
//  PreAuthorizationRequest.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "PreAuthorizationRequest.h"
#import "AuthorizationResponse.h"

@implementation PreAuthorizationRequest

-(ParameterCollection*) convertResponseToCollection: (NSString*) response
{    
    AuthorizationResponse* responseObject = [[[AuthorizationResponse alloc] initWithString:response] autorelease];
    return [responseObject getResponseAsDictionary];

    
    
    return nil;
}

@end
