//
//  PayoneSDKViewController.m
//  PayoneSDKdemoApp
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PayoneMainViewController.h"
#import "PayoneSettingsManager.h"
#import "PaymentDetailsBaseViewController.h"
#import "PayoneCustomUISettingsManager.h"
#import "PayoneImagePicker.h"

#define kCurrencyLabelTag 888

@interface PayoneMainViewController ()

@end


@implementation PayoneMainViewController


@synthesize requestParams = mRequestParams;


- (void)viewDidLoad
{ 
    [super viewDidLoad];
    self.title = NSLocalizedString(@"kPaymentMain", nil);
}

-(void) viewWillAppear:(BOOL)animated
{
    UILabel* label = (UILabel*) [self.view viewWithTag:kCurrencyLabelTag];
    label.text = [[PayoneSettingsManager getInstance] getCurrency];
 
    [self.amountTextfield addTarget:self
                           action:@selector(buttonTouched:)
                 forControlEvents:UIControlEventEditingDidEndOnExit];    
    
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"keyEditButton", nil) style:UIBarButtonItemStylePlain target:self action:@selector(settingsTouched)];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([PayoneCustomUISettingsManager sharedInstance].isSetImageMode)
    {
        PayoneImagePicker* imagePicker = [[PayoneImagePicker alloc] init];
        [imagePicker showModalViewForViewController:self];
    }    
}

- (void)viewDidUnload
{    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{
    self.requestParams = nil;
    [_amountTextfield release];
    [super dealloc];
}

-(void) settingsTouched
{
    [self performSegueWithIdentifier:@"showPasswordInput" sender:nil];
}

-(void) onInputFinished:(NSString*) inputString
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        if([[PayoneSettingsManager getInstance] passwordMatches:inputString])
            [self performSegueWithIdentifier:@"pushSettingsTable" sender:self];
        else
        {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"kWrongPasswordTitle", nil) message:NSLocalizedString(@"kWrongPasswordTitle", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"kOkBUttonTitle", nil) otherButtonTitles:NSLocalizedString(@"kPasswordTryAgain",nil), nil];
            alertView.delegate = self;
            [alertView show];
            [alertView release];
        }        
    }];
}

- (IBAction)buttonTouched:(id)sender
{
    if([self.amountTextfield.text isEqualToString:@""] || self.amountTextfield.text == nil) return;
    else
        [self performSegueWithIdentifier:@"showDetails" sender:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self performSegueWithIdentifier:@"showPasswordInput" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.requestParams = [[[ParameterCollection alloc] init] autorelease];
    
    // add formatted amount
    NSString* amount = [self getFormattedAmount];
    [self.requestParams addKey: PayoneParameters_AMOUNT withValue:amount];
   
    // memorize amount for summary 
    [PayoneSettingsManager getInstance].amount = self.amountTextfield.text;
    
    if([segue.identifier isEqualToString:@"showDetails"])
    {
        ((PaymentDetailsBaseViewController*) segue.destinationViewController).requestParams = self.requestParams;
    }
    if([segue.identifier isEqualToString:@"showPasswordInput"])
    {
        ((PasswordViewController*) segue.destinationViewController).type = PasswordInterfaceTypeInputSettings;
        ((PasswordViewController*) segue.destinationViewController).delegate = self;
    }
}

// amout needs to be in the right format
// that is th value in cents
// i.e. 1€ = 100 or 1,45 = 145
-(NSString*) getFormattedAmount
{
    NSString* amount = self.amountTextfield.text;
    NSArray* decimalPlaces = nil;
    
    // get decimal string by separating at "," or "."
    if([amount rangeOfString:@","].location != NSNotFound)
        decimalPlaces = [amount componentsSeparatedByString:@","];
    else if ([amount rangeOfString:@"."].location != NSNotFound)
        decimalPlaces = [amount componentsSeparatedByString:@"."];
    else
        decimalPlaces = @[amount];  // add amount for input witout seperator
   
    NSString* decimalPlaceString = @"";
    
    if([decimalPlaces count] > 1)
        decimalPlaceString = decimalPlaces[1];
   
    // fill up with zeros
    while ([decimalPlaceString length] <= 1)
    {
        decimalPlaceString = [decimalPlaceString stringByAppendingString:@"0"];
    }
    
    // adding formatted string
    amount = [decimalPlaces[0] stringByAppendingString:decimalPlaceString];
    
    return amount;
}

@end
