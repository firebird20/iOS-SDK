//
//  AuthorizationRequest.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 20.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParameterCollection.h"
#import "IPayoneRequest.h"

@interface AuthorizationRequest : IPayoneRequest

-(ParameterCollection*) convertResponseToCollection:(NSString*)response;

@end
