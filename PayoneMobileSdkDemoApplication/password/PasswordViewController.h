//
//  PasswordViewController.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 20.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayoneSDKBaseViewController.h"

@protocol PasswordInputDelegate <NSObject>

-(void)onInputFinished:(NSString*) inputString;

@end

enum PasswordInterfaceType 
{
    PasswordInterfaceTypeDefault = 0,    
    PasswordInterfaceTypeInput,
    PasswordInterfaceTypeInputSettings,
    PasswordInterfaceTypeChange,
    PasswordInterfaceTypeSet    
};
typedef enum PasswordInterfaceType PasswordInterfaceType;

@interface PasswordViewController : PayoneSDKBaseViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *passwordInput;
@property (retain, nonatomic) IBOutlet UITextField *passwordRepeat;
@property (retain, nonatomic) IBOutlet UILabel *errorLabel;
@property (assign, nonatomic) PasswordInterfaceType type;
@property (assign, nonatomic) id <PasswordInputDelegate> delegate;
@end
