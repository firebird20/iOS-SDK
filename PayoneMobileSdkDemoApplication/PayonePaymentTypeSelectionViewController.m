//
//  PayonePamentTypeSelectionViewController.m
//  Payone App
//
//  Created by Rainer Grinninger on 18.02.13.
//
//

#import "PayonePaymentTypeSelectionViewController.h"
#import "PayoneSettingsManager.h"
#import "PayoneRequestFactory.h"
#import "PaymentDetailsBaseViewController.h"
#import "PayoneCustomUISettingsManager.h"

@interface PayonePaymentTypeSelectionViewController ()

@end

@implementation PayonePaymentTypeSelectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void) loadView
{
    [super loadView];
    self.title = NSLocalizedString(@"kPaymentTypeSelectionInput", nil);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.data = [[PayoneSettingsManager getInstance] getSelectedPaymentTypes];
}

- (void) updateBackgroundImage
{
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[PayoneCustomUISettingsManager backgroundImage]];

    imageView.bounds = self.tableView.bounds;
    imageView.frameX = 0;
    imageView.frameY = 0;
    [self.tableView.backgroundView addSubview:imageView];
    self.tableView.backgroundView.backgroundColor = [UIColor yellowColor];
    self.tableView.backgroundView = imageView;
    [imageView release];
}

- (void)viewDidUnload {

    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.tableView.scrollEnabled = NO;
    
    [self updateBackgroundImage];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PaymentTypeSelectionCell";
    PaymentTypeSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PayoneSettingsVo* vo = [self.data objectAtIndex:indexPath.row];
    cell.delegate = self;

    cell.button.titleLabel.text = vo.title;
    [cell.button setTitle:vo.title forState:UIControlStateNormal];
    [cell.button setTitleColor:[PayoneCustomUISettingsManager sharedInstance].textColor forState:UIControlStateNormal];

    return cell;
}

-(void) buttonTouched: (id) sender
{
    UIButton* button = (UIButton*) sender;
    NSString* selection = button.titleLabel.text;
    
    // save payment option for summary
    [PayoneSettingsManager getInstance].selectedPaymentType = selection;
    
    // debit
    if([button.titleLabel.text isEqualToString:NSLocalizedString(@"kSettingsDebit", nil)])
    {
        // continue to debit details
        [self performSegueWithIdentifier:@"showDebitDetails" sender:self];
    }
    // credicard 
    else if([[PayoneSettingsManager getInstance].getSupportedCreditCardsLocaValues containsObject:selection])
    {
        NSString* credicardType = [PayoneSettingsManager getInstance].getCreditcards[selection];
        [self.requestParams addKey:PayoneParameters_CARDTYPE  withValue: credicardType];
        
        // continue to credicard details
        [self performSegueWithIdentifier:@"showCreditcardDetails" sender:self];
    }
    // invoice
    else if([button.titleLabel.text isEqualToString:NSLocalizedString(@"kSettingsInvoice", nil)])
    {
        // continue to invoice details
        [self performSegueWithIdentifier:@"showBillingController" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((PaymentDetailsBaseViewController*) segue.destinationViewController).requestParams = self.requestParams;
}

@end
