//  PayoneSDKBaseViewController.m
//  Payone App
//
//  Created by Rainer Grinninger on 14.11.12.
//
//

#import "PayoneSDKBaseViewController.h"
#import "PayoneCustomUISettingsManager.h"

@interface PayoneSDKBaseViewController (private)

-(void) updateUI;

@end

@implementation PayoneSDKBaseViewController

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_textViewCollection release];
    [_uiLabelCollection release];

    [_button release];
    [super dealloc];
}

-(void) loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.delegate = self;
    
    [self.view addGestureRecognizer:tap];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateBackgroundImage)
                                                 name:kUpdateBackgroundImageNotification
                                               object:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    
    for (id object in [gestureRecognizer.view subviews])
    {
        if ([object isKindOfClass:[UIButton class]] || [object isKindOfClass:[UIToolbar class]])
        {
            return NO;
        }
         
        if ([object isKindOfClass:[UIScrollView class]])
        {
            for (id subObjects in [object subviews])
            {
                if ([subObjects isKindOfClass:[UIButton class]] || [subObjects isKindOfClass:[UIToolbar class]])
                {
                    return NO;
                }
            }
        }
    }

    return YES;
}

-(void)dismissKeyboard
{
    for (UITextField* textfield in self.textViewCollection)
    {
        if([textfield isFirstResponder])
            [textfield resignFirstResponder];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if(self.backgroundImage != [PayoneCustomUISettingsManager backgroundImage])
    {
        [self updateBackgroundImage];
        [self updateUI];
    }
    
//    self.button.frameBottom = self.view.frameBottom -20;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateUI
{    
    [self setButtonColor];
    
    for (UITextField* textfield in self.textViewCollection)
    {
        textfield.textColor = [PayoneCustomUISettingsManager textColor];
    }
    
    for (UILabel* label in self.uiLabelCollection)
    {
        label.textColor = [PayoneCustomUISettingsManager textColor];
    }
}

-(void) setButtonColor
{
    UIButton* button = (UIButton*)[self.view viewWithTag:444];
    if(button)
    {
        button.titleLabel.textColor = [PayoneCustomUISettingsManager textColor];
        [button setTitleColor:[PayoneCustomUISettingsManager textColor] forState:UIControlStateNormal];
        [button setTitleColor:[PayoneCustomUISettingsManager textColor] forState:UIControlStateSelected];
        [button setTitleColor:[PayoneCustomUISettingsManager textColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[PayoneCustomUISettingsManager textColor] forState:UIControlStateDisabled];
    }
}

- (IBAction)sendButtonTouched:(id)sender {
}

- (void) updateBackgroundImage
{
    UIView* backgroundView = [self.view viewWithTag:333];
    if([[[backgroundView subviews]objectAtIndex:0] isKindOfClass:[UIImageView class]])
    {
        UIImageView* imageView = [[backgroundView subviews]objectAtIndex:0];
        [imageView removeFromSuperview];
    }
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[PayoneCustomUISettingsManager backgroundImage]];
    imageView.bounds = backgroundView.bounds;
    imageView.backgroundColor = [UIColor blueColor];
    imageView.frameX = 0;
    imageView.frameY = 0;
    [backgroundView insertSubview:imageView atIndex:0];
    [imageView release];
}

- (void)viewDidUnload {
    [self setTextViewCollection:nil];
    [self setUiLabelCollection:nil];
    [self setButton:nil];
    [super viewDidUnload];
}
@end
