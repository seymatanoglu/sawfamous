//
//  Configuration.h
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject

+(NSString*) getUserAuthenticationUrl;
+(NSString*)getUsersUrl:(NSString*)searchString;
+(NSString*)getTwitterUsersUrl:(NSString*)searchString;

+(NSString*) getConsumerKey;
+(NSString*) getConsumerSecret;
+(NSString*) getAuthKey;
+(NSString*) getNearByVenuesUrl:(NSString*)latitude withLongitude:(NSString*)longitude;
@end
