//
//  PayoneSdkProtocol.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

@protocol PayoneSdkProtocol <NSObject>

@required
-(void) onRequestResult:(ParameterCollection*) result;

@end

