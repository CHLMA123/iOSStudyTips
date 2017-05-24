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
//    [self ThePinyinofChineseCharacters];
//    [self setStatusBarBackgroundColor:[UIColor redColor]];
//    [self modifyTextfield];
}

#pragma mark - 修改UITextField中Placeholder的文字颜色
- (void)modifyTextfield {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH - 20, 20)];
    [textField setPlaceholder:@"Placeholder的文字颜色"];
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:textField];
}
#pragma mark - NSArray 快速求总和 最大值 最小值 和 平均值
- (void)arraySum {
    NSArray *array = [NSArray arrayWithObjects:@"2.0", @"2.3", @"3.0", @"4.0", @"10", nil];
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
    NSLog(@"%f\n%f\n%f\n%f",sum,avg,max,min);
}
#pragma mark - 手动更改iOS状态栏的颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
#pragma mark - iOS 获取汉字的拼音
- (void)ThePinyinofChineseCharacters {
    NSString *str = [self transform:@"学习"];
    NSLog(@"### %@ ###", str);
}
- (NSString *)transform:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}
#pragma mark - iOS跳转到App Store下载应用评分
- (void)ApplicationScore {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APPID"] options:@{@"1":@"1"} completionHandler:nil];
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
