//
//  NSURL+LMYHybrid.m
//  HybridAppOC
//
//  Created by lmy on 2018/4/17.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "NSURL+LMYHybrid.h"

@implementation NSURL (LMYHybrid)

/// 获取URL参数字典
///
/// - Returns: URL参数字典
- (NSMutableDictionary *)hybridURLParamsDic{
    NSArray *paramArray = [self.query componentsSeparatedByString:@"&"];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithCapacity:1];
    for (NSString *str in paramArray) {
        NSArray *tempArray = [str componentsSeparatedByString:@"="];
        if (tempArray.count == 2) {
            [paramDic setObject:tempArray[1] forKey:tempArray[0]];
        }
    }
    return paramDic;
}



@end
