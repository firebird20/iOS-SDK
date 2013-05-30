//
//  PayonePamentTypeSelectionViewController.h
//  Payone App
//
//  Created by Rainer Grinninger on 18.02.13.
//
//

#import <UIKit/UIKit.h>
#import "ParameterCollection.h"
#import "PaymentTypeSelectionCell.h"

@interface PayonePaymentTypeSelectionViewController : UITableViewController <PaymentTypeSelectionCellDelegate>

@property (retain, nonatomic) ParameterCollection* requestParams;
@property (retain, nonatomic) NSArray* data;

@end
