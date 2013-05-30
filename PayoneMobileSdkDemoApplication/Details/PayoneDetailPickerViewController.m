//
//  PayoneDetailPickerView.m
//  Payone App
//
//  Created by Rainer Grinninger on 30.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PayoneDetailPickerViewController.h"
#import "PayoneCustomUISettingsManager.h"

@implementation PayoneDetailPickerViewController 
@synthesize toolbar;
@synthesize pickerView;
@synthesize doneButton;
@synthesize pickerData;
@synthesize delegate;


-(void) viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor clearColor];
    self.toolbar.tintColor = [PayoneCustomUISettingsManager navigationBarColor];
    [self.doneButton setAction:@selector(doneButtonTouched:)];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.descriptionLabel.text = self.descriptionText;
    self.pickerView.frameBottom = self.view.frameBottom;
    self.toolbar.frameBottom = self.pickerView.frameTop;
    
    [super viewWillAppear:animated];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex: row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

- (void)dealloc 
{
    self.pickerData = nil;
    [doneButton release];
    [pickerView release];
    [toolbar release];
    [_descriptionLabel release];
    [super dealloc];
}
- (void)viewDidUnload 
{
    [self setDoneButton:nil];
    [self setPickerView:nil];
    [self setToolbar:nil];
    [self setDescriptionLabel:nil];
    [super viewDidUnload];
}

- (IBAction)doneButtonTouched:(id)sender
{
    [self.delegate pickerDidSelectItem:[self.pickerView selectedRowInComponent:0] withTitle:[self.pickerData objectAtIndex:[self.pickerView selectedRowInComponent:0]]];
    [self dismissModalViewControllerAnimated:YES];
}
@end
