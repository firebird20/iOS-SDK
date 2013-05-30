//
//  PayonePaymentOverviewViewController.m
//  Payone App
//
//  Created by Rainer Grinninger on 18.02.13.
//
//

#import "PayonePaymentSummaryViewController.h"
#import "PayoneSettingsManager.h"

@interface PayonePaymentSummaryViewController (private)

-(NSString*) getFormattedAmount;

@end

@implementation PayonePaymentSummaryViewController

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
    
	self.title = NSLocalizedString(@"kPaymentSummary", nil);    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.button.hidden = NO;
    self.adressTextfield.text = [PayoneSettingsManager getInstance].address;
    self.paymentTypeTextfield.text = [PayoneSettingsManager getInstance].selectedPaymentType;
    self.amountTextfield.text = [NSString stringWithFormat:@"%@ %@", [PayoneSettingsManager getInstance].amount, [PayoneSettingsManager getInstance].getCurrency  ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_adressTextfield release];
    [_paymentTypeTextfield release];
    [_amountTextfield release];
//    [_button release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setAdressTextfield:nil];
    [self setPaymentTypeTextfield:nil];
    [self setAmountTextfield:nil];
    [self setButton:nil];
    [super viewDidUnload];
}

- (IBAction)sendButtonTouched:(id)sender
{
    self.button.hidden = YES;
    
    if([PayoneSettingsManager getInstance].testMode)
        [self.requestParams addKey:PayoneParameters_MODE withValue:  PayoneParameters_ModeParameter_TEST];
    else
        [self.requestParams addKey:PayoneParameters_MODE withValue:  PayoneParameters_ModeParameter_LIVE];

    NSString* amount =  [self.requestParams.collection objectForKey: PayoneParameters_AMOUNT];
    
    for (int i = 1; i < 2; i++ )
    {
        NSString* id = [NSString stringWithFormat: PayoneParameters_ID_PLACEHOLDER , i];
        NSString* pr = [NSString stringWithFormat: PayoneParameters_PR_PLACEHOLDER , i];
        NSString* no = [NSString stringWithFormat: PayoneParameters_NO_PLACEHOLDER , i];
//        NSString* de = [NSString stringWithFormat: PayoneParameters_DE_PLACEHOLDER , i];
        NSString* va = [NSString stringWithFormat: PayoneParameters_VA_PLACEHOLDER , i];
//
        [self.requestParams addKey: id withValue: @"123-3456"];
        [self.requestParams addKey: pr withValue: amount];
        [self.requestParams addKey: no withValue: @"1"];
//        [self.requestParams addKey: de withValue: @""];
        [self.requestParams addKey: va withValue: @"19"];
    }
    
    for (NSString* key in [self.requestParams.collection allKeys])
    {
        LogDebug(@"%@: %@\n", key, [self.requestParams.collection valueForKey:key]);
    }
    
    [self.requestParams addKey:PayoneParameters_ENCODING withValue:  PayoneParameters_UTF_8];
    NSString* country = [self.requestParams valueForKey:PayoneParameters_COUNTRY];
    [self.requestParams addKey:PayoneParameters_LANGUAGE withValue:  [country lowercaseString]];
    [self.requestParams addKey:PayoneParameters_AID withValue:  [PayoneSettingsManager getInstance].subAccountId];
    [self.requestParams addKey:PayoneParameters_MID withValue:  [PayoneSettingsManager getInstance].mid];
    [self.requestParams addKey:PayoneParameters_PORTALID withValue:  [PayoneSettingsManager getInstance].portalId];
    [self.requestParams addKey:PayoneParameters_RESPONSETYPE withValue:  PayoneParameters_ResponseTypeParameter_JSON];
    [self.requestParams addKey:PayoneParameters_STORECARDDATA withValue:  PayoneParameters_StoreCardDataParameter_YES];
    [self.requestParams addKey: PayoneParameters_CURRENCY withValue: [PayoneSettingsManager getInstance].getCurrency];
    [self.requestParams addKey: PayoneParameters_REFERENCE withValue: [[PayoneSettingsManager getInstance] createUniqueReferenceIdString]];
    [self.requestParams addKey: PayoneParameters_REQUEST   withValue:  PayoneParameters_RequestParameter_AUTHORIZATION];
    
    [PayoneRequestFactory createAuthorizationRequest:self withKey:[PayoneSettingsManager getInstance].key andParameters:self.requestParams];    
    
    // until request finishes
    self.button.hidden = YES;
}

-(void) onRequestResult:(ParameterCollection*) result
{
    NSString* otherButton = @"";
    NSMutableString* string = [[[NSMutableString alloc]init]autorelease];
    int tag = kResultLabelTag;
    
    
    [string appendFormat:@" ------------- \n" ];
    
    for (NSString* key in [result.collection allKeys])
    {
        [string appendFormat:@"%@: %@\n", key, [result valueForKey:key]];
    }
    
    if([result.collection[@"status"] isEqualToString:@"VALID"] || [result.collection[@"status"] isEqualToString:@"APPROVED"])
    {
        [self.navigationItem setHidesBackButton:YES animated:YES];
    }
    else
    {
        tag = kResultLabelTagFalse;
        // request not approved or valid
        // => show buttons so user can correct data

        [self.navigationItem setHidesBackButton:NO animated:YES];
        otherButton  = @"Neue Transaktion";
    }
    
    [string appendFormat:@" ------------- \n" ];    

    [self showAlertWithMessage:string andTitle:NSLocalizedString(@"kResultAlertTitle", nil) withTag:tag otherButtons:otherButton];
}

@end
