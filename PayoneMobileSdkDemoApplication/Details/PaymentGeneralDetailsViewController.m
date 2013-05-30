//
//  PaymentDetailsViewController.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 23.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PaymentGeneralDetailsViewController.h"
#import "PayoneSettingsManager.h"
#import "PayonePaymentTypeSelectionViewController.h"

@interface PaymentGeneralDetailsViewController ()

@end

@implementation PaymentGeneralDetailsViewController

@synthesize firstNameTextfield;
@synthesize lastNameTextfield;
@synthesize countryTextfield;
@synthesize scrollView;
@synthesize activeField;



- (void)dealloc 
{
    [firstNameTextfield release];
    [lastNameTextfield release];
    [countryTextfield release];
    [scrollView release];
    [_streetTextfield release];
    [_plzTextfield release];
    [_placeTextfield release];
    [_houseNoTextfield release];
    [_inputTextFields release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"kPersonalInput", nil);
}

-(void) viewDidAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
    
    // set default value
    NSString* code = [[[PayoneSettingsManager getInstance] getCountryCodes] objectAtIndex:0];
    [self.requestParams addKey: PayoneParameters_COUNTRY withValue: code];
    
    // set default country (current choice)
    [self.requestParams addKey: PayoneParameters_COUNTRY withValue: PayoneParameters_BankCountryParameter_DE];
    
   
    [super viewDidAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];

    [self setStreetTextfield:nil];
    [self setPlzTextfield:nil];
    [self setPlaceTextfield:nil];
    [self setHouseNoTextfield:nil];
    [self setPlzTextfield:nil];
    [self setInputTextFields:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    scrollView.contentInset = contentInsets;    
    scrollView.scrollIndicatorInsets = contentInsets;   
    
    // If active text field is hidden by keyboard, scroll it so it's visible    
    // Your application might not need or want this behavior.    
    CGRect aRect = self.view.frame;
    
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) 
    {        
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);        
        [scrollView setContentOffset:scrollPoint animated:YES];        
    }    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    scrollView.contentInset = contentInsets;    
    scrollView.scrollIndicatorInsets = contentInsets;    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;   
    [self performSelector:@selector(scrollToTextfield) withObject:nil afterDelay:.25];
}

-(void) scrollToTextfield
{
    CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-105);
    if (!self.activeField || self.activeField == self.countryTextfield)
        scrollPoint = CGPointZero;

    [scrollView setContentOffset:scrollPoint animated:YES];
}

- (IBAction)countryButtonTouched:(id)sender
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
    
    if(textField == self.placeTextfield)
    {
        [textField resignFirstResponder];
        [self performSegueWithIdentifier:@"showPicker" sender:self];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;

    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder)
    {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (IBAction)onEditCountry:(id)sender
{
    self.activeField = self.countryTextfield;
//    [self.countryTextfield resignFirstResponder];
    [self performSegueWithIdentifier:@"showPicker" sender:self];
}

- (IBAction)buttonTouched:(id)sender 
{
    if([self allParamsSet:self.inputTextFields])
    {
        [self.requestParams addKey: PayoneParameters_FIRSTNAME withValue: self.firstNameTextfield.text];     
        [self.requestParams addKey: PayoneParameters_LASTNAME withValue: self.lastNameTextfield.text];
        [self.requestParams addKey: PayoneParameters_ZIP withValue: self.plzTextfield.text];
        [self.requestParams addKey: PayoneParameters_CITY withValue: self.placeTextfield.text];
        [self.requestParams addKey: PayoneParameters_STREET withValue: [NSString stringWithFormat:@"%@  %@", self.streetTextfield.text, self.houseNoTextfield.text]];
        
        NSString* address = [NSString stringWithFormat:@"%@ %@ \n%@ \n%@ %@ \n%@",
                             self.firstNameTextfield.text,
                             self.lastNameTextfield.text,
                             [NSString stringWithFormat:@"%@  %@", self.streetTextfield.text, self.houseNoTextfield.text],
                             self.plzTextfield.text,
                             self.placeTextfield.text,
                             self.countryTextfield.text];
        
        [PayoneSettingsManager getInstance].address = address;
        
        [self performSegueWithIdentifier:@"showPaymentSelection" sender:self];
    }
    else
        [self showMissingInputAlert];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showPicker"])
    {
        ((PayoneDetailPickerViewController*) segue.destinationViewController).pickerData = [[PayoneSettingsManager getInstance] getCountryLocaValues];
        ((PayoneDetailPickerViewController*) segue.destinationViewController).descriptionText = NSLocalizedString(@"kCountrySelectionDescription", nil);
        ((PayoneDetailPickerViewController*) segue.destinationViewController).delegate = self;
    }
    if([segue.identifier isEqualToString:@"showPaymentSelection"])
    {
        ((PaymentDetailsBaseViewController*) segue.destinationViewController).requestParams = self.requestParams;
    }
}

-(void) pickerDidSelectItem:(int) index withTitle:(NSString*) title
{
    NSString* code = [[[PayoneSettingsManager getInstance] getCountryCodes] objectAtIndex:index];
    [self.requestParams addKey: PayoneParameters_COUNTRY withValue: code];
    self.countryTextfield.text = title;
    [self.countryTextfield resignFirstResponder];
    [self scrollToTextfield];
}


@end
