//
//  NSMutableDictionary+NullSafe.m
//  CircleBut
//
//  Created by 黄华 on 2018/1/18.
//  Copyright © 2018年 huanghua. All rights reserved.
//

#import "NSMutableDictionary+NullSafe.h"
#import <objc/runtime.h>



//定义常量 必须是C语言字符串
static char *NAMEKEY = "nameSting_key";

@interface NSMutableDictionary()

@end


@implementation NSMutableDictionary (NullSafe)

//添加一个属性
-(NSString*)name{
    return objc_getAssociatedObject(self, NAMEKEY);
}

-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, NAMEKEY, name, OBJC_ASSOCIATION_COPY);
}




- (void)swizzleMethod:(SEL)orignSelector withMethod:(SEL)newSelector{
    
    Class class = [self class];
    //取得被替换方法
    Method orignselect  = class_getInstanceMethod(class, orignSelector);
    //替换方法
    Method newselect  = class_getInstanceMethod(class, newSelector);
    
    //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
    BOOL didAddMethod = class_addMethod(class, orignSelector, method_getImplementation(newselect), method_getTypeEncoding(newselect));

    if (didAddMethod) {
        //添加成功：将源方法的实现替换到交换方法的实现
        class_replaceMethod(class, newSelector, method_getImplementation(orignselect), method_getTypeEncoding(orignselect));
    }else{
        //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
        method_exchangeImplementations(orignselect, newselect);
    }
}


+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id object = [[self alloc] init];
        [object swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(safe_setObject:ForKey:)];
    });
}


- (void)safe_setObject:(id)value ForKey:(NSString *)key{
    
    if (value) {
        [self safe_setObject:value ForKey:key];
    }else{
        NSLog(@"[NSMutableDictionary setObject: forKey:],Object cannot be nil]");
    }
}

@end
