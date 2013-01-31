//
//  PreAuthorizationRequest.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "IPayoneRequest.h"

@interface PreAuthorizationRequest : IPayoneRequest

-(ParameterCollection*) convertResponseToCollection:(NSString*)response;

@end
