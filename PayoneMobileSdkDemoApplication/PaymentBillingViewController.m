//
//  PayoneBillingViewController.m
//  Payone App
//
//  Created by Rainer Grinninger on 18.02.13.
//
//

#import "PaymentBillingViewController.h"
#import "PayoneSettingsManager.h"

@interface PaymentBillingViewController ()

@end

@implementation PaymentBillingViewController

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
    [self.emailTextfield addTarget:self
                               action:@selector(sendBUttonTouched:)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.title = NSLocalizedString(@"kPaymentBillingDetailsTitle", nil);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_emailTextfield release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setEmailTextfield:nil];
    [super viewDidUnload];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    [self sendBUttonTouched:textField];
    return NO; // We do not want UITextField to insert line-breaks.
}

- (IBAction)sendBUttonTouched:(id)sender
{
    LogDebug(@"- (IBAction)sendBUttonTouched:(id)sender");
    if([self.emailTextfield.text isEqualToString:@""] || [self.emailTextfield.text rangeOfString:@"@"].location == NSNotFound) return;
    [self.requestParams addKey:PayoneParameters_EMAIL withValue:self.emailTextfield.text];

    [self performSegueWithIdentifier:@"billingToCheckout" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    [self.requestParams addKey:PayoneParameters_CLEARINGTYPE  withValue: PayoneParameters_ClearingTypeParameter_BILL];
    [self.requestParams addKey:PayoneParameters_ENCODING withValue:  PayoneParameters_UTF_8];
    
    if([segue.identifier isEqualToString:@"billingToCheckout"])
    {
        ((PaymentDetailsBaseViewController*) segue.destinationViewController).requestParams = self.requestParams;
    }
}
@end
