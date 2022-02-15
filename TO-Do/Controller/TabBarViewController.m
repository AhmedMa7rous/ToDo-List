//
//  TabBarViewController.m
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()
{
    TodoViewController* obj;
    UNUserNotificationCenter* center;
    //sqlite variables
    NSFileManager* fs;
    NSString* filePath;
    char *errMsg;
    sqlite3* db;
    sqlite3_stmt* allRecords;
}

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //obj = [TodoViewController new];
    [self intialization];
    [self permission];
 
}

/*======================================================================*/
#pragma mark - Delegation Function
-(void) storeTodo:(TodoTask *)todo{
    [self insertInDBTodoTask:todo];
}

/*======================================================================*/
#pragma mark - Sqlite Functions

-(void) createSqliteDatabase {
    //check if database file is available or not
    fs = [NSFileManager defaultManager];
    if ([fs fileExistsAtPath:filePath] == YES) {
        NSLog(@"File found");
        //create a table
        if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
            //create table query
            NSString* createTable = @"CREATE TABLE IF NOT EXISTS todos(tId INTEGER PRIMARY KEY AUTOINCREMENT, tName TEXT NOT NULL UNIQUE, tDescription TEXT, tPriority TEXT, tImage TEXT, tDateTime TEXT, tReminder TEXT, tAttachedFile TEXT, tInprogress TEXT, tDone TEXT)";
            if (sqlite3_exec(db, [createTable UTF8String], NULL,  NULL, &(errMsg)) == SQLITE_OK) {
                NSLog(@"Table created.");
            } else {
                NSLog(@"Error while creating table : %s", errMsg);
            }
        } else {
            NSLog(@"Failed to open database file.");
        }
    } else {
        NSLog(@"File not found");
        //create a new database if not found
        [fs createFileAtPath:filePath contents:NULL attributes:NULL];
    }
}

-(void) insertInDBTodoTask : (TodoTask*)todo {
    //TODO: get todo info to insert in sqlite
    NSString* name = todo.name;
    NSString* desc = todo.Description;
    NSString* priority = todo.priority;
    NSString* image = todo.img;
    NSString* date = todo.date;
    NSString* reminder = todo.reminder;
    NSString* attachedFile = todo.attachedFile;
    NSString* inProgress = todo.inProgress;
    NSString* done = todo.done;
    //TODO: Insert Query In Table
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Insert query
        NSString* insertQuery = [NSString stringWithFormat:@"INSERT INTO todos(tName, tDescription, tPriority, tImage, tDateTime, tReminder, tAttachedFile, tInprogress, tDone) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@')", name, desc, priority, image, date, reminder, attachedFile, inProgress, done];
        if (sqlite3_exec(db, [insertQuery UTF8String], NULL,  NULL, &errMsg ) == SQLITE_OK) {
            NSLog(@"Record Inserted.");
        } else {
            NSLog(@"Error while inserting record : %s", errMsg);
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
}

-(BOOL) checkNameValidation : (NSString*)name{
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Search query
        NSString* selectQuery = [NSString stringWithFormat:@"INSERT INTO todos(tName) VALUES('%@')",name];
        if (sqlite3_exec(db, [selectQuery UTF8String], NULL, NULL, &errMsg) == SQLITE_OK) {
            NSLog(@"Record Not Exist.");
            [self deleteFromDbAtTodo:name];
            return NO;
        } else {
            NSLog(@"Record Exist.");
            return YES;
        }
    } else {
        NSLog(@"Failed to open database file.");
        return NO;
    }
}

