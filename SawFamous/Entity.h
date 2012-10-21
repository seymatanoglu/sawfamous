//
//  Entity.h
//  SawFamous
//
//  Created by seytan on 10/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entity : NSObject {
    int ID;
    NSString *name;
}
@property (nonatomic, retain)NSString *name;
@property int ID;
@end
