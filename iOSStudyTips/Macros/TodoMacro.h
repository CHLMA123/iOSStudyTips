//
//  TodoMacro.h
//  iOSStudyTips
//
//  Created by CHLMA2015 on 2017/8/19.
//  Copyright © 2017年 MACHUNLEI. All rights reserved.
//

#ifndef TodoMacro_h
#define TodoMacro_h

// 转成字符串
#define STRINGIFY(S) #S
// 需要解两次才解开的宏
#define DEFER_STRINGIFY(S) STRINGIFY(S)

#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))

// 为warning增加更多信息
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)

// 使宏前面可以加@
#define KEYWORDIFY try {} @catch (...) {}

// 最终使用的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#endif /* TodoMacro_h */

////////////////实现一个能产生warning的TODO宏，用于在代码里做备忘//////////////////////
/*
 http://blog.sunnyxx.com/2015/03/01/todo-macro/
 手动让编译器报警（报错）可以用以下几个方法：
 
 #warning chlma
 #error chlma
 #pragma message "chlma"
 #pragma GCC warning "chlma"
 #pragma GCC error "chlma"
 
 但，带#的预处理指令是无法被#define的。
 好在C99提供了一个_Pragma运算符可以把部分#pragma指令字符串化：
 
 #pragma message "chlma"
 // 等价于
 _Pragma("message \"sunnyxx\"") // 需要注意双引号的转义
 // 或
 _Pragma("message(\"sunnyxx\")") // 需要注意双引号的转义
 
 利用上边这个特性，我们就可以将warning定义成宏：
 
 #define SOME_WARNING _Pragma("message(\"chlma\")")

// 接下来，我们让这个宏能够接受入参，并显示到warning中去

 */
