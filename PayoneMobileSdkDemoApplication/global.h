//
//  global.h
//  PayoneMobileSdkDemoApplication
//
//  Created by Rainer Grinninger on 21.08.12.
//  Copyright (c) 2012 Exozet. All rights reserved.
//


#define kAppPassword @"password"
#define kPayoneSettingsUserDefaults @"payoneSettingsUserDefaultsKey"
#define kPayoneSettingsLiveModeKey @"payoneSettingsLiveModeKey"
#define kCreditcardTitles @"creditCardTitles"
#define kCreditcardValues @"creditCardValues"

#define kSettingsCurrency @"kSettingsCurrency"
#define kPaymentSettings @"kPaymentSettings"

#define kUpdateBackgroundImageNotification @"kUpdateBackgroundImageNotification"


//// LOGGER
////////////
static int sRunCounter = 0;


// we are logging to file, set nil if you don't want to log to file
#define LOG_TO_FILE nil
//[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/debug.log"]

// maximum file size of the log file in MB
#define LOG_TO_FILE_MAX_SIZE 50

#define LOG_MESSAGE(title, text, ...)  {NSString* logString = [NSString stringWithFormat:@"%@ (%d) - <%p>[%@ %@]: %@",												\
[[NSString stringWithUTF8String:__FILE__] lastPathComponent],																		\
__LINE__ ,																															\
self,																																\
NSStringFromClass([self class]),																									\
NSStringFromSelector(_cmd),																											\
[NSString stringWithFormat:(text), ##__VA_ARGS__ ]																					\
];																																	\
CFShow(logString);																													\
if (LOG_TO_FILE != nil) {                                                                                                           \
sRunCounter = [[[NSUserDefaults standardUserDefaults] objectForKey:@"runCount"] intValue];                                      \
NSString* file = [NSString stringWithFormat:@"%@%i", LOG_TO_FILE, sRunCounter];                                                  \
if (![[NSFileManager defaultManager] fileExistsAtPath:file]) {															\
[[NSFileManager defaultManager] createFileAtPath:file contents:nil attributes:nil];									\
}																																\
NSFileHandle* fileHandle = [NSFileHandle fileHandleForWritingAtPath:file];												\
unsigned long long size = [fileHandle seekToEndOfFile];																			\
if (size/1024/1024 < LOG_TO_FILE_MAX_SIZE)																						\
{																																\
[fileHandle writeData:[[NSString stringWithFormat:@"%@ \n",logString] dataUsingEncoding:NSUTF8StringEncoding]];				\
[fileHandle synchronizeFile];																								\
}																																\
[fileHandle closeFile];																											\
}}



#ifdef LOG_LEVEL
#define LogInfo( s, ... ) LOG_MESSAGE(@"LOG-INFO",s , ##__VA_ARGS__)
#else
#define LogInfo( s, ... )
#endif

#if LOG_LEVEL >= 1
#define LogWarning( s, ... ) LOG_MESSAGE(@"LOG-WARNING",s , ##__VA_ARGS__)
#else
#define LogWarning( s, ... )
#endif

#if LOG_LEVEL >= 2
#define LogError( s, ... ) LOG_MESSAGE(@"LOG-ERROR",s , ##__VA_ARGS__)
#else
#define LogError( s, ... )
#endif

#if LOG_LEVEL >= 3
#define LogDebug( s, ... ) LOG_MESSAGE(@"LOG-DEBUG",s , ##__VA_ARGS__)
#else
#define LogDebug( s, ... )
#endif


