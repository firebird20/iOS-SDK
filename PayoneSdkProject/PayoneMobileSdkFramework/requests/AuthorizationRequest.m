//
//  AuthorizationRequest.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 20.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "AuthorizationRequest.h"
#import "AuthorizationResponse.h"

@implementation AuthorizationRequest


-(ParameterCollection*) convertResponseToCollection: (NSString*) response
 {
    AuthorizationResponse* responseObject = [[[AuthorizationResponse alloc] initWithString:response] autorelease];
    return [responseObject getResponseAsDictionary];
 }

 
@end
