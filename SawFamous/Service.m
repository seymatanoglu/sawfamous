//
//  Service.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Service.h"
#import "Reachability.h"
#import "Configuration.h"
#import "Utility.h"
#import "JSON.h"
#import "Venue.h"

@implementation Service

static User *currentUser = nil;
static NSMutableArray* twitterUsers, *nearByVenues;
static NSString* twitterUsersString;

+ (BOOL)isConnected 
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];  
    NetworkStatus networkStatus = [reachability currentReachabilityStatus]; 
    return !(networkStatus == NotReachable);
}

+ (User *)getCurrentUser {
    return currentUser;
}

+ (void)setCurrentUser:(User*)user {
    currentUser = user;
}

+(BOOL) authenticate:(NSString*) userName {
    if (currentUser==nil ) {
        currentUser= [self login:userName];
        if (currentUser==nil) {
            return NO;
        }  
    }
    return YES;
}

+(User *)login:(NSString*)userName{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *userJSON = @"{";
    userJSON = [userJSON stringByAppendingString:@"\"user\":"];
    userJSON = [userJSON stringByAppendingString:@"{"];
    userJSON = [userJSON stringByAppendingString:@"\"profile_attributes\":"];
    userJSON = [userJSON stringByAppendingString:@"{"];
    userJSON = [userJSON stringByAppendingString:@"\"twitter\":"];
    userJSON = [userJSON stringByAppendingString:@"\""];
    userJSON = [userJSON stringByAppendingString:userName];
    userJSON = [userJSON stringByAppendingString:@"\""];
    userJSON = [userJSON stringByAppendingString:@"}"];
    userJSON = [userJSON stringByAppendingString:@"}"];
    userJSON = [userJSON stringByAppendingString:@"}"];
    
    NSDictionary* dictionary = [[self postUrlResult:[Configuration getUserAuthenticationUrl] withBody:userJSON] JSONValue];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *authenticationKey = [dictionary objectForKey:@"authentication_token"];
    NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
    if (authenticationKey.length>0) {
        [defaults setObject:authenticationKey forKey: @"authKey"];
        User*user = [[User alloc] init];
        user.screenName = userName;
        return user;
    }
    else 
        [defaults setObject:nil forKey: @"authData"];
    [defaults synchronize];
    return nil;
}

+(NSMutableArray*)getUsers:(NSString*) searchString{
    searchString = [self urlEncode:searchString];
    if (searchString.length>2) {
        twitterUsersString = @"";
        twitterUsers = [[NSMutableArray alloc] init];
        NSDictionary *results = [[self getUrlResult:[Configuration getUsersUrl:searchString]] JSONValue]; 
        for (NSDictionary*dict in results) {
            User* user = [[User alloc] init];
            user.name = [dict objectForKey:@"name"];
            user.ID = [[dict objectForKey:@"id"] intValue];
            user.profileImageUrl = [dict objectForKey:@"twitter_picture"];
            if (![user.profileImageUrl respondsToSelector:@selector(stringByAppendingString:) ]) {
                user.profileImageUrl = @"";
            }
            user.screenName = [dict objectForKey:@"twitter"];
            
            twitterUsersString=[[twitterUsersString stringByAppendingString:user.name] retain];
            twitterUsersString=[[twitterUsersString stringByAppendingString:@"\n"] retain];
            //NSLog(@"retincount 1 %i", twitterUsersString.retainCount);
            [twitterUsers addObject:user];
        }
    }
    return twitterUsers;
}


+(NSMutableArray*)getTwitterUsers:(NSString*)searchString {
    searchString = [self urlEncode:searchString];
    if (searchString.length>2) {
        twitterUsers = [[NSMutableArray alloc] init];
        NSDictionary *results = [[self getUrlResult:[Configuration getTwitterUsersUrl:searchString]] JSONValue]; 
        for (NSDictionary*dict in results) {
            User* user = [[User alloc] init];
            user.name = [dict objectForKey:@"name"];
            user.ID = [[dict objectForKey:@"id"] intValue];
            user.profileImageUrl = [dict objectForKey:@"twitter_picture"];
            if (![user.profileImageUrl respondsToSelector:@selector(stringByAppendingString:) ]) {
                user.profileImageUrl = @"";
            }
            user.screenName = [dict objectForKey:@"twitter"];
            [twitterUsers addObject:user];
        }
    }
    return twitterUsers;
}

+(NSString *)urlEncode:(NSString *)str
{
    NSString *result  = [str stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    result =  (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("#[]@!$’()*+,;”"), kCFStringEncodingUTF8);
    return [result autorelease];
}

+ (NSMutableArray*)getNearByVenues{
    if (!nearByVenues) {
         NSDictionary *results = [[self getUrlResult:[Configuration getNearByVenuesUrl:@"40.792458"  withLongitude:@"29.467149000000063"]] JSONValue]; 
        nearByVenues = [[NSMutableArray alloc] init];
        for (NSDictionary*dict in results) {
            Venue *venue = [[Venue alloc] init];
            venue.ID = [[dict objectForKey:@"id"] intValue];
            venue.name = [dict objectForKey:@"name"];
            venue.latitude = [dict objectForKey:@"lat"];
            venue.longitude = [dict objectForKey:@"lng"];
            [nearByVenues addObject:venue];
        }
    }
    return nearByVenues;
}

+(NSString*)postUrlResult:(NSString*)urlString withBody:(NSString*)body{
    NSURL *url = [NSURL URLWithString:urlString ];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:[body  dataUsingEncoding:NSUTF8StringEncoding]];
    NSError* error=nil;
     NSURLResponse* response=nil;
    NSData* resp = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *receivedString = [[NSString alloc]initWithData:resp encoding:NSUTF8StringEncoding];
    NSLog(@"sunucu cevabı : %@",receivedString);
     [receivedString autorelease];
    return  receivedString;
}

+(NSString*)getUrlResult:(NSString*)urlString {
    NSURLRequest *theRequest  = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0]; 
    NSError* error=nil;
     NSURLResponse* response=nil;
    NSData* resp = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    NSString *receivedString = [[NSString alloc]initWithData:resp encoding:NSUTF8StringEncoding];
    NSLog(@"sunucu cevabı : %@",receivedString);
    [receivedString autorelease];
    return receivedString;
}
@end
