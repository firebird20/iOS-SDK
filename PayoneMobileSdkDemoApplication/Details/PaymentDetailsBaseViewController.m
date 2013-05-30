//
//  DetailsBaseViewController.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 23.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PaymentDetailsBaseViewController.h"
#import "PayoneMainViewController.h"

@interface PaymentDetailsBaseViewController ()

@end

@implementation PaymentDetailsBaseViewController

@synthesize requestParams;

-(void) viewDidLoad
{    
    [super viewDidLoad];
}

-(void) dealloc
{
    self.requestParams = nil;
    [super dealloc];
}

-(void) setTextfieldFinished:(NSArray*) textfields
{
    for (UITextField* textfield in textfields)
    {
        textfield.returnKeyType = UIReturnKeyDone;
        [textfield addTarget:self  action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
}

-(void) log:(id) view withName:(NSString*) name
{
    UIView* views = (UIView*) view;
}

-(BOOL) allParamsSet:(NSArray*) array
{
    for (UITextField* textfield in array)
    {
        if([textfield.text isEqualToString:@""]) return FALSE;
    }
    return YES;
}



-(void) backToMain
{
    for (UIViewController* controller in self.navigationController.viewControllers) 
    {
        if([controller class] == [PayoneMainViewController class])
        {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}


#pragma mark Alerts
#pragma

-(void) showMissingInputAlert
{
    [self showAlertWithMessage:NSLocalizedString(@"kMissingInputMessage", nil) andTitle:NSLocalizedString(@"kMissingInputTitle", nil) withTag:0 otherButtons:nil];
}


-(void) showAlertWithMessage:(NSString*) message andTitle:(NSString*) title withTag:(int) tag otherButtons:(NSString*) otherButton
{
    UIAlertView* alertView;
    if(tag == kResultLabelTag)
        alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:NSLocalizedString(@"kOkBUttonTitle", nil) otherButtonTitles: nil];
    else
        alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:NSLocalizedString(@"kOkBUttonTitle", nil) otherButtonTitles:otherButton, nil];
    
    [alertView show];
    alertView.tag = tag;
    [alertView release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == kResultLabelTag)
        [self performSelector:@selector(backToMain) withObject:nil afterDelay:1];
    if(alertView.tag == kResultLabelTagFalse)
    {
        if(buttonIndex == 1)
            [self performSelector:@selector(backToMain) withObject:nil afterDelay:1];
    }
    
}

@end
