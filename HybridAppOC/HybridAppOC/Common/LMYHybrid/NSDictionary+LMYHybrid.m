//
//  NSDictionary+LMYHybrid.m
//  HybridAppOC
//
//  Created by lmy on 2018/4/26.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "NSDictionary+LMYHybrid.h"

@implementation NSDictionary (LMYHybrid)
/// 字典转JSON字符串
///
/// - Returns: JSON字符串
/*
func hybridJSONString() -> String {
    if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) {
        if let strJson = String(data: jsonData, encoding: .utf8) {
            return strJson
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}
 */
- (NSString *)hybridJSONString{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (jsonStr != nil) {
        return jsonStr;
    }else{
        return @"";
    }
}
@end
