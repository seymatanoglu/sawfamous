//
//  TwitterUser.h
//  SawFamous
//
//  Created by seytan on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"

@interface User : Entity { 
    NSString *profileImageUrl; //profile_image_url_https // profile_image_url
    NSString*screenName;
    NSString *url;
    NSString *description;
    BOOL isProtected;
    int followersCount;
    BOOL verified;
}
@property (nonatomic, retain) NSString *profileImageUrl; 
@property (nonatomic, retain) NSString*screenName;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *description;
@property BOOL isProtected;
@property int followersCount;
@property BOOL verified;
@end
