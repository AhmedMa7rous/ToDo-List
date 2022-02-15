//
//  TodoTask.m
//  TO-Do
//
//  Created by Ma7rous on 1/29/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import "TodoTask.h"

@implementation TodoTask

- (void)encodeWithCoder:(nonnull NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_Description forKey:@"description"];
    [encoder encodeObject:_priority forKey:@"priority"];
    [encoder encodeObject:_img forKey:@"img"];
    [encoder encodeObject:_date forKey:@"date"];

}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)decoder {
    if((self = [super init])){
        _name = [decoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _Description = [decoder decodeObjectOfClass:[NSString class] forKey:@"description"];
        _priority = [decoder decodeObjectOfClass:[NSString class] forKey:@"priority"];
        _img = [decoder decodeObjectOfClass:[NSString class] forKey:@"img"];
        _date = [decoder decodeObjectOfClass:[NSString class] forKey:@"date"];
    
    }
    return  self;
}
+ (BOOL)supportsSecureCoding{
    return  YES;
}
@end
