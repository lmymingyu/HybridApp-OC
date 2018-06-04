//
//  UIViewController+LMYHybrid.m
//  HybridAppOC
//
//  Created by lmy on 2018/4/20.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "UIViewController+LMYHybrid.h"

@implementation UIViewController (LMYHybrid)

+ (UIViewController *)currentViewController:(UIViewController *)viewController{
    if (viewController == nil) {
        viewController = UIApplication.sharedApplication.keyWindow.rootViewController;
    }
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)viewController;
        return  [self currentViewController:nav.visibleViewController];
    }else if([viewController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tab = (UITabBarController *)viewController;
        return [self currentViewController:tab.selectedViewController];
    }else if(viewController.presentedViewController != nil){
        return [self currentViewController:viewController.presentedViewController];
    }
    return viewController;
}

@end
