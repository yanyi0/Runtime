//
//  LNPerson.m
//  RunTime
//
//  Created by Cloud on 2020/7/13.
//  Copyright © 2020 cloud. All rights reserved.
//

#import "LNPerson.h"
#include <objc/runtime.h>
@implementation LNPerson

/*
说明：
eat(无参) 和 run(有参NSInteger) 是 LNPerson模型类中的私有方法「runtime 作用：可以调用私有方法」
示例分别以 OC写法 和 最底层写法 对照验证.
 */
- (void)msgSend
{
    // 方法一：
    //id objc = [NSObject alloc];
    LNPerson *person = objc_msgSend(objc_getClass("LNPerson"), sel_registerName("alloc"));

    //objc = [objc init];
    person = objc_msgSend(person, sel_registerName("init"));

    // 调用
    //[objc eat];
    //[objc run:10];
    objc_msgSend(person,@selector(eat)); // 无参
    objc_msgSend(person,@selector(run:),10); // 有参
}
/*
 注解：
    // 用最底层写
    objc_getClass(const char *name) 获取当前类
    sel_registerName(const char *str) 注册个方法编号
    objc_msgSend(id self：谁发送消息, SEL op：发送什么消息, ...)
    让LNPerson这个类对象发送了一个alloc消息，返回一个分配好的内存对象给你，再发送一个消息初始化.
 */
// 方法二：
#pragma mark - 也许下面这种好理解一点
- (void)test
{
    // id objc = [NSObject alloc];
    id objc = objc_msgSend([NSObject class], @selector(alloc));

    // objc = [objc init];
    objc = objc_msgSend(objc, @selector(eat));

}
@end
