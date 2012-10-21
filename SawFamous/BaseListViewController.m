//
//  BaseListViewController.m
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseListViewController.h"
#import "Entity.h"

@implementation BaseListViewController
@synthesize collection;

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    [self createTableView];
}

-(void) configureTableView{
    tableLeft=20;
    tableTop = 20;
    tableWidth=313;
    tableHeight=490;
}

-(void)createTableView {
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableLeft, tableTop, tableWidth, tableHeight) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource = self;
    tableView.separatorColor = [UIColor clearColor];
    [container addSubview:tableView];
    [tableView release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.collection.count;
} 

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

-(NSString *) getCellIdentifier:(NSInteger)index sectionindex:(NSInteger)section{
    return [[[NSString stringWithFormat:@"%i",section] stringByAppendingFormat:@"%i" , index] stringByAppendingFormat:@"%i", reloader];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [self getCellIdentifier:indexPath.row sectionindex:indexPath.section];
    cell= [self getCellOnContentView:_tableView cellIdentifier:cellIdentifier];
    if (cell == nil) { 
        Entity *entity = nil;
        if (indexPath.row < self.collection.count) {
            entity = [self.collection objectAtIndex:(indexPath.row)];
        }
        cell = [self getCell:entity cellForRowAtIndexPath:indexPath identifier:cellIdentifier];
    }
    return cell;
}

-(BaseCell*) getCell:(Entity*)entity cellForRowAtIndexPath:(NSIndexPath *)indexPath  identifier:(NSString*)cellIdentifier{
    return [[BaseCell alloc] initWithEntity:entity index:indexPath.row reuseIdentifier:cellIdentifier parentCollection:self.collection parentView:self];
}

-(BaseCell *)getCellOnContentView:(UITableView *)_tableView cellIdentifier:(NSString *)cellIdentifier{
	return (BaseCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
}

-(void) reloadData{
    reloader++;
    [tableView reloadData];
}

-(void)dealloc {
    [tableView release];
    [super dealloc];
}

@end
