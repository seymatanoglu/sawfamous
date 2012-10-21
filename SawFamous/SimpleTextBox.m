//
//  SimpleTextBox.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleTextBox.h"

@implementation SimpleTextBox

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFont:[UIFont systemFontOfSize:14]];
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.keyboardType = UIKeyboardTypeDefault;
        self.returnKeyType = UIReturnKeyDone;
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.text = @"";
    }
    return self;
}

-(BOOL)validate{
    return [self validate:1];
}

-(BOOL)validate:(int)charCount{
    self.text = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.text.length<charCount) {
        return NO;
    }
    return YES;
}

@end