//TODO: Update todo Function
-(void) updateDbAtTodo : (TodoTask*)todo {
    //TODO: get todo info to update in sqlite
    NSString* name = todo.name;
    NSString* desc = todo.Description;
    NSString* priority = todo.priority;
    NSString* image = todo.img;
    NSString* date = todo.date;
    NSString* reminder = todo.reminder;
    NSString* attachedFile = todo.attachedFile;
    NSString* inProgress = todo.inProgress;
    NSString* done = todo.done;
    //TODO: Update Query In Table
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Update query
        NSString* updateQuery = [NSString stringWithFormat:@"UPDATE todos SET tName = '%@', tDescription = '%@', tPriority = '%@', tImage = '%@', tDateTime = '%@', tReminder = '%@', tAttachedFile = '%@', tInprogress = '%@', tDone = '%@' WHERE tName = '%@'", name, desc, priority, image, date, reminder, attachedFile, inProgress, done, name];
        if (sqlite3_exec(db, [updateQuery UTF8String], NULL,  NULL, &errMsg ) == SQLITE_OK) {
            NSLog(@"Record updated.");
        } else {
            NSLog(@"Error while updateing record : %s", errMsg);
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
}

//TODO: Update todo to inProgress Function
-(void) updateDbToInProgressAtTodo : (TodoTask*)todo {
    //TODO: get todo info to update in sqlite
    NSString* name = todo.name;
    NSString* desc = todo.Description;
    NSString* priority = todo.priority;
    NSString* image = todo.img;
    NSString* date = todo.date;
    NSString* reminder = todo.reminder;
    NSString* attachedFile = todo.attachedFile;
    NSString* inProgress = @"yes";
    NSString* done = @"no";
    //TODO: Update Query In Table
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Update query
        NSString* updateQuery = [NSString stringWithFormat:@"UPDATE todos SET tName = '%@', tDescription = '%@', tPriority = '%@', tImage = '%@', tDateTime = '%@', tReminder = '%@', tAttachedFile = '%@', tInprogress = '%@', tDone = '%@' WHERE tName = '%@'", name, desc, priority, image, date, reminder, attachedFile, inProgress, done, name];
        if (sqlite3_exec(db, [updateQuery UTF8String], NULL,  NULL, &errMsg ) == SQLITE_OK) {
            NSLog(@"Record updated.");
        } else {
            NSLog(@"Error while updateing record : %s", errMsg);
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
}

//TODO: Update todo to inProgress Function
-(void) updateDbToDoneAtTodo : (TodoTask*)todo {
    //TODO: get todo info to update in sqlite
    NSString* name = todo.name;
    NSString* desc = todo.Description;
    NSString* priority = todo.priority;
    NSString* image = todo.img;
    NSString* date = todo.date;
    NSString* reminder = todo.reminder;
    NSString* attachedFile = todo.attachedFile;
    NSString* inProgress = @"no";
    NSString* done = @"yes";
    //TODO: Update Query In Table
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Update query
        NSString* updateQuery = [NSString stringWithFormat:@"UPDATE todos SET tName = '%@', tDescription = '%@', tPriority = '%@', tImage = '%@', tDateTime = '%@', tReminder = '%@', tAttachedFile = '%@', tInprogress = '%@', tDone = '%@' WHERE tName = '%@'", name, desc, priority, image, date, reminder, attachedFile, inProgress, done, name];
        if (sqlite3_exec(db, [updateQuery UTF8String], NULL,  NULL, &errMsg ) == SQLITE_OK) {
            NSLog(@"Record updated.");
        } else {
            NSLog(@"Error while updateing record : %s", errMsg);
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
}

-(void) deleteFromDbAtTodo : (NSString*)name {
    //TODO: get todo info to delete from sqlite
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Delete query
        NSString* deleteQuery = [NSString stringWithFormat:@"DELETE from todos WHERE tName = '%@'", name];
        if (sqlite3_exec(db, [deleteQuery UTF8String], NULL,  NULL, &errMsg ) == SQLITE_OK) {
            NSLog(@"Record deleted.");
        } else {
            NSLog(@"Error while deleting record : %s", errMsg);
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
}

-(NSMutableArray*) displayTodosFromDb  {
    //TODO: get todo info to display from sqlite
    
    NSMutableArray<TodoTask*> *arr = [NSMutableArray new];
    //TODO: Select Query In Table
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Display query
        NSString* selectQuery = @"SELECT * FROM todos";
        if (sqlite3_prepare(db, [selectQuery UTF8String], -1, &allRecords, NULL) == SQLITE_OK) {
            while (sqlite3_step(allRecords) == SQLITE_ROW) {
                TodoTask* obj = [TodoTask new];
                obj.name = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 1)];
                obj.Description = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 2)];
                obj.priority = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 3)];
                obj.img = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 4)];
                obj.date = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 5)];
                obj.reminder = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 6)];
                obj.attachedFile = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 7)];
                obj.inProgress = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 8)];
                obj.done = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 9)];
                [arr addObject:obj];
            }
        } else {
            NSLog(@"Error while fetching record.");
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
    return arr;
}

