//
//  NSMutableDictionary+NullSafe.h
//  CircleBut
//
//  Created by 黄华 on 2018/1/18.
//  Copyright © 2018年 huanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NullSafe)

@property (nonatomic,copy)NSString *name;

- (void)swizzleMethod:(SEL)orignSelector withMethod:(SEL)newSelector;

@end
