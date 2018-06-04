//
//  LMYTabBar.h
//  HybridAppOC
//
//  Created by lmy on 2018/5/24.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMYTabBar;

@protocol LMYTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(LMYTabBar *)tabBar;

@end

@interface LMYTabBar : UITabBar

@property (nonatomic, strong)UIButton *plusBtn;
@property (nonatomic, weak)id <LMYTabBarDelegate> tabBarDelegate;

@end
