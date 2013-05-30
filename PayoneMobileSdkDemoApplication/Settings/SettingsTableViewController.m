//
//  POSettinsTableViewController.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 22.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "PayoneSettingsVo.h"
#import "PayoneSettingsManager.h"
#import "PasswordViewController.h"
#import "PayoneCustomUISettingsManager.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController
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
    self.tableView.backgroundColor =  [PayoneCustomUISettingsManager backgroundColor];
    [self readSettings];
//    [self updateBackgroundImage];
}

- (void)viewDidUnload
{
    self.settingsData = nil;
    [super viewDidUnload];

}

- (void) updateBackgroundImage
{
    UIView* backgroundView = self.tableView;
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[PayoneCustomUISettingsManager backgroundImage]];
    imageView.bounds = backgroundView.bounds;
    imageView.backgroundColor = [UIColor blueColor];
    imageView.frameX = 0;
    imageView.frameY = 0;
    [backgroundView insertSubview:imageView atIndex:0];
    [imageView release];
}

-(void) readSettings
{
    NSMutableArray* settings = [[[NSMutableArray alloc] init] autorelease];    
    
    PayoneSettingsVo* settingsMid = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsMid.type = POSettingsDefTypeMid;
    settingsMid.name = NSLocalizedString(@"kSettingsMid" , nil);
    settingsMid.title = NSLocalizedString(@"kSettingsMid" , nil);
    settingsMid.value = [PayoneSettingsManager getInstance].mid;
    [settings addObject:settingsMid];
    
    PayoneSettingsVo* settingsPortalId = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsPortalId.type = POSettingsDefTypePortalId;
    settingsPortalId.name =NSLocalizedString(@"kSettingsPortalId" , nil);
    settingsPortalId.title =NSLocalizedString(@"kSettingsPortalId" , nil);
    settingsPortalId.value = [PayoneSettingsManager getInstance].portalId;    
    [settings addObject:settingsPortalId];
    
    PayoneSettingsVo* settingsSubAccount = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsSubAccount.type = POSettingsDefTypeSubAccoountId;
    settingsSubAccount.name = NSLocalizedString(@"kSettingsSubAccount" , nil);
    settingsSubAccount.title = NSLocalizedString(@"kSettingsSubAccount" , nil);
    settingsSubAccount.value = [PayoneSettingsManager getInstance].subAccountId;    
    [settings addObject:settingsSubAccount];
    
    PayoneSettingsVo* settingsKey = [[[PayoneSettingsVo alloc] init]autorelease];
    settingsKey.type = POSettingsDefTypeKey;
    settingsKey.name = NSLocalizedString(@"kSettingsKey" , nil);
    settingsKey.title = NSLocalizedString(@"kSettingsKey" , nil);
    settingsKey.value = [PayoneSettingsManager getInstance].key;    
    [settings addObject:settingsKey];
    
    PayoneSettingsVo* settingsPassword = [[[PayoneSettingsVo alloc] init]autorelease];
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
    
    PayoneSettingsVo* settingsVo = [self.settingsData objectAtIndex:indexPath.row]; 
    cell.textLabel.text = settingsVo.title;
    cell.detailTextLabel.text = settingsVo.value;
    cell.textLabel.textColor = [PayoneCustomUISettingsManager textColor];
    cell.detailTextLabel.textColor = [PayoneCustomUISettingsManager textColor];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    PayoneSettingsVo* settingsVo = [self.settingsData objectAtIndex:indexPath.row];    
    UIViewController* viewController;
    
    if(settingsVo.type != POSettingsDefTypePassword) 
    {
        SettingsDetailViewController* settingsViewController = (SettingsDetailViewController*) [mainStoryboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
        settingsViewController.delegate = self;
        settingsViewController.type = settingsVo.type;
        settingsViewController.title = settingsVo.title;

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
    switch (type) 
    {
        case POSettingsDefTypeMid:
            
            [PayoneSettingsManager getInstance].mid = value;
            break;
        case POSettingsDefTypePortalId:
            
            [PayoneSettingsManager getInstance].portalId = value;
            break;  
        case POSettingsDefTypeSubAccoountId:
            
            [PayoneSettingsManager getInstance].subAccountId = value;
            break;
        case POSettingsDefTypeKey:
            
            [PayoneSettingsManager getInstance].key = value;
            break;  
        default:
            break;
    }
    [self readSettings];
    [self.tableView reloadData];
    [[PayoneSettingsManager getInstance]savePayoneSettings];
    [self.modalViewController dismissModalViewControllerAnimated:YES];
}


@end
