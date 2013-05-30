//
//  IPayoneRequest.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 20.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//
#import "Utils.h"
#import "IPayoneRequest.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AuthorizationResponse.h"

int const USERCANCELLED_ERRORCODE = 9000;
int const INTERNALERROR_ERRORCODE = 9001;
int const ARGUMENTINVALID_ERRORCODE = 9002;
int const ARGUMENTCONVERSION_ERRORCODE = 9003;
int const REQUESTHANDLING_ERRORCODE = 9004;
int const REQUESTRESPONSEHANDLING_ERRORCODE = 9005;

//region statics
#define TARGET_URL @"https://secure.pay1.de/client-api/"

@interface IPayoneRequest (Private)
    -(void) startRequest;
    -(void) createSDKError:(int) errorCode withReason:(NSString*) reason;
    -(void) requestFinished;
    -(void) requestFailed;
@end;

@implementation IPayoneRequest
@synthesize key = mKey;
@synthesize responseAction = mResponseAction;


-(id) init        
 {
        if(self = [super init])
        {
             mHttpRequest = nil;
             mParameterToDeliver = nil;
             mErrorParameter = nil;
             mResponseAction = nil;
             mIsRunning = false;
             mKey = nil;
        }
        return self;
 }

-(void) dealloc
{   
    [super dealloc];
}
 
-(void) setParameterToDeliver:(ParameterCollection*) parameterCollection
 {
    if(mParameterToDeliver) 
    {
        [mParameterToDeliver release];
        mParameterToDeliver = nil;
    }

    mParameterToDeliver = [parameterCollection retain];
 }
 
 -(ParameterCollection*)  getParameterCollection
 {
     return mParameterToDeliver;
 }
 
 //region abstract methods override In Subclasses
-(ParameterCollection*) convertResponseToCollection:(NSString*) response
{
    return nil;
}
 
-(void) runASync:(id) delegate
 {
     if (delegate == nil)
     {
        NSAssert(delegate == nil ,@"Callback delegate is invalid or empty!");
     }
     
//     if([Utils isNullOrEmpty: mKey ])    
////         DebugLog(@"Given Key property is null or empty");
//
//    
//     if (mIsRunning)
////         DebugLog(@"Request is already running!");
     
     
     mResponseAction = delegate;
     
    [self startRequest];     
}
 


-(void) startRequest
{    
    @try
    {
        [mParameterToDeliver addMD5Hash:mKey];
        
        if (mParameterToDeliver == nil || [mParameterToDeliver count] == 0)
        {
//            DebugLog(@"Request parameter-collection is empty or not specified  %@ , count: %i" , mParameterToDeliver, [mParameterToDeliver count]);
        }
        
        if([Utils allParamsNullOrEmpty: mParameterToDeliver.collection ])
        {
            [self createSDKError: ARGUMENTINVALID_ERRORCODE withReason: @"The given parameters are empty."];
        }

        NSURL* url = [NSURL URLWithString:TARGET_URL];
        
        mHttpRequest = [ASIFormDataRequest requestWithURL:url];
        [mHttpRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];        
        
        for(NSString*  key in [mParameterToDeliver.collection allKeys])
        {
   
            [mHttpRequest setPostValue:[mParameterToDeliver.collection objectForKey:key] forKey: key];
        }        

        [mHttpRequest setCompletionBlock:^{
            [self requestFinished];
        }];
        [mHttpRequest setFailedBlock:^{
            [self requestFailed];
        }];
        
        [mHttpRequest startAsynchronous];        
    }
    @catch (NSError* e)
    {
        [self createSDKError: REQUESTHANDLING_ERRORCODE withReason: @"Client Protocol Error."];
    }
}

-(void) requestFinished
{    
    NSString* response = [mHttpRequest responseString];    
//    DebugLog(@" request success response %@  ", response);
    
    if([Utils isNullOrEmpty:response])
    {
        [self createSDKError: ARGUMENTCONVERSION_ERRORCODE withReason: @"The request stream was empty."];
    }
    else
    {
        NSRange match;        
        match = [response rangeOfString: @"<html>"];
        
        if (match.location != NSNotFound)
        {
            // TODO: what shall we do here!?
            [self  createSDKError: REQUESTRESPONSEHANDLING_ERRORCODE withReason: @"REDIRECT parameter is currently not supported."];
        }
    }
    
    [self onPostExecute:response];
}

-(void) requestFailed
{
    NSError *error = [mHttpRequest error];

    if (error)    
    {
        [self createSDKError: REQUESTHANDLING_ERRORCODE withReason: @"Client Protocol Error."];
    }
    
    [self onPostExecute:@""];    
}

-(void) onCancelled
{
    [mHttpRequest cancel];    
    [self createSDKError:USERCANCELLED_ERRORCODE withReason: @"Request cancelled by user."];
}


-(void) onPostExecute:(NSString*) result
{
    mIsRunning = false;
    
    if(![Utils isNullOrEmpty:result ])
    {
        ParameterCollection* responseAsCollection = [self convertResponseToCollection:result];
        [mResponseAction onRequestResult:responseAsCollection];
    }
    else
    {
        [mResponseAction onRequestResult:mErrorParameter];
    }
}

/// <summary>
/// Creates an error response
/// </summary>
/// <param name="errorCode">internal error code.</param>
/// <param name="reason">the reason of this error occurrency.</param>
/// <param name="exception">Possible exception information - can be null.</param>
-(void) createSDKError:(int) errorCode withReason:(NSString*) reason
{            
    mIsRunning = false;

    mErrorParameter = [[ ParameterCollection new ] autorelease ];
    [mErrorParameter addKey: PayoneParameters_STATUS  withValue: PayoneParameters_ResponseErrorCodes_ERROR];
    [mErrorParameter addKey: PayoneParameters_ERRORCODE withValue: [NSString stringWithFormat:@"%i", errorCode]];
    [mErrorParameter addKey: PayoneParameters_ERRORMESSAGE withValue: reason];
}

@end
