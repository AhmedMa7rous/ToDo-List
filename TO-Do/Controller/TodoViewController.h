//
//  TodoViewController.h
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <DGActivityIndicatorView.h>
#import "TodoTask.h"
#import "AddTodoViewController.h"
#import "TabBarViewController.h"
#import "ToDoTableViewCell.h"
#import "AddTodoProtocol.h"


NS_ASSUME_NONNULL_BEGIN
extern int indexer;
@interface TodoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, AddTodoProtocol>

#pragma mark - Outlet Connections
@property (weak, nonatomic) IBOutlet UITableView *todosTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *todoSearchBar;
@property (weak, nonatomic) IBOutlet UIButton *addBtnOutlet;
/*==============================================================*/

#pragma mark - Another Properties


@end

NS_ASSUME_NONNULL_END
