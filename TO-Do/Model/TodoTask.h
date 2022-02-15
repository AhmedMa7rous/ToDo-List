//
//  TodoTask.h
//  TO-Do
//
//  Created by Ma7rous on 1/29/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodoTask : NSObject <NSCoding, NSSecureCoding>
{
    
}
@property  NSString* name;
@property  NSString* Description;
@property  NSString* priority;
@property  NSString* img;
@property  NSString* date;
@property  NSString* reminder;
@property  NSDate* targetDate;
@property  NSString* attachedFile;
@property  NSString* inProgress;
@property  NSString* done;
@end

NS_ASSUME_NONNULL_END
