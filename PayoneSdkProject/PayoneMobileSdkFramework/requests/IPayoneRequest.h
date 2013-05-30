//
//  IPayoneRequest.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 20.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParameterCollection.h"
#import "ASIFormDataRequest.h"
#import "PayoneMobileSdk.h"

FOUNDATION_EXPORT int const USERCANCELLED_ERRORCODE;
FOUNDATION_EXPORT  int const INTERNALERROR_ERRORCODE;
FOUNDATION_EXPORT  int const ARGUMENTINVALID_ERRORCODE;
FOUNDATION_EXPORT  int const ARGUMENTCONVERSION_ERRORCODE;
FOUNDATION_EXPORT  int const REQUESTHANDLING_ERRORCODE;
FOUNDATION_EXPORT  int const REQUESTRESPONSEHANDLING_ERRORCODE;

@interface IPayoneRequest : NSObject
{
    //region Properties
    __block ASIFormDataRequest* mHttpRequest;
    BOOL mIsRunning;
    id<PayoneSdkProtocol> mResponseAction;
        
    NSString* mKey;
    ParameterCollection* mParameterToDeliver;
    ParameterCollection* mErrorParameter;

}

@property (nonatomic, retain) NSString* key;
@property (nonatomic, assign) id<PayoneSdkProtocol> responseAction;

-(void) runASync:(id) delegate;
-(void) setParameterToDeliver:(ParameterCollection*) parameterCollection;
-(void) requestFinished;
-(void) requestFailed;
@end
