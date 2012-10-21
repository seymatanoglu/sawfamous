//
//  SimpleLabel.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleLabel.h"

@implementation SimpleLabel

-(id)initWithFrame:(CGRect)frame fontSize:(int)size alignment:(int)textAlignment text:(NSString*)text{
	self = [super initWithFrame:frame];
	if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setFont:[UIFont systemFontOfSize:size]];
        self.textAlignment=textAlignment;
        self.text = text;
	}
	return self;
}

@end
