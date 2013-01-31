//
//  ParameterCollection.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 19.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParameterCollection : NSObject
{    
    NSMutableDictionary* mParameterCollection;
}

@property (nonatomic, retain) NSDictionary* collection;
@property (nonatomic, assign) int count;

-(void) addKey:(NSString*) key withValue:(NSString*) value;
-(NSString*) valueForKey:(NSString*) key;
-(NSString*) toPostBodyParameter:(NSString*) additionalPayoneKey;
-(void) addMD5Hash:(NSString*) additionalPayoneKey;

+(NSString*) createMD5HashFromArguments:(NSDictionary*) parameterCollection and:(NSString*) additionalPayoneKey;
+(NSArray*) RetrieveHashRelevantKeyValuesAsList;
@end
