//
//  CreditCardCheckRequest.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "CreditCardCheckRequest.h"
#import "CreditCardCheckResponse.h"

@implementation CreditCardCheckRequest

-(ParameterCollection*) convertResponseToCollection: (NSString*) response
{
    CreditCardCheckResponse* responseObject = [[[CreditCardCheckResponse alloc] initWithString:response] autorelease];
    return [responseObject getResponseAsDictionary];
}



@end
