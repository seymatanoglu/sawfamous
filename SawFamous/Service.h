//
//  Service.h
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Service : NSObject
+ (BOOL)isConnected;

+ (User *)getCurrentUser;
+ (void)setCurrentUser:(User*)user;

+(NSMutableArray*)getUsers:(NSString*) searchString;
+(NSMutableArray*)getTwitterUsers:(NSString*)searchString ;

+ (NSMutableArray*)getNearByVenues;
+(BOOL) authenticate:(NSString*) userName;
+(User *)login:(NSString*)userName;

+(NSString*)postUrlResult:(NSString*)urlString withBody:(NSString*)body;
+(NSString*)getUrlResult:(NSString*)urlString ;
+(NSString *)urlEncode:(NSString *)str;
@end
