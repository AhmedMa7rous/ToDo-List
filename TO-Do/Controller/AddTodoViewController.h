//
//  AddTdodoViewController.h
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "AddTodoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTodoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    BOOL hasReminder;
    
}
@property NSString* str;
@property id<AddTodoProtocol> delegate;
@end

NS_ASSUME_NONNULL_END
