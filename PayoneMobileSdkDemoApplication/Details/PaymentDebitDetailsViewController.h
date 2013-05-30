//
//  AccountDetailsViewController.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 23.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentDetailsBaseViewController.h"
#import "PayoneRequestFactory.h"
#import "PayoneSettingsManager.h"
@interface PaymentDebitDetailsViewController : PaymentDetailsBaseViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *accountTextfield;
@property (retain, nonatomic) IBOutlet UITextField *bankCodeTextfield;
@property (retain, nonatomic) IBOutlet UITextField *accountNameTextfield;
@property (retain, nonatomic) IBOutletCollection(UITextField) NSArray *inputTextfields;

- (IBAction)onButtonTouched:(id)sender;

@end
