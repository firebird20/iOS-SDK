//
//  PayoneSession.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 21.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PayoneSettingsManager.h"
#import "PayoneSettingsVo.h"
#import "PayoneRequestFactory.h"

static PayoneSettingsManager *sharedInstance;

@interface PayoneSettingsManager (private)

-(NSString*) getPassword;
-(NSUserDefaults*) userDefaults;

@end

@implementation PayoneSettingsManager

@synthesize mid;
@synthesize subAccountId;
@synthesize portalId;
@synthesize key;

@synthesize paymentType;
@synthesize paymentRequestType;

@dynamic userDefaults;
@dynamic passwordSet;

-(void) dealloc
{
    self.mid = nil;
    self.subAccountId = nil;
    self.portalId = nil;
    self.key = nil;
    [super dealloc];
}

+ (void) initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        sharedInstance = [[PayoneSettingsManager alloc] init];
    }
    [sharedInstance readSettings];
}

+ (PayoneSettingsManager*) getInstance
{
    return sharedInstance;
}

-(void) setCurrency:(NSString*) currency
{
    [self.userDefaults setObject:currency forKey:kSettingsCurrency];
    [self.userDefaults synchronize];
}

-(NSString*) getCurrency
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:kSettingsCurrency])    
        [self setCurrency:[[self getCurrencyLocaValues] objectAtIndex:0]];
    return [self.userDefaults objectForKey:kSettingsCurrency];
}

#pragma mark GETTERS

-(BOOL) testMode
{
    if([[self readLiveMode].value isEqualToString:@"1"])
        return NO;
    else
        return YES;
}

-(NSArray*) getCountryCodes
{
    return [NSArray arrayWithObjects:PayoneParameters_BankCountryParameter_DE, PayoneParameters_BankCountryParameter_AT, PayoneParameters_BankCountryParameter_NL,  nil];
}

-(NSArray*) getCountryLocaValues
{
    return [NSArray arrayWithObjects:NSLocalizedString(@"kSettingsCountry1", nil), NSLocalizedString(@"kSettingsCountry2", nil), NSLocalizedString(@"kSettingsCountry3", nil),  nil];
}

-(NSArray*) getCurrencyLocaValues
{
    return [NSArray arrayWithObjects:NSLocalizedString(@"kSettingsCurrencyEur", nil), NSLocalizedString(@"kSettingsCurrencyAustria", nil), NSLocalizedString(@"kSettingsCurrencyDenmark",nil),  nil];
}

-(NSArray*) getPaymentLocaValues
{
    NSMutableArray* array = [NSMutableArray arrayWithObjects: NSLocalizedString(@"kSettingsDebit", nil), NSLocalizedString(@"kSettingsInvoice", nil),  nil];
    
    // add credicards
    for (NSString* locaString in [self getSupportedCreditCardsLocaValues])
         [array addObject:locaString];
    
    return array;
}

-(NSArray*) getSupportedCreditCards
{
    return @[ PayoneParameters_CreditCardVariations_VISA, PayoneParameters_CreditCardVariations_MASTERCARD ];;
}

-(NSArray*) getSupportedCreditCardsLocaValues
{
    return @[ NSLocalizedString(@"kSettingsVisa", nil), NSLocalizedString(@"kSettingsMastercard",nil)];
}

-(NSDictionary*) getCreditcards
{
    return [NSDictionary dictionaryWithObjects:[self getSupportedCreditCards] forKeys:[self getSupportedCreditCardsLocaValues]];
}


#pragma mark READ AND PERSIST DATA
#pragma mark

-(void) savePaymentMode:(PayoneSettingsVo*) mode
{
    NSData* archiveData = [NSKeyedArchiver archivedDataWithRootObject:mode];
    [self.userDefaults setObject:archiveData forKey:kPayoneSettingsLiveModeKey];
    [self.userDefaults synchronize];
}

