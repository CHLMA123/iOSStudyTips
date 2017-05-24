//
//  ViewController.m
//  iOSStudyTips
//
//  Created by MACHUNLEI on 2017/5/24.
//  Copyright © 2017年 MACHUNLEI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self removeNSUserDefaults];
//    enumerateFonts();
}
#pragma mark - 打印系统所有已注册的字体名称
void enumerateFonts() {
    for(NSString *familyName in [UIFont familyNames])
    {
        NSLog(@"%@",familyName);
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for(NSString *fontName in fontNames)
        {
            NSLog(@"\t|- %@",fontName);
        }
    }
}
#pragma mark - 删除NSUserDefaults所有记录
- (void)removeNSUserDefaults {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"111" forKey:@"mine"];
    [defaults synchronize];
    NSLog(@"### %@ ###",[defaults objectForKey:@"mine"]);
    //方法一
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    //方法二
    [self resetDefaults];
    NSLog(@"### %@ ###",[defaults objectForKey:@"mine"]);
}

- (void)resetDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryRepresentation];
    for (id key in [dict allKeys]) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
