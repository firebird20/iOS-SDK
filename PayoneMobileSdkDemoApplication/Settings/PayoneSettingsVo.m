//
//  SettingsVo.m
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 22.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//

#import "PayoneSettingsVo.h"



@implementation PayoneSettingsVo 


#define SettingsNameKey @"SettingsNameKey"
#define SettingsTitleKey @"SettingsTitleKey"
#define SettingsValueKey @"SettingsValueKey"
#define SettingsTypeKey @"SettingsTypeKey"
#define SettingsCellClass @"SettingsCellClass"

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self)
    {
        self.name = [decoder decodeObjectForKey:SettingsNameKey];
        self.value = [decoder decodeObjectForKey:SettingsValueKey];
        self.title = [decoder decodeObjectForKey:SettingsTitleKey];
        self.type = [decoder decodeIntForKey:SettingsTypeKey];
        self.cellClass = [decoder decodeObjectForKey:SettingsCellClass];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:SettingsNameKey];
    [encoder encodeObject:self.value forKey:SettingsValueKey];
    [encoder encodeObject:self.title forKey:SettingsTitleKey];
    [encoder encodeInt:self.type forKey:SettingsTypeKey];
    [encoder encodeObject:self.cellClass forKey:SettingsCellClass];
    //dereferance the pointer to persist the value
}

-(void) dealloc
{
    self.name = nil;
    self.value = nil;
    self.title = nil;
    [super dealloc];
}

@end
