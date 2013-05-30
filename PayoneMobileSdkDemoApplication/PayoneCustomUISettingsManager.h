//
//  PayoneUISettingsManager.h
//  Payone App
//
//  Created by Rainer Grinninger on 14.11.12.
//
//

#import <Foundation/Foundation.h>

@interface PayoneCustomUISettingsManager : NSObject

+(PayoneCustomUISettingsManager*) sharedInstance;
+(UIColor*)backgroundColor;
+(UIColor*)textColor;
+(UIImage*)backgroundImage;
+(NSString*)backgroundImagePath;
+(UIColor*)navigationBarColor;

-(void) persistValue: (id) value forKey:(NSString*) key;
-(id) getValueForKey:(NSString*) key;
-(BOOL) isSetImageMode;
-(void) setImage:(UIImage*) image withPath:(NSURL*)path;
-(void) switchOffUserDefaultsButton;;

@property (nonatomic, readonly) NSURL* bgImagePath;
@property (nonatomic, readonly) UIColor* bgColor;
@property (nonatomic, readonly) UIColor* navigationBarColor;
@property (nonatomic, readonly) UIColor* textColor;
@property (nonatomic, readonly) UIImage* bgImage;
@property (nonatomic, readonly) NSUserDefaults* userDefaults;
@property (nonatomic, retain) UIImage* image;

-(UIColor*)colorWithHexString:(NSString*)hex;


//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
//#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
//colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
//green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
//blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


@end
