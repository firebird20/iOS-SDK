//
//  SettingsViewController.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 21.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "SettingsDetailViewController.h"
#import "PayoneCustomUISettingsManager.h"


@interface SettingsDetailViewController ()

@end

@implementation SettingsDetailViewController
@synthesize settingValueLabel;
@synthesize textField;
@synthesize delegate;
@synthesize type;
@synthesize currentValue;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textField.returnKeyType = UIReturnKeyDone;
    [self.textField becomeFirstResponder];
    self.settingValueLabel.text = self.title;
    
    [self.textField addTarget:self
                           action:@selector(textFieldFinished:)
                 forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.navigationItem setHidesBackButton:YES];

    self.textField.text = self.currentValue;
    self.settingValueLabel.textColor = [PayoneCustomUISettingsManager textColor];
    
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setSettingValueLabel:nil];
    self.currentValue = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)textFieldFinished:(id)sender
{
    [self backButtonTouched ];
}


-(void) backButtonTouched
{
    [self.delegate valueDidChange: self.textField.text forTag:self.type];
    [self.textField resignFirstResponder];
}

- (void)dealloc 
{
    [textField release];
    [settingValueLabel release];
    [super dealloc];
}
@end
