//
//  PayoneBillingViewController.h
//  Payone App
//
//  Created by Rainer Grinninger on 18.02.13.
//
//

#import "PaymentDetailsBaseViewController.h"

@interface PaymentBillingViewController : PaymentDetailsBaseViewController
@property (retain, nonatomic) IBOutlet UITextField *emailTextfield;
- (IBAction)sendBUttonTouched:(id)sender;

@end
