//
//  PayoneSDKViewController.h
//  PayoneSDKdemoApp
//
//  Created by Rainer Grinninger on 21.06.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PayoneMobileSdk.h"
#import "PayoneRequestFactory.h"
#import "PayoneSDKBaseViewController.h"
#import "PasswordViewController.h"

@interface PayoneMainViewController : PayoneSDKBaseViewController < UITableViewDelegate, UITableViewDataSource, PasswordInputDelegate, UIAlertViewDelegate>
{
    ParameterCollection* mRequestParams;
}


@property (retain, nonatomic) IBOutlet UITextField *amountTextfield;
@property (retain, nonatomic) ParameterCollection* requestParams;

@end
