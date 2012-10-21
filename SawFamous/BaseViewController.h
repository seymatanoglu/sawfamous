//
//  BaseViewController.h
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "Utility.h"
#import "Configuration.h"
#import "SimpleTextBox.h"
#import "SimpleLabel.h"

@interface BaseViewController : UIViewController<UITextFieldDelegate> {
    UIView*container;
    BOOL supportsRotation, needsProgressBar;
    
    UIAlertView *progressAlert;
    UIActivityIndicatorView *activityView;
    
    UIViewController* parent;
}
@property(nonatomic, assign) UIView* container;
@property(nonatomic, assign) UIViewController* parent;

-(void) draw;
-(void) bind;
-(void) bindView;
-(void)createContainer;
-(void) createBackground;
-(void) configureNavigationBar;
-(void) onBeforeBind;
-(void) onAfterBind;
-(void) onAfterSubmit;
-(BOOL) validate;

-(void) arrangeForLandscapeView;
-(void) arrangeForPortraitView;
-(void) startAnimation;
-(void) endAnimation;

-(void)showProgressView;
-(void)hideProgressView;
- (void)setOriginalFrame;
-(BOOL) controlBeginEditing:(int)tag;
@end
