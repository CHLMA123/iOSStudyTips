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


#pragma mark - 字符串按多个符号分割
- (void)StringSegmentation {
    NSString *str = @"abc,def.yuuw";
    NSCharacterSet *sets = [NSCharacterSet characterSetWithCharactersInString:@",."];
    NSLog(@"%@",[str componentsSeparatedByCharactersInSet:sets]);
}
#pragma mark - 禁止锁屏
- (void)LockTheScreen {
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}
#pragma mark - 字符串反转
- (NSString *)reverseWordsInString:(NSString *)str {
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:str.length];
    for (NSInteger i = str.length - 1; i >= 0 ; i --)
    {
        unichar ch = [str characterAtIndex:i];
        [newString appendFormat:@"%c", ch];
    }
    return newString;
}

//第二种：
- (NSString*)reverseWordsInString2:(NSString*)str {
    NSMutableString *reverString = [NSMutableString stringWithCapacity:str.length];
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reverString appendString:substring];
    }];
    return reverString;
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
