//
//  PayoneSession.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 21.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayoneSettingsVo.h"


enum POPaymentSettingsRequestType
{
    POPaymentSettingsRequestTypeLive = 0,
    POPaymentSettingsRequestTypeTest
};
typedef enum POPaymentSettingsRequestType POPaymentSettingsRequestType;

enum POPaymentSettingsType 
{
    POPaymentSettingsTypeCreditcard = 0,
    POPaymentSettingsTypeDebit
};
typedef enum POPaymentSettingsType POPaymentSettingsType;


@interface PayoneSettingsManager : NSObject
{    
    PayoneSettingsManager* mInstance;
}

+(PayoneSettingsManager*)getInstance;
-(void) saveSetting:(id) object forKey:(NSString*) keyString;
-(void) setPassword:(NSString*)password;
-(void) setCurrency:(NSString*) currency;
-(BOOL) passwordMatches:(NSString*) password;
-(void) savePayoneSettings;
-(void) readSettings;

// Getters 
-(NSMutableArray*) getSelectedPaymentTypes;
-(NSArray*) getCountryCodes;
-(NSString*) getCurrency;
-(NSArray*) getCountryLocaValues;
-(NSArray*) getPaymentLocaValues;
-(NSArray*) getCurrencyLocaValues;
-(NSArray*) getSupportedCreditCards;
-(NSArray*) getSupportedCreditCardsLocaValues;
-(NSDictionary*) getCreditcards;

-(NSString*) createUniqueReferenceIdString;
-(BOOL) testMode;

-(NSMutableArray*) readSettingsData;
-(void) saveSetting:(id) object forKey:(NSString*) key;
-(NSMutableArray*) readPaymentOptionSettings;
-(void) savePaymentSettings:(NSArray*) paymentOptionSettings;
-(void) savePaymentMode:(PayoneSettingsVo*) mode;
-(PayoneSettingsVo*) readLiveMode;
-(PayoneSettingsVo*) getPaymentforOptionAt:(int) index;


@property (nonatomic, retain) NSString* mid;
@property (nonatomic, retain) NSString* portalId;
@property (nonatomic, retain) NSString* subAccountId;
@property (nonatomic, retain) NSString* key;
@property (nonatomic, retain) NSString* live;

@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* selectedPaymentType;
@property (nonatomic, retain) NSString* amount;

@property (nonatomic, assign) POPaymentSettingsType paymentType;
@property (nonatomic, assign) POPaymentSettingsType paymentRequestType;

@property (nonatomic, readonly) NSUserDefaults* userDefaults;
@property (nonatomic, readonly) BOOL passwordSet;

@end
