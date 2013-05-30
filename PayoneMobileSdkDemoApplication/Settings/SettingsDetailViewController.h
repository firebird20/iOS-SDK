//
//  SettingsViewController.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 21.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayoneSettingsVo.h"
#import "PayoneSDKBaseViewController.h"


@protocol SettingViewControllerDelegate <NSObject>

-(void) valueDidChange:(NSString*) value forTag:(POSettingsDefType) type;

@end

@interface SettingsDetailViewController : PayoneSDKBaseViewController <UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UILabel *settingValueLabel;
@property (retain, nonatomic) IBOutlet UITextField *textField;
@property (assign, nonatomic) id <SettingViewControllerDelegate> delegate;
@property (assign, nonatomic) POSettingsDefType type;
@property (retain, nonatomic) NSString* currentValue;
@end
