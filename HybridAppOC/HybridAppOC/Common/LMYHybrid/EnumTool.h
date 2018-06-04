//
//  EnumTool.h
//  HybridAppOC
//
//  Created by lmy on 2018/4/20.
//  Copyright © 2018年 lmy. All rights reserved.
//

#ifndef EnumTool_h
#define EnumTool_h

#pragma mark - Enum Factory Macros

/**
 定义一个枚举case
 */
#define ENUM_VALUE(name, assign) name assign,

/**
 展开后是一个switch语句的case，返回一个字符串
 */
#define ENUM_CASE(name, assign) case name: return @#name;

/**
 展开后通过比较字符串，返回相应枚举case
 */
#define ENUM_STRCMP(name, assign) if ([string isEqualToString:@#name]) return name;

/**
 定义枚举，声明反射函数；
 */
#define DECLARE_ENUM(EnumType, ENUM_DEF) \
typedef NS_ENUM(NSInteger, EnumType) { \
ENUM_DEF(ENUM_VALUE) \
}; \
NSString *NSStringFrom##EnumType(EnumType value); \
EnumType EnumType##FromNSString(NSString *string); \

/**
 实现实现函数；
 */
#define DEFINE_ENUM(EnumType, ENUM_DEF) \
NSString *NSStringFrom##EnumType(EnumType value) \
{ \
switch(value) \
{ \
ENUM_DEF(ENUM_CASE) \
default: return @""; \
} \
} \
EnumType EnumType##FromNSString(NSString *string) \
{ \
ENUM_DEF(ENUM_STRCMP) \
return (EnumType)0; \
}



#endif /* EnumTool_h */
