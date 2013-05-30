//
//  PaymentTypeSelectionCell.h
//  Payone App
//
//  Created by Rainer Grinninger on 08.04.13.
//
//

#import <UIKit/UIKit.h>

@protocol PaymentTypeSelectionCellDelegate <NSObject>

-(void) buttonTouched: (id) sender;

@end

@interface PaymentTypeSelectionCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIButton *button;
@property (assign, nonatomic) id <PaymentTypeSelectionCellDelegate> delegate;
- (IBAction)onButtonTouched:(id)sender;


@end
