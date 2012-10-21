//
//  BaseListViewController.h
//  GBoardiPad
//
//  Created by Seyma Tanoglu on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseCell.h"

@interface BaseListViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>{
    int reloader, tableLeft, tableTop, tableWidth, tableHeight;
    UITableView *tableView;
    NSMutableArray * collection;
    BaseCell *cell;
}
@property(nonatomic, assign)NSMutableArray * collection;

-(void) createTableView;
-(void) configureTableView;
-(BaseCell*) getCell:(Entity*)entity cellForRowAtIndexPath:(NSIndexPath *)indexPath  identifier:(NSString*)cellIdentifier;
-(BaseCell *)getCellOnContentView:(UITableView *)_tableView cellIdentifier:(NSString *)cellIdentifier;
-(void) reloadData;
@end
