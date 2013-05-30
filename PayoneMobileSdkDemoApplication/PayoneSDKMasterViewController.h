//
//  PayoneSDKViewController.h
//  PayoneSDKdemoApp
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "PayoneMobileSdk.h"

@interface PayoneSDKViewController : UIViewController  <PayoneSdkProtocol>
@property (retain, nonatomic) IBOutlet UILabel *labelResponse;
@property (retain, nonatomic) IBOutlet UILabel *labelResult;

- (IBAction)buttonCreditcard:(id)sender;
- (IBAction)buttonPreAuthorize:(id)sender;
- (IBAction)buttonAuthorize:(id)sender;
- (NSString*) createUniqueReferenceIdString;
@end
