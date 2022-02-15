//
//  DBManager.h
//  SQLite
//
//  Created by Eng Tian Xi on 22/04/2016.
//  Copyright © 2016 Eng Tian Xi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

@property (strong, nonatomic)NSMutableArray *arrColumnNames;
@property (nonatomic)int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

- (instancetype)initWithDatabaseName:(NSString *)dbFilename;

- (NSArray *)loadDataFromDB:(NSString *)query;

- (void)executeQuery:(NSString *)query;

@end
