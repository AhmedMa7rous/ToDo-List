//
//  InProgressViewController.h
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "InProgressTableViewCell.h"
#import "TodoTask.h"

NS_ASSUME_NONNULL_BEGIN
extern int indexer;
@interface InProgressViewController : UIViewController <UITableViewDelegate,  UITableViewDataSource, UISearchBarDelegate>

@end

NS_ASSUME_NONNULL_END
