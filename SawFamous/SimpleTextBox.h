//
//  SimpleTextBox.h
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTextBox : UITextField
-(BOOL)validate;
-(BOOL)validate:(int)charCount;
@end