-(NSMutableArray*) displayInProgressFromDb{
    //TODO: get todo info to display from sqlite
    
    NSMutableArray<TodoTask*> *arr = [NSMutableArray new];
    //TODO: Select Query In Table
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Display query
        NSString* selectQuery = @"SELECT * FROM todos WHERE tInprogress = 'yes'";
        if (sqlite3_prepare(db, [selectQuery UTF8String], -1, &allRecords, NULL) == SQLITE_OK) {
            while (sqlite3_step(allRecords) == SQLITE_ROW) {
                TodoTask* obj = [TodoTask new];
                obj.name = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 1)];
                obj.Description = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 2)];
                obj.priority = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 3)];
                obj.img = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 4)];
                obj.date = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 5)];
                obj.reminder = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 6)];
                obj.attachedFile = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 7)];
                obj.inProgress = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 8)];
                obj.done = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 9)];
                [arr addObject:obj];
            }
        } else {
            NSLog(@"Error while fetching record.");
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
    return arr;
}

-(NSMutableArray*) displayDoneFromDb{
    //TODO: get todo info to display from sqlite
    
    NSMutableArray<TodoTask*> *arr = [NSMutableArray new];
    //TODO: Select Query In Table
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Display query
        NSString* selectQuery = @"SELECT * FROM todos WHERE tDone = 'yes'";
        if (sqlite3_prepare(db, [selectQuery UTF8String], -1, &allRecords, NULL) == SQLITE_OK) {
            while (sqlite3_step(allRecords) == SQLITE_ROW) {
                TodoTask* obj = [TodoTask new];
                obj.name = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 1)];
                obj.Description = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 2)];
                obj.priority = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 3)];
                obj.img = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 4)];
                obj.date = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 5)];
                obj.reminder = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 6)];
                obj.attachedFile = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 7)];
                obj.inProgress = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 8)];
                obj.done = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 9)];
                [arr addObject:obj];
            }
        } else {
            NSLog(@"Error while fetching record.");
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
    return arr;
}

-(TodoTask*) getTodosFromDbWithIndex: (NSString*) temp  {
    //TODO: get todo info to display from sqlite
    TodoTask* obj;
    //TODO: Select Query In Table
    //Check if connection is open or not
    if (sqlite3_open([filePath UTF8String], &db) == SQLITE_OK) {
        //Display query
        NSString* selectQuery = [NSString stringWithFormat: @"SELECT * FROM todos WHERE tName = '%@'",temp];
        if (sqlite3_prepare(db, [selectQuery UTF8String], -1, &allRecords, NULL) == SQLITE_OK) {
            while (sqlite3_step(allRecords) == SQLITE_ROW) {
                obj = [TodoTask new];
                obj.name = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 1)];
                obj.Description = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 2)];
                obj.priority = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 3)];
                obj.img = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 4)];
                obj.date = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 5)];
                obj.reminder = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 6)];
                obj.attachedFile = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 7)];
                obj.inProgress = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 8)];
                obj.done = [NSString stringWithFormat:@"%s", sqlite3_column_text(allRecords, 9)];

            }
        } else {
            NSLog(@"Error while fetching record.");
        }
    } else {
        NSLog(@"Failed to open database file.");
    }
    return obj;
}
-(void) permission {
    center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!error) {
                                  NSLog(@"request authorization succeeded!");
                                  [self makeReminderForTodo];
                              }
                            }];
}
-(void) makeReminderForTodo {
    
//TODO: 1-Create and configure a UNMutableNotificationContent object with the notification details.
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"ToDo Reminder!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey: @"Ok"
            arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    //set calender
    //NSCalendar* calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //[calender setTimeZone:[NSTimeZone localTimeZone]];
    // Configure the trigger for todo time.
    NSDateComponents* date = [[NSDateComponents alloc] init];
    date.hour = 20;
    date.minute = 7;
    UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger
           triggerWithDateMatchingComponents:date repeats:NO];
    // Create the request object.
    UNNotificationRequest* request = [UNNotificationRequest
           requestWithIdentifier:@"Todo Reminder" content:content trigger:trigger];
    
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
       if (error != nil) {
           NSLog(@"%@", error.localizedDescription);
       }
    }];
                
}
/*======================================================================*/
#pragma mark - Services Functions
-(void) intialization {
//Variables initialization
filePath = @"/Users/ma7rous/Developer/Objictive-C/TO-Do/todo.sqlite⁩";
}
@end
