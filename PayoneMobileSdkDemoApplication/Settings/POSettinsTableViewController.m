//
//  POSettinsTableViewController.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 22.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "POSettinsTableViewController.h"
#import "SettingsVo.h"
#import "PayoneSettings.h"
#import "PasswordViewController.h"

@interface POSettinsTableViewController ()

@end

@implementation POSettinsTableViewController
@synthesize settingsData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self readSettings];
}

- (void)viewDidUnload
{
    self.settingsData = nil;
    [super viewDidUnload];

}

-(void) readSettings
{
    NSMutableArray* settings = [[[NSMutableArray alloc] init] autorelease];    
    
    SettingsVo* settingsMid = [[[SettingsVo alloc] init]autorelease];
    settingsMid.type = POSettingsDefTypeMid;
    settingsMid.name = NSLocalizedString(@"kSettingsMid" , nil);
    settingsMid.title = NSLocalizedString(@"kSettingsMid" , nil);
    settingsMid.value = [PayoneSettings getInstance].mid;
    [settings addObject:settingsMid];
    
    SettingsVo* settingsPortalId = [[[SettingsVo alloc] init]autorelease];
    settingsPortalId.type = POSettingsDefTypePortalId;
    settingsPortalId.name =NSLocalizedString(@"kSettingsPortalId" , nil);
    settingsPortalId.title =NSLocalizedString(@"kSettingsPortalId" , nil);
    settingsPortalId.value = [PayoneSettings getInstance].portalId;    
    [settings addObject:settingsPortalId];
    
    SettingsVo* settingsSubAccount = [[[SettingsVo alloc] init]autorelease];
    settingsSubAccount.type = POSettingsDefTypeSubAccoountId;
    settingsSubAccount.name = NSLocalizedString(@"kSettingsSubAccount" , nil);
    settingsSubAccount.title = NSLocalizedString(@"kSettingsSubAccount" , nil);
    settingsSubAccount.value = [PayoneSettings getInstance].subAccountId;    
    [settings addObject:settingsSubAccount];
    
    SettingsVo* settingsKey = [[[SettingsVo alloc] init]autorelease];
    settingsKey.type = POSettingsDefTypeKey;
    settingsKey.name = NSLocalizedString(@"kSettingsKey" , nil);
    settingsKey.title = NSLocalizedString(@"kSettingsKey" , nil);
    settingsKey.value = [PayoneSettings getInstance].key;    
    [settings addObject:settingsKey];
    
    SettingsVo* settingsPassword = [[[SettingsVo alloc] init]autorelease];
    settingsPassword.type = POSettingsDefTypePassword;
    settingsPassword.name = NSLocalizedString(@"kSettingsPassword" , nil);
    settingsPassword.title = NSLocalizedString(@"kSettingsPassword" , nil);
    [settings addObject:settingsPassword];
    
    self.settingsData = settings;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.settingsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"settingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    SettingsVo* settingsVo = [self.settingsData objectAtIndex:indexPath.row]; 
    cell.textLabel.text = settingsVo.title;
    cell.detailTextLabel.text = settingsVo.value;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                             bundle: nil];
    SettingsVo* settingsVo = [self.settingsData objectAtIndex:indexPath.row];    
    UIViewController* viewController;
    
    if(settingsVo.type != POSettingsDefTypePassword) 
    {
        SettingsViewController* settingsViewController = (SettingsViewController*) [mainStoryboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
        settingsViewController.delegate = self;
        settingsViewController.type = settingsVo.type;
        settingsViewController.title = settingsVo.title;
        
        NSLog(@"type  : %i ", settingsViewController.type);
        
        NSString* currentValue = settingsVo.value;
        settingsViewController.currentValue = currentValue;
        viewController = settingsViewController;
        [self.navigationController presentModalViewController:viewController animated:YES];
    }
    else
    {
        PasswordViewController* passwordViewController = (PasswordViewController*) [mainStoryboard instantiateViewControllerWithIdentifier:@"passwordController"];
        passwordViewController.type = PasswordInterfaceTypeChange;
        viewController = passwordViewController;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}


-(void) valueDidChange:(NSString*) value forTag:(POSettingsDefType) type
{
    NSLog(@"valueDidChange: %@ ", value);
    switch (type) 
    {
        case POSettingsDefTypeMid:
            NSLog(@" valueDid change Mid ");
            [PayoneSettings getInstance].mid = value;
            break;
        case POSettingsDefTypePortalId:
            NSLog(@" valueDid change Mid ");
            [PayoneSettings getInstance].portalId = value;
            break;  
        case POSettingsDefTypeSubAccoountId:
            NSLog(@" valueDid change Mid ");
            [PayoneSettings getInstance].subAccountId = value;
            break;
        case POSettingsDefTypeKey:
            NSLog(@" valueDid change Mid ");
            [PayoneSettings getInstance].key = value;
            break;  
        default:
            break;
    }
    [self readSettings];
    [self.tableView reloadData];
    [[PayoneSettings getInstance]savePayoneSettings];
    [self.modalViewController dismissModalViewControllerAnimated:YES];
}


@end
