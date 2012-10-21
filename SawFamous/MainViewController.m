//
//  MainViewController.m
//  SawFamous
//
//  Created by Seyma Tanoglu on 10/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "JSON.h"
#import "SA_OAuthTwitterEngine.h"
#import "AutoCompleteCell.h"
#import "VenueListViewController.h"

@implementation MainViewController


-(void) configureNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
}

-(void)draw {
    [super draw];
    self.container.backgroundColor = [UIColor grayColor];
    
    imageView = [[AsyncImageView alloc]  initWithFrame:CGRectMake(0, 0, 320 , 320)];
    [self.container addSubview:imageView];

    userSearchBox = [[SimpleTextBox alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
    userSearchBox.tag=1;
    userSearchBox.delegate=self;
    [self.container addSubview:userSearchBox];
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(userSearchBox.frame.size.width + 30, userSearchBox.frame.origin.y, 50, 30)];
    [searchButton addTarget:self action:@selector(searchOnTwitter) forControlEvents:UIControlEventTouchUpInside];
    searchButton.backgroundColor = [UIColor yellowColor];
    searchButton.titleLabel.text = @"Ara";
    [self.container addSubview:searchButton];
    [searchButton release];
    
    userLabel = [[SimpleLabel alloc] initWithFrame:CGRectMake(10, 330, 300, 30) fontSize:15 alignment:UITextAlignmentCenter text:@""];
    userLabel.hidden= YES;
    userLabel.font = [UIFont boldSystemFontOfSize:16];
    userLabel.textColor = [UIColor whiteColor];
    [self.container addSubview:userLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:userLabel.frame];
    [button addTarget:self action:@selector(arrangeForSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:button];
    [button release];

    UIButton *venuesButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 370, 300, 30) ];
    [venuesButton addTarget:self action:@selector(selectVenue) forControlEvents:UIControlEventTouchUpInside];
    venuesButton.backgroundColor = [UIColor redColor];
    [self.container addSubview:venuesButton];
    [venuesButton release];
    
    autoCompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 56, 310, 100) style:UITableViewStylePlain];
    autoCompleteTableView.delegate = self;
    autoCompleteTableView.dataSource = self;
    autoCompleteTableView.scrollEnabled = YES;
    autoCompleteTableView.hidden = YES;
    autoCompleteTableView.tag = 1;
    [autoCompleteTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.container addSubview:autoCompleteTableView];
}

-(void)bindView {
    if (!twitterRequestCancelled) {
        if ([[Configuration getAuthKey] isEqualToString:@""]) { 
            SA_OAuthTwitterEngine *engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
            engine.consumerKey = [Configuration getConsumerKey];
            engine.consumerSecret = [Configuration getConsumerSecret];
            
            UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: engine delegate: self];
            [self presentModalViewController: controller animated: YES];
        }
    }
    [super bindView];
}

-(void) searchOnTwitter {
    [self onBeforeBind];
    [self performSelector:@selector(getTwitterUsers) withObject:nil afterDelay:0.1];
}

-(void) getTwitterUsers {
    elementArray = [Service getTwitterUsers:userSearchBox.text];
    [autoCompleteTableView reloadData];
    [self onAfterBind];
}

// String in Search textfield
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag==1) {
        NSString *substring = [NSString stringWithString:textField.text];
        substring = [substring stringByReplacingCharactersInRange:range withString:string];
        [self searchAutocompleteEntriesWithSubstring:substring];
    }
    return YES;
}

// Take string from Search Textfield and compare it with autocomplete array
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    elementArray = [Service getUsers:substring];
    autoCompleteArray = nil;
    //[searchSubString retain];
    if (substring.length > 2) {
//        if (searchSubString.length> 2 && substring.length >= searchSubString.length) {
//            autoCompleteArray = [[NSMutableArray alloc] init];
//            [autoCompleteArray removeAllObjects];
//            int i=0;
//            for (User* user in elementArray) {
//                if (i<elementArray.count) {
//                    NSString* tempString  = [user.name lowercaseString];
//                    NSRange substringRangeLowerCase = [tempString rangeOfString:[substring lowercaseString]];
//                    if (substringRangeLowerCase.length!=0) {
//                        [autoCompleteArray addObject:user];
//                    }
//                }
//                i++;
//            }
//        }
//        else {
//            elementArray = [Service getUsers:substring];
//            searchSubString = substring;
//            autoCompleteArray = nil;
//        }
//        [searchSubString retain];
    }
    else {
        searchSubString = @"";
        autoCompleteArray = nil;
        elementArray = nil;
    }
        
    
    autoCompleteTableView.hidden = NO; 
    [self.view bringSubviewToFront:autoCompleteTableView];
    [autoCompleteTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    if (tableView.tag==1) {
        if (autoCompleteArray) {
            autoCompleteTableView.frame = CGRectMake(5, 56, 310, 28*autoCompleteArray.count );
            return autoCompleteArray.count;
        }
        autoCompleteTableView.frame = CGRectMake(5, 56, 310, 28*elementArray.count );
        return elementArray.count;
    }
    return 1;
}

- (AutoCompleteCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag==1) {
        AutoCompleteCell *cell;
        static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
        User*user;
        if (autoCompleteArray) {
            user =[autoCompleteArray objectAtIndex:indexPath.row];
        }
        else
            user =[elementArray objectAtIndex:indexPath.row];
        if (cell == nil){    
            cell = [[AutoCompleteCell alloc] initWithEntity:user index:indexPath.row reuseIdentifier:AutoCompleteRowIdentifier parentCollection:elementArray parentView:self];
        }
        cell.textLabel.text = user.name;
        return cell; 
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag==1) {
        User* user;
        if (autoCompleteArray) {
            user =[autoCompleteArray objectAtIndex:indexPath.row];
        }
        else
            user =[elementArray objectAtIndex:indexPath.row];
        if (![user.profileImageUrl isEqualToString:@""]) {
            NSURL* url = [NSURL URLWithString:user.profileImageUrl];
            [imageView loadImageFromURL:url]; 
        }
        else {
            //default imaj
        }
        userLabel.text = user.name;
        userSearchBox.text = @"";
        [self finishedSearching];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 28;
}

- (void) finishedSearching {
    autoCompleteTableView.hidden = YES;
    [userSearchBox resignFirstResponder];
    userSearchBox.hidden = YES;
    userLabel.hidden=NO;
}

- (void) arrangeForSearch {
    userSearchBox.hidden = NO;
    userLabel.hidden=YES;
    
    for (UIView*view in imageView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView*image = (UIImageView*)view;
            [image setImage:nil];
        }
    }
}

-(void) selectVenue {
    VenueListViewController * venues = [[VenueListViewController alloc] init];
    venues.parent = self;
    [self.navigationController pushViewController:venues animated:YES];
}

-(void) venueSelected:(Venue*)venue{
   
}

#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
    NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject: data forKey: @"authData"];
    [defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	NSLog(@"Authenicated for %@", username);
    [Service authenticate:username];
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
    twitterRequestCancelled = YES;
}

-(void)dealloc {
    [autoCompleteTableView release];  
    [elementArray release];
    [autoCompleteArray release];
    [imageView release];
    [userSearchBox release];
    [userLabel release];
    [super dealloc];
}

@end
