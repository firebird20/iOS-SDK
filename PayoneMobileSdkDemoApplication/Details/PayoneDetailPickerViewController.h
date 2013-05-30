//
//  PayoneDetailPickerView.h
//  Payone App
//
//  Created by Rainer Grinninger on 30.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayoneSDKBaseViewController.h"

@protocol PayonePickerViewDelegate <NSObject>

-(void) pickerDidSelectItem:(int) index withTitle:(NSString*) title;
@end



@interface PayoneDetailPickerViewController : PayoneSDKBaseViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerView;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (retain, nonatomic) NSArray* pickerData;
@property (retain, nonatomic) NSString* descriptionText;
@property (retain, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (assign, nonatomic) id <PayonePickerViewDelegate> delegate;

- (IBAction)doneButtonTouched:(id)sender;

@end