-(PayoneSettingsVo*) readLiveMode
{
    NSData* voData = [self.userDefaults objectForKey:kPayoneSettingsLiveModeKey];
    PayoneSettingsVo* vo;
    if (voData)
    {
        // archived data
        vo = [NSKeyedUnarchiver unarchiveObjectWithData:voData];
    }
    else
    {
        // default value
        vo = [[[PayoneSettingsVo alloc] init]autorelease];
        vo.type = POSettingsDefTypePaymentOption;
        vo.type = POSettingsDefTypePaymentMode;
        vo.name = NSLocalizedString(@"kSettingsMode" , nil);
        vo.title = NSLocalizedString(@"kSettingsModeLive" , nil);
        vo.value = @"0";
    }
    return vo;
}

-(void) savePaymentSettings:(NSArray*) paymentOptionSettings
{
    NSData* archiveData = [NSKeyedArchiver archivedDataWithRootObject:paymentOptionSettings];
    [self.userDefaults setObject:archiveData forKey:kPaymentSettings];
    [self.userDefaults synchronize];
}

-(NSMutableArray*) readPaymentOptionSettings
{
    NSData* arrayData = [[self userDefaults] objectForKey:kPaymentSettings];
    NSMutableArray* array;
    if (arrayData)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
        {
            array = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
    }
    else
    {
        // get default values    
        array = [[NSMutableArray alloc]init];
        NSArray* LocaValues = [self getPaymentLocaValues];
        for (int i = 0; i<[LocaValues count]; i++)
        {
            // section 3 data
            PayoneSettingsVo* option = [[[PayoneSettingsVo alloc] init]autorelease];
            option.type = POSettingsDefTypePaymentOption;
            option.name = [LocaValues objectAtIndex:i];
            option.title = option.name;
            option.value = @"1";
            [array addObject:option];
            
        }
        [self savePaymentSettings:array];
    }    
    return array;
}

-(NSArray*) getSelectedPaymentTypes
{
    NSMutableArray* array = [[[NSMutableArray alloc]init]autorelease];
    for (PayoneSettingsVo* vo in [self readPaymentOptionSettings])
    {
        if([vo.value isEqualToString:@"1"])
            [array addObject: vo];
    }
    return array;
}

-(PayoneSettingsVo*) getPaymentforOptionAt:(int) index
{
    NSArray* array = [self readPaymentOptionSettings];
    return (PayoneSettingsVo*) [array objectAtIndex:index];    
}


-(void) saveSetting:(id) object forKey:(NSString*) keyString
{
    [self.userDefaults setObject:object forKey:keyString];
}

-(NSString*) mid
{
    if(mid == nil || [mid isEqualToString:@""]) mid =  @"";
    return mid;
}

-(NSString*) portalId
{
    if(portalId == nil || [portalId isEqualToString:@""]) portalId =  @"";
    return portalId;
}

-(NSString*) subAccountId
{
    if(subAccountId == nil || [subAccountId isEqualToString:@""]) subAccountId = @"";
    return subAccountId;
}

-(NSString*) key
{
    if(key == nil || [key isEqualToString:@""]) key = @"";
    return key;
}

-(void) savePayoneSettings
{
    NSArray* array = [[NSArray alloc] initWithObjects:self.mid, self.portalId, self.subAccountId, self.key, nil];
    [self.userDefaults setObject:array forKey:kPayoneSettingsUserDefaults];
    [self.userDefaults synchronize];
}

-(void) readSettings
{
    NSArray* array = [self.userDefaults objectForKey:kPayoneSettingsUserDefaults];
    if([array count] <3) return;
    
    self.mid = [array objectAtIndex:0];
    self.portalId = [array objectAtIndex:1];
    self.subAccountId = [array objectAtIndex:2];
    self.key = [array objectAtIndex:3];
}

#pragma mark PASSWORD
#pragma mark

-(void) setPassword:(NSString*)password
{
    [self.userDefaults setObject:password forKey:kAppPassword];
    [self.userDefaults synchronize];
}

-(NSString*) getPassword
{    
    return [self.userDefaults objectForKey:kAppPassword];
}

-(BOOL) passwordSet
{
    BOOL bol = NO;
    NSString* pw = [self getPassword];
    if (![pw isEqual:@""] && pw != nil) bol = YES; 
    return bol;
}

