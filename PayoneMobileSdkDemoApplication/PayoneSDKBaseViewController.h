//
//  PayoneSDKBaseViewController.h
//  Payone App
//
//  Created by Rainer Grinninger on 14.11.12.
//
//

#import <UIKit/UIKit.h>
#import "PayoneCustomUISettingsManager.h"

@interface PayoneSDKBaseViewController : UIViewController <UIGestureRecognizerDelegate>

@property (retain, nonatomic) IBOutletCollection(UILabel) NSArray *uiLabelCollection;
@property (retain, nonatomic) IBOutletCollection(UITextField) NSArray *textViewCollection;
@property (nonatomic, retain) UIImage* backgroundImage;
@property (retain, nonatomic) IBOutlet UIButton *button;

-(void) setButtonColor;


@end
