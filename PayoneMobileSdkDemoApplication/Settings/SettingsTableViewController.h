//
//  POSettinsTableViewController.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 22.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsDetailViewController.h"

@interface SettingsTableViewController : UITableViewController <SettingViewControllerDelegate>


@property (nonatomic, retain) NSArray* settingsData;
- (void) updateBackgroundImage;
@end
