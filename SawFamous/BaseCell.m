//
//  BaseCell.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell
@synthesize currentEntity, parentCollection, index, delegate;

- (id)initWithEntity:(Entity*)entity index:(int)_index reuseIdentifier:(NSString *)reuseIdentifier parentCollection:(NSMutableArray*) collection parentView:(UIViewController*) parent {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.parentCollection= collection;
        self.index=_index;
        self.currentEntity = entity;
        self.delegate = parent;
        [self drawCell];
    }
    return self;
}

-(void) drawCell{
    self.textLabel.text = self.currentEntity.name;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.text = self.currentEntity.name;
}

@end

