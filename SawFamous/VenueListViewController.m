//
//  VenueListViewController.m
//  SawFamous
//
//  Created by Seyma Tanoglu on 10/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VenueListViewController.h"
#import "MainViewController.h"

@implementation VenueListViewController

-(void)bind{
    self.collection = [Service getNearByVenues];
    [super bind];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainViewController *parentView = (MainViewController*)self.parent;
    [parentView venueSelected:[self.collection objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
