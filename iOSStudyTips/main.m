//
//  main.m
//  iOSStudyTips
//
//  Created by MACHUNLEI on 2017/5/24.
//  Copyright © 2017年 MACHUNLEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#warning chlma

_Pragma("message(\"chlma\")")

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%@", [NSString stringWithFormat:@"%s", STRINGIFY(123)]);
        NSLog(@"%@", [NSString stringWithFormat:@"%s", DEFER_STRINGIFY(123)]);
        
        @TODO("有些事，我都已忘记");
        @TODO("但我现在还记得");
        @TODO("那是一个晚上，我的母亲问我");
        @TODO("今天怎~么~不开心？");
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
