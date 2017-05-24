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
//    [self allSubViewsForView:self.view];
    
}
#pragma mark - navigationBar根据滑动距离的渐变色实现
//第一种
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetToShow = 200.0;//滑动多少就完全显示
//    CGFloat alpha = 1 - (offsetToShow - scrollView.contentOffset.y) / offsetToShow;
//    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = alpha;
//}
//第二种
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetToShow = 200.0;
    CGFloat alpha = 1 - (offsetToShow - scrollView.contentOffset.y) / offsetToShow;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor orangeColor]colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
}
//生成一张纯色的图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark - 屏蔽触发事件，2秒后取消屏蔽
- (void)ignoringEvents {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}
#pragma mark - dispatch_group的使用
- (void)dispatch_groupUser {
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_enter(dispatchGroup);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"第一个请求完成");
        dispatch_group_leave(dispatchGroup);
    });
    
    dispatch_group_enter(dispatchGroup);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"第二个请求完成");
        dispatch_group_leave(dispatchGroup);
    });
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"请求完成");
    });
}
#pragma mark - 计算文件大小
//文件大小
- (long long)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path])
    {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    
    return 0;
}

//文件夹大小
- (long long)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    long long folderSize = 0;
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            if ([fileManager fileExistsAtPath:fileAbsolutePath])
            {
                long long size = [fileManager attributesOfItemAtPath:fileAbsolutePath error:nil].fileSize;
                folderSize += size;
            }
        }
    }
    
    return folderSize;
}
#pragma mark - 查找一个视图的所有子视图
- (NSMutableArray *)allSubViewsForView:(UIView *)view {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (UIView *subView in view.subviews)
    {
        [array addObject:subView];
        if (subView.subviews.count > 0)
        {
            [array addObjectsFromArray:[self allSubViewsForView:subView]];
        }
    }
    NSLog(@"### %@ ###", array);
    return array;
}
#pragma mark - 修改UITextField中Placeholder的字体颜色、大小
- (void)modifyTextfield {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH - 20, 20)];
    [textField setPlaceholder:@"Placeholder的文字颜色"];
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
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
