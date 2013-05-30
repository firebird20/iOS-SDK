//
//  PaymentTypeSelectionCell.m
//  Payone App
//
//  Created by Rainer Grinninger on 08.04.13.
//
//

#import "PaymentTypeSelectionCell.h"

@implementation PaymentTypeSelectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_button release];
    [super dealloc];
}
- (IBAction)onButtonTouched:(id)sender
{
    [self.delegate buttonTouched:sender];
}
@end
