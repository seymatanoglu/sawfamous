//
//  Venue.h
//  SawFamous
//
//  Created by seytan on 10/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"

@interface Venue : Entity {
    NSString* latitude, *longitude;
}
@property (nonatomic, retain) NSString* latitude;
@property (nonatomic, retain) NSString* longitude;
@end
