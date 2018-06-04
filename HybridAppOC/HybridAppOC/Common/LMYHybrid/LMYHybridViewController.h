//
//  LMYHybridViewController.h
//  HybridAppOC
//
//  Created by lmy on 2018/4/17.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMYHybridViewController : UIViewController
@property (nonatomic,copy) NSString *URLPath;//webview加载地址


+ (LMYHybridViewController *)load:(NSString*)urlString sess:(NSString*)sess args:(NSDictionary*)args;
- (void)setURLPath;
@end
