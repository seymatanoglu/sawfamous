//
//  BaseViewController.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
@synthesize  container,parent;

-(void)viewDidLoad {
    [super viewDidLoad];
    [self draw];
    [self bind];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureNavigationBar];
}

-(void)draw{
    [self createContainer];
    [self createBackground];
}

-(void)createContainer {
    self.view.frame = CGRectMake(0, 0, 320 , 480);
    container = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:container];
    [container release];
}

-(void) createBackground {
//    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 1024, 768)];
//    [bg setImage:[UIImage imageNamed:@"bg_yatay.png"]];
//    [self.container insertSubview:bg atIndex:9999]; // hep en altta kalsın
//    [bg release];
}

-(void) configureNavigationBar {
    self.navigationController.navigationBar.hidden = NO;
}


-(void) onBeforeBind{
    [self showProgressView];
}

-(void) bind{
    if (needsProgressBar) {
        if (![Service isConnected]) {
            [Utility showNoConnectionMessage];
            return;
        }
        [self onBeforeBind];
        [self performSelector:@selector(bindView) withObject:nil afterDelay:0.1];   
    }
    else
        [self bindView];
}

-(void) bindView{
    [self onAfterBind];
}

-(void) onAfterBind{
    [self hideProgressView];
}

-(void)showProgressView {
    progressAlert = [[UIAlertView alloc] initWithTitle:@"İşlem yapılıyor"
                                                             message:@"Lütfen bekleyin..."
                                                            delegate: self
                                                   cancelButtonTitle: nil
                                                   otherButtonTitles: nil];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.frame = CGRectMake(139.0f-18.0f, 80.0f, 37.0f, 37.0f);
    [progressAlert addSubview:activityView];
    [activityView startAnimating];
    
    [progressAlert show];
}

-(void)hideProgressView {
    [activityView stopAnimating];
    [progressAlert dismissWithClickedButtonIndex:0 animated:TRUE];
}


-(BOOL) validate{
    if (![Service isConnected]) {
        [Utility showNoConnectionMessage];
        return NO;
    }
    return YES;
}

-(void) submit{
    if ([self validate]) {
        [self showProgressView];
        [self performSelector:@selector(onSubmit) withObject:nil afterDelay:0.1];
    }
}

-(void) onSubmit{
    [self onAfterSubmit];
}

-(void) onAfterSubmit{
    [self hideProgressView];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [self arrangeForLandscapeView];
    }
    else {
        [self arrangeForPortraitView];
    }
}

-(void) arrangeForLandscapeView {
    self.container.transform = CGAffineTransformMakeRotation(0);
    self.container.frame = CGRectMake(0, 0, 1024, 768);
}

-(void) arrangeForPortraitView {
    self.container.transform = CGAffineTransformMakeRotation(M_PI/ 2);
    self.container.frame = CGRectMake(0, 0, 768, 1024);
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation  {
    if (toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        return NO;
    }
    return supportsRotation;
}


-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    return [self controlBeginEditing:textField.tag];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return [self controlBeginEditing:textView.tag];
}

-(BOOL) controlBeginEditing:(int)tag{
    if (tag>=2) {
        [self startAnimation];
        int scrollFrame=tag *50;
        self.container.frame=CGRectMake(container.frame.origin.x , container.frame.origin.y - scrollFrame,  container.frame.size.width,  container.frame.size.height);
        [self endAnimation];
    }
    else
        [self setOriginalFrame];
    return YES;
}

- (void)setOriginalFrame{
    [self startAnimation];
    self.container.frame=CGRectMake(container.frame.origin.x , 0,  container.frame.size.width,  container.frame.size.height);
    
    [self endAnimation];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self setOriginalFrame];
    [textField resignFirstResponder];
    return NO;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}

-(void)startAnimation {
    [UIView beginAnimations:@"Up" context:NULL];
    [UIView setAnimationDuration:0.3];
}
-(void) endAnimation {
    [UIView commitAnimations];
}

-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc {
    [container release];
    parent = nil;
    [super dealloc];
}

@end
