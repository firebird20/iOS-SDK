//
//  PasswordViewController.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 20.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PasswordViewController.h"
#import "PayoneSettingsManager.h"
#import "PayoneCustomUISettingsManager.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController
@synthesize passwordInput;
@synthesize passwordRepeat;
@synthesize errorLabel;
@synthesize type;


- (void)dealloc 
{
    [passwordInput release];
    [passwordRepeat release];
    [errorLabel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.type != PasswordInterfaceTypeDefault) 
    {
        [self.navigationItem setHidesBackButton:YES];
        return;
    }
    
    self.type = PasswordInterfaceTypeInput;
    if(![[PayoneSettingsManager getInstance] passwordSet])
    {
        self.type = PasswordInterfaceTypeSet;
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    self.passwordInput.enabled = NO;
    self.passwordInput.secureTextEntry = YES;
    self.passwordInput.enabled = YES;
    
    self.title = NSLocalizedString(@"keyPasswordTitle", nil);
    self.navigationController.navigationBar.tintColor = [PayoneCustomUISettingsManager navigationBarColor];

    [self.passwordInput becomeFirstResponder];
    
    if(self.type == PasswordInterfaceTypeInput || self.type == PasswordInterfaceTypeInputSettings)
    {
       self.passwordRepeat.hidden = YES;        
    }    
    
    
    self.passwordInput.returnKeyType = UIReturnKeyDone;    
    self.passwordRepeat.returnKeyType = UIReturnKeyDone;
    
    [self.passwordInput addTarget:self
                           action:@selector(textFieldFinished:)
                 forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.passwordRepeat addTarget:self
                            action:@selector(textFieldFinished:)
                  forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    [super viewWillAppear:animated];
    
}

- (IBAction)textFieldFinished:(id)sender
{
     [sender resignFirstResponder];
    
    self.errorLabel.hidden = YES;
    
    // check password before entering settings
    if(self.type == PasswordInterfaceTypeInputSettings)
    {
        [self.delegate onInputFinished:self.passwordInput.text];
    }    
    // standard pw input
    else if([[PayoneSettingsManager getInstance] passwordMatches:self.passwordInput.text] && self.type == PasswordInterfaceTypeInput)
    {     
        [self performSegueWithIdentifier:@"showMain" sender:self];
    }
    // password change
    else if(self.type == PasswordInterfaceTypeChange && ![passwordInput.text isEqualToString:@""] && [passwordInput.text isEqualToString:passwordRepeat.text]) 
    {
        [self.navigationController popViewControllerAnimated:YES];        
    }
    // initial pw set
    else if(self.type == PasswordInterfaceTypeSet && ![passwordInput.text isEqualToString:@""] && [passwordInput.text isEqualToString:passwordRepeat.text]) 
    {
        [self performSegueWithIdentifier:@"showMain" sender:self];
    }
    else
    {
        if(![[PayoneSettingsManager getInstance] passwordMatches:self.passwordInput.text])        
        {
            self.errorLabel.hidden = NO;
            self.errorLabel.text = NSLocalizedString(@"keyWrongPassword", nil);
            self.errorLabel.backgroundColor = [UIColor whiteColor];
            self.passwordInput.textColor = [UIColor redColor];
            self.passwordInput.secureTextEntry = NO;
            self.passwordInput.text = NSLocalizedString(@"keyWrongPassword", nil);
            
            [self performSelector:@selector(resetField) withObject:nil afterDelay:1];
        }    
    }
}

-(void) resetField
{
    self.passwordInput.enabled = NO;
    self.passwordInput.secureTextEntry = YES;
    self.passwordInput.enabled = YES;
    [self.passwordInput becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setPasswordInput:nil];
    [self setPasswordRepeat:nil];
    [self setErrorLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{   
    if(self.type == PasswordInterfaceTypeChange || self.type == PasswordInterfaceTypeSet)
    {
        if(![passwordInput.text isEqualToString:@""] && [passwordInput.text isEqualToString:passwordRepeat.text] && [passwordInput.text length] == [passwordRepeat.text length])
        {
            self.passwordRepeat.textColor = [UIColor redColor];
            [[PayoneSettingsManager getInstance]setPassword:self.passwordInput.text];
        }
        else if([passwordInput.text length] == [passwordRepeat.text length])
        {
            self.passwordRepeat.textColor = [UIColor greenColor];
        }
        else 
        {
            self.passwordRepeat.textColor = [UIColor blackColor];
        }
    }
    
    self.errorLabel.hidden = YES;
    self.errorLabel.text = @"";
    
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{

}
@end
