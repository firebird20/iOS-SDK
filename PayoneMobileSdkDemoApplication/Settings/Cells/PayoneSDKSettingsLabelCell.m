//
//  PayoneSDKSettingsLabelCell.m
//  Payone App
//
//  Created by Rainer Grinninger on 06.02.13.
//
//

#import "PayoneSDKSettingsLabelCell.h"

@implementation PayoneSDKSettingsLabelCell

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

- (void)dealloc
{
    [_labelHeadline release];
    [_labelDescription release];
    [super dealloc];
}
@end
