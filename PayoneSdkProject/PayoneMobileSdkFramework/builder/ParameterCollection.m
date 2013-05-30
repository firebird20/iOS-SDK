//
//  ParameterCollection.m
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 19.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

#import "ParameterCollection.h"
#import "Utils.h"
#import "PayoneParameters.h"

@implementation ParameterCollection

@synthesize collection;
@synthesize count;

-(id) init
{
    if(self = [super init])
    {
        mParameterCollection = [[NSMutableDictionary alloc]init] ;
    }        
    return self;
}

-(void) dealloc
{
    [mParameterCollection release];
    [super dealloc];
}

-(int) count
{
    return [mParameterCollection count];
}

-(NSDictionary*) collection
{
    return mParameterCollection;
}

-(void) addKey:(NSString*) key withValue:(NSString*) value
{
    [mParameterCollection setValue:value forKey:key];        
}

-(NSString*) valueForKey:(NSString*) key
{
    return [mParameterCollection valueForKey:key];
}

-(void) addMD5Hash:(NSString*) additionalPayoneKey
{
    if(mParameterCollection)
    {
        NSString*  md5HashValue = [ParameterCollection createMD5HashFromArguments: mParameterCollection and: additionalPayoneKey];
        [mParameterCollection setValue:md5HashValue forKey:PayoneParameters_HASH ]; 
    }
}

-(NSString*) toPostBodyParameter:(NSString*) additionalPayoneKey
{
    if(mParameterCollection)
    {
       
        NSString*  md5HashValue = [ParameterCollection createMD5HashFromArguments: mParameterCollection and: additionalPayoneKey];
        [mParameterCollection setValue:md5HashValue forKey:PayoneParameters_HASH ]; 
        
        NSMutableString* builder = [[[NSMutableString alloc] init] autorelease];
        
        int i = 0;
        
        // convert all collection entries into one concatenated string
        // format : "key=value&key2=value2&key3=value3
        for(NSString*  key in [mParameterCollection allKeys])
        {
            if(i > 0)
            {
                [builder appendString:@"&"];
            }
            
            [builder appendFormat:@"%@%@%@", key , @"=" , [mParameterCollection objectForKey:key]];
            i++;
        }
        NSLog(@" builder: %@ ", builder);
        return builder;
    }

    return @"";


}

+(NSString*) createMD5HashFromArguments:(NSDictionary*) parameterCollection and:(NSString*) additionalPayoneKey
{
    // since not all parameters are used to build up the hash, this will give us a list of "relevant" key entries
    NSArray*  usedHasEntries =  [ParameterCollection RetrieveHashRelevantKeyValuesAsList ];// [[NSMutableArray new] autorelease]; 
    
    // filter the parameters by using only "hash-relevant" key-value pairs
    NSArray* argumentDictAsList = [parameterCollection allKeys];
    NSMutableArray*  filteredList = [[NSMutableArray new] autorelease];
    
    // make intersection for both lists
    for(NSString* entry in argumentDictAsList)
    {       
        if([usedHasEntries containsObject:entry])
        {
            [filteredList addObject:entry];
        }
    }
    
    // since there are hash relevant values, which are inconcrete (like id[1], id[2]...), we have to use regular expressions
    // for all existing keys and add them to the filteredList as well.
    for(NSString* entryKey in [parameterCollection allKeys])
    {
        NSError *error = nil;
        
       if([[NSRegularExpression regularExpressionWithPattern:PayoneParameters_ID_REGEX_PLACEHOLDER options:NSRegularExpressionCaseInsensitive error:&error] numberOfMatchesInString: entryKey options: 0 range: NSMakeRange(0, [entryKey length])] > 0 ||
           [[NSRegularExpression regularExpressionWithPattern:PayoneParameters_PR_REGEX_PLACEHOLDER options:NSRegularExpressionCaseInsensitive error:&error] numberOfMatchesInString: entryKey options: 0 range: NSMakeRange(0, [entryKey length])] > 0 ||
           [[NSRegularExpression regularExpressionWithPattern:PayoneParameters_NO_REGEX_PLACEHOLDER options:NSRegularExpressionCaseInsensitive error:&error] numberOfMatchesInString: entryKey options: 0 range: NSMakeRange(0, [entryKey length])] > 0 ||
           [[NSRegularExpression regularExpressionWithPattern:PayoneParameters_DE_REGEX_PLACEHOLDER options:NSRegularExpressionCaseInsensitive error:&error] numberOfMatchesInString: entryKey options: 0 range: NSMakeRange(0, [entryKey length])] > 0 ||
           [[NSRegularExpression regularExpressionWithPattern:PayoneParameters_VA_REGEX_PLACEHOLDER options:NSRegularExpressionCaseInsensitive error:&error] numberOfMatchesInString: entryKey options: 0 range: NSMakeRange(0, [entryKey length])] > 0 )
        {
            [filteredList addObject:entryKey];
        }
    }
    
    
    filteredList = [NSMutableArray arrayWithArray:[filteredList sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:) ]];
    
    NSMutableString* output = [[NSMutableString new]autorelease];
    
    for(NSString* key in filteredList)
    {
        [output appendString: [parameterCollection valueForKey:key]];
    }
   
    [output appendString: additionalPayoneKey];
    
    NSString* hash = [Utils stringFromMD5:output ];
    return hash;
}

