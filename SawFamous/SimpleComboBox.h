//
//  WeatherConditionsPage.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entity.h"

@interface SimpleComboBox : UIView <UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    NSString * placeHolder;
    Entity *selectedEntity, *currentEntity;
    NSMutableArray *dataSource;
    UIView *bg;
    UIActionSheet *sheet;
    id delegate;
    UILabel *placeHolderLabel;
}
@property(nonatomic, retain)NSString * placeHolder;
@property(nonatomic, retain) Entity *selectedEntity;
@property(nonatomic, retain) Entity *currentEntity;
@property(nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) UIView *bg;
@property(nonatomic,retain)id delegate;

-(id)initWithDataSource:(NSMutableArray *)data frame:(CGRect)frame delegate:(id)view;
- (void)dismissPicker;
@end
