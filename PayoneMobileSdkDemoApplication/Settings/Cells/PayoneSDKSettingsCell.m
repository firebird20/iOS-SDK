//
//  PayoneSDKSettingsCell.m
//  Payone App
//
//  Created by Rainer Grinninger on 05.02.13.
//
//

#import "PayoneSDKSettingsCell.h"

@implementation PayoneSDKSettingsCell

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

- (void)dealloc {
    [_labelHeadline release];
    [_textField release];
    [super dealloc];
}
@end
