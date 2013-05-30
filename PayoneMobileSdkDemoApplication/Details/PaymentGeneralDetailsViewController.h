//
//  PaymentDetailsViewController.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 23.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PaymentDetailsBaseViewController.h"
#import "PayoneDetailPickerViewController.h"


@interface PaymentGeneralDetailsViewController : PaymentDetailsBaseViewController <PayonePickerViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *firstNameTextfield;
@property (retain, nonatomic) IBOutlet UITextField *lastNameTextfield;
@property (retain, nonatomic) IBOutlet UITextField *streetTextfield;
@property (retain, nonatomic) IBOutlet UITextField *plzTextfield;
@property (retain, nonatomic) IBOutlet UITextField *placeTextfield;
@property (retain, nonatomic) IBOutlet UITextField *houseNoTextfield;
@property (retain, nonatomic) IBOutlet UITextField *countryTextfield;
@property (retain, nonatomic) IBOutletCollection(UITextField) NSArray *inputTextFields;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) UITextField *activeField;


- (IBAction)onEditCountry:(id)sender;
- (IBAction)buttonTouched:(id)sender;
-(void) scrollToTextfield;
- (IBAction)countryButtonTouched:(id)sender;

@end
