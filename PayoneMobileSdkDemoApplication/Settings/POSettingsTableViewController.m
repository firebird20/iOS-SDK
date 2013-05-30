//
//  POSettingsTableViewController.m
//  Payone App
//
//  Created by Rainer Grinninger on 05.02.13.
//
//

#import "POSettingsTableViewController.h"
#import "PayoneSDKSettingsCell.h"
#import "PayoneSDKSettingsLabelCell.h"
#import "PayoneSettingsVo.h"
#import "PayoneSettingsManager.h"
#import "PasswordViewController.h"
#import "PayoneCustomUISettingsManager.h"


@interface POSettingsTableViewController (private)

@end

@implementation POSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void) dealloc
{
    self.data = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.data = [[PayoneSettingsManager getInstance] readSettingsData];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Keyboard

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.data objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayoneSettingsVo* settingsVo = [[self.data objectAtIndex:indexPath.section] objectAtIndex: indexPath.row];
    
    NSString *CellIdentifier = @"SettingsLabelCellGeneral";   

    if(indexPath.section == 1)
        CellIdentifier = @"SettingsLabelCell";
    if(indexPath.section == 2)
        CellIdentifier = @"SettingsLabelCellSwitch";
    if(indexPath.section == 3)
        CellIdentifier = @"SettingsLabelCellSwitch";
    if(indexPath.section == 4)
        CellIdentifier = @"changePasswordCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    if([cell isKindOfClass:[PayoneSDKSettingsCell class]])
    {
        if([settingsVo respondsToSelector:@selector(title)])
        {
            ((PayoneSDKSettingsCell*) cell).labelHeadline.text = settingsVo.title;
            ((PayoneSDKSettingsCell*) cell).textField.placeholder = settingsVo.value;
            ((PayoneSDKSettingsCell*) cell).textField.delegate = self;
            ((PayoneSDKSettingsCell*) cell).textField.tag = indexPath.row;
        }
    }
    if ([cell isKindOfClass:[PayoneSettingsSwitchCell class]])
    {
        if([settingsVo respondsToSelector:@selector(title)])
        {
            ((PayoneSettingsSwitchCell*) cell).labelHeadline.text = settingsVo.title;
            [((PayoneSettingsSwitchCell*) cell).uiSwitch setOn:[settingsVo.value boolValue]];
            ((PayoneSettingsSwitchCell*) cell).delegate = self;
            ((PayoneSettingsSwitchCell*) cell).indexPath = indexPath;
        }
    }
    if ([cell isKindOfClass:[PayoneSDKSettingsLabelCell class]])
    {
        if([settingsVo respondsToSelector:@selector(title)])
        {
            ((PayoneSDKSettingsLabelCell*) cell).labelHeadline.text = settingsVo.title;
            ((PayoneSDKSettingsLabelCell*) cell).labelDescription.text = [PayoneSettingsManager getInstance].getCurrency;
            ((PayoneSDKSettingsLabelCell*) cell).labelHeadline.backgroundColor = [UIColor whiteColor];
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if(section == 0)
//        return 33;
    return 33;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect headerViewRect = CGRectMake(0,0.0,320,30);
    UIView* headerView = [[UIView alloc] initWithFrame:headerViewRect];
    headerView.backgroundColor =  [[PayoneCustomUISettingsManager sharedInstance] colorWithHexString:@"023A5B"] ;

    UILabel* label = [[UILabel alloc] initWithFrame:headerViewRect];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    
    if (section == 0)
        label.text = @"Persönliche Daten";
    if (section == 1)
        label.text = @"Währung";
    if (section == 2)
        label.text = @"Betriebsmodus";
    if (section == 3)
        label.text = @"Aktivierte Zahlarten";
    if (section == 4)
        label.text = @"Passwort";
    
    label.frameX = 10;
    label.textColor = [UIColor whiteColor];

        return headerView;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    UIViewController* viewController;
    
    if(indexPath.section == 1)
    {
        // show picker view
    }
    else if(indexPath.section == 4)
    {        
        PasswordViewController* passwordViewController = (PasswordViewController*) [mainStoryboard instantiateViewControllerWithIdentifier:@"passwordController"];
        passwordViewController.type = PasswordInterfaceTypeChange;
        viewController = passwordViewController;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)switchActionValueChanged:(id)sender indexPath:(NSIndexPath*) indexPath
{
    UISwitch* switchUI = (UISwitch*) sender;
    NSString* boolString = @"0";
    
    // set value
    if(switchUI.isOn)
        boolString = @"1";
    
    if(indexPath.section == 2)
    {
        PayoneSettingsVo* vo = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        vo.value = boolString;
        [[PayoneSettingsManager getInstance] savePaymentMode:vo];
    }
    else
    {
        // getPaymentSettingsObject
        NSMutableArray* array = [NSMutableArray arrayWithArray:[self.data objectAtIndex:indexPath.section]];
        PayoneSettingsVo* vo = [array objectAtIndex:indexPath.row];
        vo.value = boolString;
        
        [array removeObjectAtIndex:indexPath.row];
        [array insertObject:vo atIndex:indexPath.row];
        
        // save object
        [[PayoneSettingsManager getInstance] savePaymentSettings:array];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //
}

// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    int rowIndex = textField.tag;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    if(rowIndex == 0)
    {
        [PayoneSettingsManager getInstance].mid = textField.text;
    }
    if(rowIndex == 1)
    {
        [PayoneSettingsManager getInstance].portalId   = textField.text;
    }
    if(rowIndex == 2)
    {
        [PayoneSettingsManager getInstance].subAccountId = textField.text;
    }
    if(rowIndex == 3)
    {
        [PayoneSettingsManager getInstance].key = textField.text;
    }
    return YES;
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // persist values
    [[PayoneSettingsManager getInstance]savePayoneSettings];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:nextTag inSection:0];
    PayoneSDKSettingsLabelCell* cell = (PayoneSDKSettingsLabelCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    // Try to find next responder
    UIResponder* nextResponder = [cell viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showChangePasswordController"])
    {
        
    }
    else
    {
        ((PayoneDetailPickerViewController*) segue.destinationViewController).pickerData = [PayoneSettingsManager getInstance].getCurrencyLocaValues;
        ((PayoneDetailPickerViewController*) segue.destinationViewController).delegate = self;
    }
}

-(void) pickerDidSelectItem:(int) index withTitle:(NSString*) title
{
    PayoneSDKSettingsLabelCell* labelCell = (PayoneSDKSettingsLabelCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    labelCell.labelDescription.text = title;
    [[PayoneSettingsManager getInstance] setCurrency:title];
}

@end
