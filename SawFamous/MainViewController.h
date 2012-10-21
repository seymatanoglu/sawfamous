//
//  MainViewController.h
//  SawFamous
//
//  Created by Seyma Tanoglu on 10/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "SA_OAuthTwitterController.h"
#import "AsyncImageView.h"
#import "SimpleLabel.h"
#import "Venue.h"

@interface MainViewController : BaseViewController <SA_OAuthTwitterControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    BOOL twitterRequestCancelled;
    UITableView*autoCompleteTableView;
    AsyncImageView* imageView;
    SimpleTextBox*userSearchBox;
    SimpleLabel *userLabel;
    
    NSMutableArray *elementArray;
    NSMutableArray *autoCompleteArray;
    
    NSString *searchSubString;
}

-(void)arrangeForUserAuthentication;
-(void)submit:(NSString*)username;
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;
- (void) finishedSearching;
-(void) venueSelected:(Venue*)venue;
@end
