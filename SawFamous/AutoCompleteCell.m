//
//  AutoCompleteCell.m
//  CheckMate
//
//  Created by Şeyma Tanoğlu on 2/8/12.
//  Copyright (c) 2012 NILACCRA. All rights reserved.
//

#import "AutoCompleteCell.h"

@implementation AutoCompleteCell

-(User*)getCurrentUser {
    return (User*)self.currentEntity;
}

@end
