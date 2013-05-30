//
//  PayoneSettingsSwitchCell.h
//  Payone App
//
//  Created by Rainer Grinninger on 06.02.13.
//
//

#import <UIKit/UIKit.h>
#import "PayoneSDKSettingsCell.h"
@protocol PayoneSettingsCellProtocol
-(void)switchActionValueChanged:(id)sender indexPath:(NSIndexPath*) tag;
@end

@interface PayoneSettingsSwitchCell : PayoneSDKSettingsCell

@property (retain, nonatomic) IBOutlet UISwitch *uiSwitch;
@property (nonatomic, assign) id <PayoneSettingsCellProtocol> delegate;
@property (retain, nonatomic) IBOutlet UILabel *labelHeadline;
@property (retain, nonatomic) NSIndexPath* indexPath;

- (IBAction)switchActionValueChanged:(id)sender;


@end
