//
//  PayoneSettingsSwitchCell.m
//  Payone App
//
//  Created by Rainer Grinninger on 06.02.13.
//
//

#import "PayoneSettingsSwitchCell.h"

@implementation PayoneSettingsSwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchActionValueChanged:(id)sender
{
    [self.delegate switchActionValueChanged:sender indexPath:self.indexPath];
}
- (void)dealloc {

    self.indexPath = nil;
    [_uiSwitch release];
    [super dealloc];
}
@end
