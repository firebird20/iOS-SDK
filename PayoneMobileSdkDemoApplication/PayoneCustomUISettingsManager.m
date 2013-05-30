//
//  PayoneUISettingsManager.m
//  Payone App
//
//  Created by Rainer Grinninger on 14.11.12.
//
//

#import "PayoneCustomUISettingsManager.h"



#define kBackgroundImagePlistKey @"kBackgroundImagePlistKey"
#define kBackgroundImagePath @"kBackgroundImagePath"
#define kEncodedImageDataKey @"kEncodedImageDataKey"
#define kBackgroundColor @"kBackgroundColor"
#define kTextColor @"kTextColor"
#define kNavigationBarTitleColor @"kNavigationBarTitleColor"

@interface PayoneCustomUISettingsManager (private)

-(void) sendNotification;

@end

@implementation PayoneCustomUISettingsManager

static PayoneCustomUISettingsManager* instance = NULL;

+ (PayoneCustomUISettingsManager*) sharedInstance
{
	@synchronized(self)
	{
		if (instance == nil)
        {
			instance = [[PayoneCustomUISettingsManager alloc] init];
            // FOR TEST PURPOSES 
//            [instance persistValue:@"1" forKey:kBackgroundImagePlistKey];
        }

	}
	return instance;
}


+(UIColor*)navigationBarColor
{
    return [PayoneCustomUISettingsManager sharedInstance].navigationBarColor;
}

+(UIColor*)backgroundColor
{
    return [PayoneCustomUISettingsManager sharedInstance].bgColor;
}

+(UIColor*)textColor
{
    return [PayoneCustomUISettingsManager sharedInstance].textColor;
}

+(NSURL*)backgroundImagePath
{
    return [PayoneCustomUISettingsManager sharedInstance].bgImagePath;
}

+(UIImage*)backgroundImage
{
    return [PayoneCustomUISettingsManager sharedInstance].bgImage;
}

#pragma mark UI Settings Properties
#pragma mark

-(void) switchOffUserDefaultsButton
{
    [self persistValue:@"0" forKey:kBackgroundImagePlistKey];
}

-(NSURL*) bgImagePath
{
    NSURL* path = [self getValueForKey:kBackgroundImagePath];
    return path;
}

-(UIColor*) bgColor
{
    if(![self getValueForKey:kBackgroundColor])
    {
        [self persistValue:kPayoneDefaultBackgroundColor forKey:kBackgroundColor];
    }
    NSString* colorString = [self getValueForKey:kBackgroundColor] ;
    UIColor* color = [self colorWithHexString:colorString];

    return color;
}

-(UIColor*) textColor
{
    if(![self getValueForKey:kTextColor])
    {
        [self persistValue:kPayoneDefaultTextColor forKey:kTextColor];
    }
    NSString* colorString = [self getValueForKey:kTextColor];
    UIColor* color = [self colorWithHexString:colorString];
    return color;
}

-(UIColor*) navigationBarColor
{    
    if(![self getValueForKey:kNavigationBarTitleColor])
    {
        [self persistValue:kPayoneDefaultTextColor forKey:kNavigationBarTitleColor];
    }
    NSString* colorString = [self getValueForKey:kNavigationBarTitleColor] ;
    UIColor* color = [self colorWithHexString:colorString];
    return color;
}

#pragma mark Image Data
#pragma mark

-(UIImage*) bgImage
{    
    NSData* encodedImageData = [self.userDefaults dataForKey:kEncodedImageDataKey];
    UIImage* image = [UIImage imageWithData:encodedImageData];
    
    if(!image)
    {
       image = [UIImage imageNamed:@"backgroundDefault.png"];
    }
    return image;
}

-(BOOL) isSetImageMode
{
    BOOL setImage = [[self getValueForKey:kBackgroundImagePlistKey] boolValue];
    return setImage;
}

-(void) setImage:(UIImage*) image withPath:(NSURL*)path
{
    NSData* imageData = UIImagePNGRepresentation(image);
    [self.userDefaults setObject:imageData forKey:kEncodedImageDataKey];
    
    [self persistValue:0 forKey:kBackgroundImagePlistKey];
    [self performSelector:@selector(sendNotification) withObject:nil afterDelay:0];
}

-(void) sendNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName: kUpdateBackgroundImageNotification object:nil userInfo:nil];    
}


#pragma mark User Defaults
#pragma mark 

-(void) persistValue: (id) value forKey:(NSString*) key
{
    [self.userDefaults setValue:value forKey:key];
    [self.userDefaults synchronize];
}

-(id) getValueForKey:(NSString*) key
{
    return [self.userDefaults objectForKey:key];
}

-(NSUserDefaults*) userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}


-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
