//
//  Utility.h
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+(void) showNoConnectionMessage;
+(void) showMessage:(NSString *)message title:(NSString *)title;
+(NSString*) getWord:(NSString*)key;

+(NSDate *) getDate:(NSString *)value;
+(NSDate *) getDate:(NSString *)value withFormat: (NSString *) format;
+(NSString *) getDateString: (NSDate *) value;
+(NSString *) getDateString: (NSDate *) value withFormat: (NSString *) format;

+ (NSString *)getCurrentDeviceModel;

+(void)setUserInfo:(NSString*)username password:(NSString*)pass;
+(NSString*) getPassword;
+(NSString*) getUserName;
+(int) getSelectedType;
+(void)setSelectedType:(int)type;
+(UIColor*) getColorForRgb:(float)red withGreen:(float)green withBlue:(float)blue;
+(NSString *)getMonthName:(int)index;
@end
