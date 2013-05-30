//
//  POSettingsTableViewController.h
//  Payone App
//
//  Created by Rainer Grinninger on 05.02.13.
//
//

#import <UIKit/UIKit.h>
#import "PayoneSettingsSwitchCell.h"
#import "PayoneDetailPickerViewController.h"

@interface POSettingsTableViewController : UITableViewController <PayoneSettingsCellProtocol, UITextFieldDelegate, PayonePickerViewDelegate>
{
    CGRect keyboardBounds;
}

@property (nonatomic, retain) NSArray* data;

@end
