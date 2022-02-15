//
//  AddTodoProtocol.h
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TodoTask.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AddTodoProtocol <NSObject>

-(void) addToDo: (TodoTask*)todo;
@end

NS_ASSUME_NONNULL_END
