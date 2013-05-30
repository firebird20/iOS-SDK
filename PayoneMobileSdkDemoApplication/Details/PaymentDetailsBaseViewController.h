//
//  DetailsBaseViewController.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 23.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayoneRequestFactory.h"
#import "PayoneSDKBaseViewController.h" 

#define kResultLabelTag 11
#define kResultLabelTagFalse 12

@interface PaymentDetailsBaseViewController : PayoneSDKBaseViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) ParameterCollection* requestParams;

-(BOOL) allParamsSet:(NSArray*) array;
-(void) setTextfieldFinished:(NSArray*) textfields;
-(void) backToMain;
-(void) showAlertWithMessage:(NSString*) message andTitle:(NSString*) title withTag:(int) tag otherButtons:(NSString*) otherButton;
-(void) log:(id) view withName:(NSString*) name;
-(void) showMissingInputAlert;
@end
