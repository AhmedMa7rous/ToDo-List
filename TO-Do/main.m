//
//  main.m
//  TO-Do
//
//  Created by Ma7rous on 1/29/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NSString *todoState = @"";
int indexer = 0;

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
