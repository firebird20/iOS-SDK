//
//  PayonePaymentOverviewViewController.h
//  Payone App
//
//  Created by Rainer Grinninger on 18.02.13.
//
//

#import "PaymentDetailsBaseViewController.h"



@interface PayonePaymentSummaryViewController : PaymentDetailsBaseViewController <PayoneSdkProtocol>
@property (retain, nonatomic) IBOutlet UILabel *adressTextfield;
@property (retain, nonatomic) IBOutlet UILabel *paymentTypeTextfield;
@property (retain, nonatomic) IBOutlet UILabel *amountTextfield;
@property (retain, nonatomic) IBOutlet UIButton *button;
- (IBAction)sendButtonTouched:(id)sender;

@end
