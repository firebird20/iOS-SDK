//
//  AccountDetailsViewController.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 23.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PaymentDebitDetailsViewController.h"
#import "PayoneMainViewController.h"

@interface PaymentDebitDetailsViewController ()

@end

@implementation PaymentDebitDetailsViewController
@synthesize accountTextfield;
@synthesize bankCodeTextfield;
@synthesize inputTextfields;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.title = NSLocalizedString(@"kPaymentDebitDetailsTitle", nil);
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [self.bankCodeTextfield addTarget:self
                             action:@selector(buttonTouched:)
                   forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.title = NSLocalizedString(@"kPaymentTitleDebit", nil);
    [self setTextfieldFinished:self.inputTextfields];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setAccountTextfield:nil];
    [self setBankCodeTextfield:nil];

    [self setInputTextfields:nil];
    [self setAccountNameTextfield:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [accountTextfield release];
    [bankCodeTextfield release];

    [inputTextfields release];
    [_accountNameTextfield release];
    [super dealloc];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        [self onButtonTouched:textField];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (IBAction)onButtonTouched:(id)sender 
{
    if([self allParamsSet:self.inputTextfields])
    {
        [self.requestParams addKey: PayoneParameters_CLEARINGTYPE withValue: PayoneParameters_ClearingTypeParameter_DEBIT];
        [self.requestParams addKey: PayoneParameters_BANKACCOUNT withValue: self.accountTextfield.text];
        [self.requestParams addKey: PayoneParameters_BANKCOUNTRY withValue: [self.requestParams valueForKey:PayoneParameters_COUNTRY]];
        [self.requestParams addKey: PayoneParameters_BANKCODE withValue: self.bankCodeTextfield.text];
            
        [self performSegueWithIdentifier:@"debitToCheckout" sender:self];            
    }
    else
        [self showMissingInputAlert];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"debitToCheckout"])
    {
        ((PaymentDetailsBaseViewController*) segue.destinationViewController).requestParams = self.requestParams;
    }
}

@end
