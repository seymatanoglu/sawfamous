//
//  BaseCell.h
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Entity.h"
#import "SimpleLabel.h"
#import "Utility.h"

@interface BaseCell : UITableViewCell {
    Entity *currentEntity;
    NSMutableArray*parentCollection;
    UIViewController *delegate;
    int index;
}
@property (nonatomic, assign)Entity *currentEntity;
@property (nonatomic, assign)NSMutableArray*parentCollection;
@property (nonatomic, assign)UIViewController *delegate;
@property int index;

- (id)initWithEntity:(Entity*)entity index:(int)_index 
     reuseIdentifier:(NSString *)reuseIdentifier parentCollection:(NSMutableArray*) collection parentView:(UIViewController*) parent ;
-(void) drawCell;
@end
