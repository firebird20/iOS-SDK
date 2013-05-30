//
//  PayoneMobileSdk.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 19.06.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#include "ParameterCollection.h"
#include "PayoneParameters.h"


@protocol PayoneSdkProtocol <NSObject>

-(void) onRequestResult:(ParameterCollection*) result;

@end




