//
//  PayoneSDKViewController.m
//  PayoneSDKdemoApp
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PayoneSDKViewController.h"
#import "PayoneRequestFactory.h"

@interface PayoneSDKViewController ()

@end

@implementation PayoneSDKViewController
@synthesize labelResponse;
@synthesize labelResult;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setLabelResponse:nil];
    [self setLabelResult:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{
    [labelResponse release];
    [labelResult release];
    [super dealloc];
}

- (IBAction)buttonCreditcard:(id)sender 
{    
    ParameterCollection* parameters = [[ParameterCollection new] autorelease];
    [parameters addKey:PayoneParameters_AID withValue:  @"18628"];
    [parameters addKey:PayoneParameters_MID withValue:  @"18613"];
    [parameters addKey:PayoneParameters_PORTALID withValue:  @"2013349"];
    [parameters addKey:PayoneParameters_MODE withValue:  PayoneParameters_ModeParameter_TEST];
    [parameters addKey:PayoneParameters_REQUEST withValue:  PayoneParameters_RequestParameter_CREDITCARDCHECK];
    [parameters addKey:PayoneParameters_RESPONSETYPE withValue:  PayoneParameters_ResponseTypeParameter_JSON];
    [parameters addKey:PayoneParameters_CARDPAN withValue:  @"5500000000000004"];
    [parameters addKey:PayoneParameters_CARDTYPE withValue:  PayoneParameters_CreditCardVariations_MASTERCARD];
    [parameters addKey:PayoneParameters_CARDEXPIREDATE withValue:  @"1401"];
    [parameters addKey:PayoneParameters_CARDCVC2 withValue:  @"1234"];
    [parameters addKey:PayoneParameters_ENCODING withValue:  PayoneParameters_UTF_8];
    [parameters addKey:PayoneParameters_STORECARDDATA withValue:  PayoneParameters_StoreCardDataParameter_YES];
    [parameters addKey:PayoneParameters_LANGUAGE withValue:  @"de"];
    
    NSString* m5_key = @"TuyuotaaNgaeboaWaithohD4ohKooz";
    
    [PayoneRequestFactory createCreditCardCheckRequest: self  withValue: m5_key andParameters: parameters];
    
    
    self.labelResult.text = @"sending credit card authorization request";
    self.labelResponse.textColor = [UIColor whiteColor];
    self.labelResult.textColor = [UIColor grayColor];
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


- (IBAction)buttonPreAuthorize:(id)sender 
{
    ParameterCollection* parameters = [[ParameterCollection new] autorelease];
    
    [parameters addKey: PayoneParameters_MID withValue: @"18613"];
    [parameters addKey: PayoneParameters_PORTALID withValue: @"2013349"];
    [parameters addKey: PayoneParameters_MODE withValue:  PayoneParameters_ModeParameter_TEST];
    [parameters addKey: PayoneParameters_REQUEST withValue:  PayoneParameters_RequestParameter_PREAUTHORIZATION];
    [parameters addKey: PayoneParameters_RESPONSETYPE withValue:  PayoneParameters_ResponseTypeParameter_JSON];
    [parameters addKey: PayoneParameters_ENCODING withValue:  PayoneParameters_UTF_8];
    
    [parameters addKey: PayoneParameters_AID withValue: @"18628"];
    [parameters addKey: PayoneParameters_CLEARINGTYPE withValue: PayoneParameters_ClearingTypeParameter_DEBIT];
    [parameters addKey: PayoneParameters_REFERENCE withValue: [self createUniqueReferenceIdString]];
    [parameters addKey: PayoneParameters_AMOUNT withValue: @"1"];
    [parameters addKey: PayoneParameters_CURRENCY withValue: @"EUR"];
    [parameters addKey: PayoneParameters_FIRSTNAME withValue: @"Max"];
    [parameters addKey: PayoneParameters_LASTNAME withValue: @"Mustermann"];
    [parameters addKey: PayoneParameters_COUNTRY withValue: @"DE"];
    
    [parameters addKey: PayoneParameters_BANKCOUNTRY withValue: PayoneParameters_BankCountryParameter_DE];
    [parameters addKey: PayoneParameters_BANKACCOUNT withValue: @"123456789"];
    [parameters addKey: PayoneParameters_BANKCODE withValue: @"13070024"];
    
    NSString* m5_key = @"TuyuotaaNgaeboaWaithohD4ohKooz";
    
    [PayoneRequestFactory createPreAuthorizationRequest: self withValue:m5_key andParameters: parameters];
    
    self.labelResult.text = @"sending preauthorization request";
    self.labelResponse.textColor = [UIColor whiteColor];
    self.labelResult.textColor = [UIColor grayColor];
}

- (IBAction)buttonAuthorize:(id)sender 
{
    ParameterCollection* parameters = [[ParameterCollection new]autorelease];
    
    [parameters addKey: PayoneParameters_MID withValue: @"18613"];
    [parameters addKey: PayoneParameters_PORTALID withValue: @"2013349"];
    [parameters addKey: PayoneParameters_MODE withValue: PayoneParameters_ModeParameter_TEST];
    [parameters addKey: PayoneParameters_REQUEST withValue: PayoneParameters_RequestParameter_AUTHORIZATION];
    [parameters addKey: PayoneParameters_RESPONSETYPE withValue: PayoneParameters_ResponseTypeParameter_JSON];
    [parameters addKey: PayoneParameters_ENCODING withValue: PayoneParameters_UTF_8];
    
    [parameters addKey: PayoneParameters_AID withValue: @"18628"];
    [parameters addKey: PayoneParameters_CLEARINGTYPE withValue: PayoneParameters_ClearingTypeParameter_DEBIT];
    [parameters addKey: PayoneParameters_REFERENCE withValue: [self createUniqueReferenceIdString ]];
    
    [parameters addKey: PayoneParameters_CURRENCY withValue: @"EUR"];
    [parameters addKey: PayoneParameters_FIRSTNAME withValue: @"Max"];
    [parameters addKey: PayoneParameters_LASTNAME withValue: @"Mustermann"];
    [parameters addKey: PayoneParameters_COUNTRY withValue: @"DE"];
    
    
    for (int i = 1; i < 2; i++ )
    {
        NSString* id = [NSString stringWithFormat: PayoneParameters_ID_PLACEHOLDER , i];
        NSString* pr = [NSString stringWithFormat: PayoneParameters_PR_PLACEHOLDER , i];
        NSString* no = [NSString stringWithFormat: PayoneParameters_NO_PLACEHOLDER , i];
        NSString* de = [NSString stringWithFormat: PayoneParameters_DE_PLACEHOLDER , i];
        NSString* va = [NSString stringWithFormat: PayoneParameters_VA_PLACEHOLDER , i];
        
        [parameters addKey: id withValue: @"123-3456"];
        [parameters addKey: pr withValue: @"5900"];
        [parameters addKey: no withValue: @"1"];
        [parameters addKey: de withValue: @"Hamburger Royal"];
        [parameters addKey: va withValue: @"19"];
    }
    
    [parameters addKey: PayoneParameters_AMOUNT withValue: @"5900"];
    
    [parameters addKey: PayoneParameters_BANKCOUNTRY withValue: PayoneParameters_BankCountryParameter_DE];
    [parameters addKey: PayoneParameters_BANKACCOUNT withValue: @"123456789"];
    [parameters addKey: PayoneParameters_BANKCODE withValue: @"13070024"];
    
    NSString* m5_key = @"TuyuotaaNgaeboaWaithohD4ohKooz";
    
    [PayoneRequestFactory createAuthorizationRequest:self withValue: m5_key andParameters: parameters];
    
    self.labelResult.text = @"sending authorization request";
    self.labelResponse.textColor = [UIColor whiteColor];
    self.labelResult.textColor = [UIColor grayColor];    
}


-(void) onRequestResult:(ParameterCollection*) result
{
    NSMutableString* string = [[[NSMutableString alloc]init]autorelease];
    
    [string appendFormat:@" ------------- \n" ];
    
    for (NSString* key in [result.collection allKeys]) 
    {
        [string appendFormat:@"%@: %@\n", key, [result valueForKey:key]];
    }
    
    [string appendFormat:@" ------------- \n" ];
    
    self.labelResult.text = string;
    self.labelResult.textColor = [UIColor whiteColor];
    
    if([[result valueForKey:PayoneParameters_STATUS] isEqualToString:PayoneParameters_ResponseErrorCodes_ERROR])
    {
        self.labelResponse.textColor = [UIColor redColor];
    }
    else 
    {
        self.labelResponse.textColor = [UIColor greenColor];
    }
}

@end
