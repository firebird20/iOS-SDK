//
//  CreditcardDetailsViewController.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 23.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentDetailsBaseViewController.h"
#import "PayoneRequestFactory.h"
#import "PayoneDetailPickerViewController.h"

@interface PaymentCreditcardDetailsViewController : PaymentDetailsBaseViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *cardNumberTextfield;
@property (retain, nonatomic) IBOutlet UITextField *checkDigitTextfield;
@property (retain, nonatomic) IBOutlet UITextField *expireDateTextfield;
@property (retain, nonatomic) IBOutlet UITextField *cardOwnerTextfield;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) UITextField *activeField;
@property (retain, nonatomic) IBOutlet UIButton *button;
@property (retain, nonatomic) IBOutletCollection(UITextField) NSArray *inputTextfields;
- (IBAction)onButtonTouched:(id)sender;

@end