-(BOOL) passwordMatches:(NSString*) password
{    
    return [[self getPassword]isEqualToString:password];
}

-(NSUserDefaults*) userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

- (NSString*) createUniqueReferenceIdString
{
    // Array with all alphanumeric characters:
    NSString* letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    int targetKeyLength = 20;
    
    // Create a random id string with 20 alpha numeric characters
    NSMutableString *randomString = [NSMutableString stringWithCapacity: targetKeyLength];
    
    for (int i=0; i<targetKeyLength; i++)
    {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

#pragma mark Default Settings 

/// content for settings will be read and stored in userdefaults at first app start
///

-(NSMutableArray*) readSettingsData
{
    NSMutableArray* cellData = [[[NSMutableArray alloc] init]autorelease];
    NSMutableArray* section1 = [[[NSMutableArray alloc] init]autorelease];
        
    // section 1
    PayoneSettingsVo* settingsMid = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsMid.type = POSettingsDefTypeMid;
    settingsMid.name = NSLocalizedString(@"kSettingsMid" , nil);
    settingsMid.title = NSLocalizedString(@"kSettingsMid" , nil);
    settingsMid.value = [PayoneSettingsManager getInstance].mid;
    [section1 addObject:settingsMid];
    
    PayoneSettingsVo* settingsPortalId = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsPortalId.type = POSettingsDefTypePortalId;
    settingsPortalId.name =NSLocalizedString(@"kSettingsPortalId" , nil);
    settingsPortalId.title =NSLocalizedString(@"kSettingsPortalId" , nil);
    settingsPortalId.value = [PayoneSettingsManager getInstance].portalId;
    [section1 addObject:settingsPortalId];
    
    PayoneSettingsVo* settingsSubAccount = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsSubAccount.type = POSettingsDefTypeSubAccoountId;
    settingsSubAccount.name = NSLocalizedString(@"kSettingsSubAccount" , nil);
    settingsSubAccount.title = NSLocalizedString(@"kSettingsSubAccount" , nil);
    settingsSubAccount.value = [PayoneSettingsManager getInstance].subAccountId;
    [section1 addObject:settingsSubAccount];
    
    PayoneSettingsVo* settingsKey = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsKey.type = POSettingsDefTypeKey;
    settingsKey.name = NSLocalizedString(@"kSettingsKey" , nil);
    settingsKey.title = NSLocalizedString(@"kSettingsKey" , nil);
    settingsKey.value = [PayoneSettingsManager getInstance].key;
    [section1 addObject:settingsKey];
    [cellData addObject:section1];
    
    // section 2 data
    NSMutableArray* section2 = [[[NSMutableArray alloc] init] autorelease];
    PayoneSettingsVo* settingsCurrency = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsCurrency.type = POSettingsDefTypeMid;
    settingsCurrency.name = NSLocalizedString(@"kSettingsCurrency" , nil);
    settingsCurrency.title = NSLocalizedString(@"kSettingsCurrency" , nil);
    settingsCurrency.value = [self getCurrency];
    [section2 addObject:settingsCurrency];
    [cellData addObject:section2];
    
    // section 3 data
    NSMutableArray* section3 = [[[NSMutableArray alloc] init] autorelease];
    PayoneSettingsVo* settingsMode = [self readLiveMode];
    
    [section3 addObject:settingsMode];
    [cellData addObject:section3];
    
    // section 4 data
    NSMutableArray* paymentOptions = [self readPaymentOptionSettings];
    [cellData addObject: paymentOptions];
    
    // section 5 data
    NSMutableArray* section5 = [[[NSMutableArray alloc] init] autorelease] ;
    PayoneSettingsVo* settingsPW = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsPW.type = POSettingsDefTypePassword;
    settingsPW.name = NSLocalizedString(@"kSettingsPassword" , nil);
    settingsPW.title = settingsPW.name;
    settingsPW.value = @"";
    [section5 addObject:settingsCurrency];
    [cellData addObject:section5];
    
    return cellData;
}


@end
