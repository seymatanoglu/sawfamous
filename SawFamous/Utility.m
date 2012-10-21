//
//  Utility.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
#define defaultDateFormat @"yyyyMMdd"

@implementation Utility

+(void) showNoConnectionMessage {
    [self showMessage:@"İnternet bağlantınızı kontrol ediniz." title:@"Bağlantı hatası"];
}

+(void) showMessage:(NSString *)message title:(NSString *)title{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[self getWord:title] message:[self getWord:message] delegate:self cancelButtonTitle:[self getWord:@"Tamam"]otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

+(NSString*) getWord:(NSString*)key{ 
    //write some code for language options
    return key;
}

+(NSDate *) getDate:(NSString *)value {
    return [self getDate:value withFormat:defaultDateFormat];
}

+(NSDate *) getDate:(NSString *)value withFormat: (NSString *) format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];   
    NSDate *returnValue = [formatter dateFromString:value];
    [formatter release];
    return returnValue;    
}

+(NSString *) getDateString: (NSDate *) value{
    return  [self getDateString:value withFormat:@"yyyyMMdd"];
}

+(NSString *) getDateString: (NSDate *) value withFormat: (NSString *) format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];  
    NSString *returnValue = [formatter stringFromDate:value];
    [formatter release];
    return returnValue;    
}


+ (NSString *)getCurrentDeviceModel {  
	size_t size;  
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);  
	char *machine = malloc(size);  
	sysctlbyname("hw.machine", machine, &size, NULL, 0);  
    
	NSString *deviceModel = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
	free(machine);
	
	return deviceModel;  
}

+(void)setUserInfo:(NSString*)username password:(NSString*)pass {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![username isEqualToString:@""] && ![pass isEqualToString:@""]) {
        [defaults setObject:username forKey:@"UserName"];
        [defaults setObject:pass forKey:@"Password"];
    }
	else {
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    }
	[defaults synchronize];
}

+(NSString*) getUserName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"UserName"]) {
        return [defaults objectForKey:@"UserName"];
    }
    return @"";
}

+(NSString*) getPassword {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Password"]) {
        return [defaults objectForKey:@"Password"];
    }
    return @"";
}

+(int) getSelectedType {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:@"SelectedType"] intValue];
}

+(void)setSelectedType:(int)type{
    if (type > 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSString stringWithFormat:@"%i", type] forKey:@"SelectedType"];
        [defaults synchronize];
    }
}

+(UIColor*) getColorForRgb:(float)red withGreen:(float)green withBlue:(float)blue {
    return [UIColor colorWithRed:(float)red/255.0  green:(float)green/255.0  blue:(float)blue/255.0 alpha:1.0];
}

+(NSString *)getMonthName:(int)index
{
    if (index>12)  index = index%12;
    NSArray *months = [[[NSArray alloc] initWithObjects:@"",@"Ocak",@"Şubat",@"Mart",@"Nisan",
                        @"Mayıs",@"Haziran",@"Temmuz",@"Ağustos",@"Eylül",@"Ekim",@"Kasım",
                        @"Aralık",@"Ocak",nil] autorelease];
    
    return [months objectAtIndex:(int)index];
    
}

@end
