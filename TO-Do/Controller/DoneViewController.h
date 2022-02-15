//
//  DoneViewController.h
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "TodoTask.h"
#import "DoneTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
extern int indexer;
@interface DoneViewController : UIViewController <UITableViewDelegate,  UITableViewDataSource, UISearchBarDelegate>

@end

NS_ASSUME_NONNULL_END
