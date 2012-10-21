//
//  Configuration.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

+(NSString*) getUserAuthenticationUrl {
    return @"http://sawfamo.us/users.json";
}

+(NSString*) getNearByVenuesUrl:(NSString*)latitude withLongitude:(NSString*)longitude {
    return [NSString stringWithFormat:@"http://sawfamo.us/api/v1/venuelist/%@/%@.json?auth_token=%@",latitude, longitude , [self getAuthKey]];
    
}

+(NSString*)getUsersUrl:(NSString*)searchString {
   return  [NSString stringWithFormat:@"http://sawfamo.us/api/v1/famous/q/%@?auth_token=%@" ,searchString ,[self getAuthKey] ];
}

+(NSString*)getTwitterUsersUrl:(NSString*)searchString {
    return [NSString stringWithFormat:@"http://sawfamo.us/api/v1/famous/qt/%@?auth_token=%@" ,searchString ,[self getAuthKey] ];
}

+(NSString*) getConsumerKey {
    return @"7rv7VNyfXTAAjalj8aASQ";
}

+(NSString*) getConsumerSecret {
    return @"efEMMx3FTBAS0QvsY2l64UyhvkJEaNkjlUnG4vDIs";
}

+(NSString*) getAuthKey {
    NSString *authenticationKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"authKey"];
    if (!authenticationKey) authenticationKey=@"";
    return authenticationKey;
}

@end