+(NSArray*) RetrieveHashRelevantKeyValuesAsList
{
    NSMutableArray*  usedHashEntries = [[NSMutableArray new] autorelease];
        
    [usedHashEntries addObject:PayoneParameters_MID];
    [usedHashEntries addObject:PayoneParameters_AID];
    [usedHashEntries addObject:PayoneParameters_PORTALID];
    [usedHashEntries addObject:PayoneParameters_MODE];
    [usedHashEntries addObject:PayoneParameters_REQUEST];
    [usedHashEntries addObject:PayoneParameters_RESPONSETYPE];
    [usedHashEntries addObject:PayoneParameters_REFERENCE];
    [usedHashEntries addObject:PayoneParameters_USERID];
    [usedHashEntries addObject:PayoneParameters_CUSTOMERID];
    [usedHashEntries addObject:PayoneParameters_PARAM];
    [usedHashEntries addObject:PayoneParameters_NARRATIVE_TEXT];
    [usedHashEntries addObject:PayoneParameters_SUCCESSURL];
    [usedHashEntries addObject:PayoneParameters_ERRORURL];
    [usedHashEntries addObject:PayoneParameters_BACKURL];
    [usedHashEntries addObject:PayoneParameters_EXITURL];
    [usedHashEntries addObject:PayoneParameters_CLEARINGTYPE];
    [usedHashEntries addObject:PayoneParameters_ENCODING];
    [usedHashEntries addObject:PayoneParameters_AMOUNT];
    [usedHashEntries addObject:PayoneParameters_CURRENCY];
    [usedHashEntries addObject:PayoneParameters_DUE_TIME];
    [usedHashEntries addObject:PayoneParameters_STORECARDDATA];
    [usedHashEntries addObject:PayoneParameters_CHECKTYPE];
    [usedHashEntries addObject:PayoneParameters_ADDRESSCHECKTYPE];
    [usedHashEntries addObject:PayoneParameters_CONSUMERSCORETYPE];
    [usedHashEntries addObject:PayoneParameters_INVOICEID];
    [usedHashEntries addObject:PayoneParameters_INVOICEAPPENDIX];
    [usedHashEntries addObject:PayoneParameters_INVOICE_DELIVERYMODE];
    [usedHashEntries addObject:PayoneParameters_ECI];
    [usedHashEntries addObject:PayoneParameters_PRODUCTID];
    [usedHashEntries addObject:PayoneParameters_ACCESSNAME];
    [usedHashEntries addObject:PayoneParameters_ACCESSCODE];
    [usedHashEntries addObject:PayoneParameters_ACCESS_EXPIRETIME];
    [usedHashEntries addObject:PayoneParameters_ACCESS_CANCELTIME];
    [usedHashEntries addObject:PayoneParameters_ACCESS_STARTTIME];
    [usedHashEntries addObject:PayoneParameters_ACCESS_PERIOD];
    [usedHashEntries addObject:PayoneParameters_ACCESS_ABOPERIOD];
    [usedHashEntries addObject:PayoneParameters_ACCESS_PRICE];
    [usedHashEntries addObject:PayoneParameters_ACCESS_ABOPRICE];
    [usedHashEntries addObject:PayoneParameters_ACCESS_VAT];
    [usedHashEntries addObject:PayoneParameters_SETTLEPERIOD];
    [usedHashEntries addObject:PayoneParameters_SETTLETIME];
    [usedHashEntries addObject:PayoneParameters_VACCOUNTNAME];
    [usedHashEntries addObject:PayoneParameters_VREFERENCE];
       
    return usedHashEntries;
}

@end
