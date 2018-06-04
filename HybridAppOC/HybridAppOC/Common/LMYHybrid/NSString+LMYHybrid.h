//
//  NSString+LMYHybrid.h
//  HybridAppOC
//
//  Created by lmy on 2018/4/17.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LMYHybrid)
- (NSString*)hybridUrlPathAllowedString;
- (NSString *)hybridDecodeURLString;
- (NSDictionary *)hybridDecodeJsonStr;
- (NSString *)hybridURLString:(NSDictionary *)params;
@end
