//
//  WeatherConditionsPage.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleComboBox.h"

@implementation SimpleComboBox
@synthesize placeHolder,selectedEntity,currentEntity, dataSource, bg, delegate;

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

-(id)initWithDataSource:(NSMutableArray *)data frame:(CGRect)frame delegate:(id)view{
	self = [super initWithFrame:frame];
	if (self) {
        self.placeHolder = @"Seçiniz";
		self.dataSource = data;
        self.delegate=view;
//        UIImage *image = [UIImage imageNamed:@"left.png"];
//        UIImage *image2 = [UIImage imageNamed:@"center.png"];
//        UIImage *image3 = [UIImage imageNamed:@"right.png"];
//        UIImageView *bgLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width / 2, image.size.height/2)];
//        [bgLeft setImage:image];
//        [self addSubview:bgLeft];
//        [bgLeft release];
//        
//        UIImageView *bgCenter = [[UIImageView alloc] initWithFrame:CGRectMake(bgLeft.frame.size.width, 0, frame.size.width -image3.size.width / 2, image2.size.height/2)];
//        [bgCenter setImage:image2];
//        [self addSubview:bgCenter];
//        [bgCenter release];
//        
//        UIImageView *bgRight = [[UIImageView alloc] initWithFrame:CGRectMake(bgCenter.frame.size.width + bgCenter.frame.origin.x, 0, image3.size.width / 2, image3.size.height/2)];
//         [bgRight setImage:image3];
//        [self addSubview:bgRight];
//        [bgRight release];
        
        placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x +10, self.bounds.origin.y +4, self.bounds.size.width -35, self.bounds.size.height)];
        placeHolderLabel.text = self.placeHolder;
        placeHolderLabel.font = [UIFont italicSystemFontOfSize:14];
        placeHolderLabel.backgroundColor = [UIColor clearColor];
        [placeHolderLabel setTextColor:[UIColor grayColor]];
        [self addSubview:placeHolderLabel];
	}
	return self;
}

-(void)setSelectedEntity:(Entity *)entity{
    selectedEntity=entity;
    if (selectedEntity==nil) {
        placeHolderLabel.text=@"Seçiniz";
        placeHolderLabel.textColor = [UIColor grayColor];
        placeHolderLabel.font = [UIFont italicSystemFontOfSize:placeHolderLabel.font.pointSize];
    }
    else {
        placeHolderLabel.text=entity.name;
        placeHolderLabel.textColor = [UIColor blackColor];
        placeHolderLabel.font = [UIFont systemFontOfSize:placeHolderLabel.font.pointSize];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event	{
	[self performSelector:@selector(createPicker)];
}

- (void)createPicker {
    sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil  destructiveButtonTitle:nil   otherButtonTitles:nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    UIPickerView *Picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, 320, 220)];
    Picker.showsSelectionIndicator = YES;
    Picker.dataSource = self;
    Picker.delegate = self;
    [sheet addSubview:Picker];
    [Picker release]; 

    UIToolbar *toolbar = [[UIToolbar alloc] init] ;
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    toolbar.frame = CGRectMake(0, 0, 320, 44);
    [sheet addSubview:toolbar];
    
    UISegmentedControl *done = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Tamam", nil]] autorelease];
    done.momentary = YES;
    done.frame = CGRectMake(230, 7, 80, 33);
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventValueChanged];
    done.segmentedControlStyle = UISegmentedControlStyleBar;
    done.tintColor =toolbar.tintColor;
    [sheet addSubview:done];
    
    UISegmentedControl *cancel = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Vazgeç", nil]] autorelease];
    cancel.momentary = YES;
    cancel.frame = CGRectMake(10, 7, 80, 33);
    cancel.segmentedControlStyle = UISegmentedControlStyleBar;
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventValueChanged];
    cancel.tintColor = toolbar.tintColor;
    [sheet addSubview:cancel];
    
    [toolbar release];
    
    if (self.dataSource.count>0) {
        if (self.selectedEntity==nil) {
            self.currentEntity = [self.dataSource objectAtIndex:0];
        }
        else
            [Picker selectRow:[self.dataSource indexOfObject:self.selectedEntity] inComponent:0 animated:YES];
    }
    
    [sheet showInView:self.superview]; 
    [sheet setBounds:CGRectMake(0,0,320,480)];
    [sheet autorelease];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{	
    self.currentEntity = [self.dataSource objectAtIndex:row];	
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	Entity *TempEntity =  [self.dataSource objectAtIndex:row];
	return TempEntity.name;
}

- (BOOL)cancel:(id)sender {
    [self dismissPicker];
    return YES;
}

- (BOOL)done:(id)sender {
    [self dismissPicker];
	if (self.currentEntity != nil) {
        self.selectedEntity = self.currentEntity;
		placeHolderLabel.text = self.selectedEntity.name;
        placeHolderLabel.font = [UIFont systemFontOfSize:14];
        [placeHolderLabel setTextColor:[UIColor blackColor]];
        [delegate performSelector:@selector(comboSelected:) withObject:self];
	}
	else {
        placeHolderLabel.text = self.placeHolder;
        placeHolderLabel.font = [UIFont italicSystemFontOfSize:14];
        [placeHolderLabel setTextColor:[UIColor grayColor]];    
	}
    return YES;
}

- (void)dismissPicker {
	[sheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)dealloc {
    [bg release];
    [placeHolderLabel release];
    [sheet release];
    [super dealloc];
}

@end
