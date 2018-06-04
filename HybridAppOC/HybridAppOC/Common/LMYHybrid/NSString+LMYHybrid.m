//
//  NSString+LMYHybrid.m
//  HybridAppOC
//
//  Created by lmy on 2018/4/17.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "NSString+LMYHybrid.h"
#import "NSURL+LMYHybrid.h"
@implementation NSString (LMYHybrid)
- (NSString*)hybridUrlPathAllowedString{

    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)hybridDecodeURLString{
    NSMutableString *mutStr = [NSMutableString stringWithString:self];
    return [mutStr stringByRemovingPercentEncoding];
}

- (NSDictionary *)hybridDecodeJsonStr{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (self.length > 0) {
        return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
    }
    return [NSDictionary dictionary];
}

- (NSString *)hybridURLString:(NSDictionary *)params{
    NSURL * topageURL = [NSURL URLWithString:self];
    NSDictionary *paramsDic = [topageURL hybridURLParamsDic];
    for (NSString *key in params.allKeys) {
        NSString *value = params[key];
        [paramsDic setValue:value forKey:key];
    }
    NSMutableArray *paramsArray = [NSMutableArray array];
    for (NSString *key in paramsDic.allKeys) {
        NSString *value = params[key];
        [paramsArray addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    //将数组转化为字符串以&分割
    NSString *paramsString = [paramsArray componentsJoinedByString:@"&"];
    NSString *host = topageURL.host;
    NSString *scheme = topageURL.scheme;
    if (paramsString.length > 0) {
        NSString *newTopageURL = [NSString stringWithFormat:@"%@://%@%@?%@",scheme,host,topageURL.path,paramsString];
        return newTopageURL;
    }
    return self;
}


@end
