//
//  LMYHybridToos.h
//  HybridAppOC
//
//  Created by lmy on 2018/4/17.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnumTool.h"

#define Hybrid_DIRECTION(XX) \
XX(Forward, ) \
XX(Back, ) \
XX(ShowHeader,) \
XX(UpdateHeader, = 100) \

DECLARE_ENUM(RAPDirection, Hybrid_DIRECTION)


@interface LMYHybridToos : NSObject
+ (NSMutableDictionary *)readSetting;
- (NSArray *)contentResolver:(NSString *)urlString appendParams:(NSDictionary *)params;
- (void)analysisUrl:(NSString*)urlString webView:(UIWebView *)webView appendParams:(NSDictionary *)appendParams;
@end
