//
//  CreditcardDetailsViewController.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 23.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PaymentCreditcardDetailsViewController.h"
#import "PayoneSettingsManager.h"



@interface PaymentCreditcardDetailsViewController (private)

-(void) registerForKeyboardNotifications;

@end

@implementation PaymentCreditcardDetailsViewController
@synthesize cardNumberTextfield;
@synthesize checkDigitTextfield;
@synthesize expireDateTextfield;
@synthesize button;
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

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

-(void) viewWillAppear:(BOOL)animated
{
    self.scrollView.frameHeight = self.view.frameHeight;
    self.scrollView.frameY = 0;

    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [self registerForKeyboardNotifications];

    self.title = NSLocalizedString(@"kPaymentCredicardDetailsTitle", nil);
    [self setTextfieldFinished:self.inputTextfields];
    [super viewDidLoad];
    
    [self.expireDateTextfield addTarget:self
                             action:@selector(onButtonTouched:)
                   forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)viewDidUnload
{
    [self setCardNumberTextfield:nil];
    [self setCheckDigitTextfield:nil];
    [self setExpireDateTextfield:nil];
    [self setButton:nil];

    [self setInputTextfields:nil];
    [self setCardOwnerTextfield:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{
    [cardNumberTextfield release];
    [checkDigitTextfield release];
    [expireDateTextfield release];
    [button release];
    [inputTextfields release];
    [_cardOwnerTextfield release];
    [_scrollView release];
    [super dealloc];
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) )
    {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.self.activeField = textField;
    [textField becomeFirstResponder];
    
    [self performSelector:@selector(scrollToTextfield) withObject:nil afterDelay:.25];
}

-(void) scrollToTextfield
{
    CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y - 155);
    if (self.activeField == self.cardOwnerTextfield)
        scrollPoint = CGPointZero;
    
    [self.scrollView setContentOffset:scrollPoint animated:YES];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{      

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


- (IBAction)onButtonTouched:(id)sender 
{
    self.activeField = self.cardOwnerTextfield;
    [self scrollToTextfield];
    
    
    if([self allParamsSet:self.inputTextfields])
    {
        [self.requestParams addKey: PayoneParameters_CARDHOLDER withValue: self.checkDigitTextfield.text];
        [self.requestParams addKey:PayoneParameters_CLEARINGTYPE  withValue: PayoneParameters_ClearingTypeParameter_CREDITCARD];
        
        [self.requestParams addKey: PayoneParameters_CARDCVC2 withValue: self.checkDigitTextfield.text];
        [self.requestParams addKey: PayoneParameters_CARDPAN withValue: self.cardNumberTextfield.text];  
        [self.requestParams addKey: PayoneParameters_CARDEXPIREDATE withValue: self.expireDateTextfield.text];

        for (NSString* key in [self.requestParams.collection allKeys]) 
        {
            LogDebug(@"%@: %@\n", key, [self.requestParams.collection valueForKey:key]);
        }        
        
        [self performSegueWithIdentifier:@"creditToCheckout" sender:self];
    }
    else
        [self showMissingInputAlert];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"creditToCheckout"])
    {
        ((PaymentDetailsBaseViewController*) segue.destinationViewController).requestParams = self.requestParams;
    }
}

@end
