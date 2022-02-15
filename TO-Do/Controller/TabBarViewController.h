//
//  TabBarViewController.h
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <NotificationCenter/NotificationCenter.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotifications/UNNotificationContent.h>
#import "StoreTodoProtocol.h"
#import "TodoTask.h"
#import "TodoViewController.h"


NS_ASSUME_NONNULL_BEGIN
extern NSString *todoState;

@interface TabBarViewController : UITabBarController <StoreTodoProtocol>

-(void) createSqliteDatabase;
-(void) insertInDBTodoTask : (TodoTask*)todo;
-(void) updateDbAtTodo : (TodoTask*)todo;
-(void) updateDbToInProgressAtTodo : (TodoTask*)todo;
-(void) updateDbToDoneAtTodo : (TodoTask*)todo;
-(BOOL) checkNameValidation : (NSString*)name;
-(void) deleteFromDbAtTodo : (NSString*)name;
-(NSMutableArray*) displayTodosFromDb;
-(NSMutableArray*) displayInProgressFromDb;
-(NSMutableArray*) displayDoneFromDb;
-(TodoTask*) getTodosFromDbWithIndex: (NSString*) temp;
-(void) permission;

@end

NS_ASSUME_NONNULL_END
