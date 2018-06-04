//
//  RootTabBarController.m
//  HybridAppOC
//
//  Created by lmy on 2018/5/24.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomeViewController.h"
#import "FindViewController.h"
#import "GoodsViewController.h"
#import "MineViewController.h"
@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LMYTabBar *tabBar = [[LMYTabBar alloc] init];
    tabBar.tabBarDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    UINavigationController *homeView = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    UINavigationController *findView = [[UINavigationController alloc] initWithRootViewController:[[FindViewController alloc] init]];
    UINavigationController *goodsView = [[UINavigationController alloc] initWithRootViewController:[[GoodsViewController alloc] init]];
    UINavigationController *mineView = [[UINavigationController alloc] initWithRootViewController:[[MineViewController alloc]init]];
    
    
    homeView.tabBarItem.image = [[UIImage imageNamed:@"tabbarIndex"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeView.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbarIndexSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeView.tabBarItem.title = @"首页";
    [homeView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [homeView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateSelected];
    
    findView.tabBarItem.image = [[UIImage imageNamed:@"tabbarDiscover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    findView.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbarDiscoverSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    findView.tabBarItem.title = @"发现";
    [findView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [findView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateSelected];
    
    goodsView.tabBarItem.image = [[UIImage imageNamed:@"tabbarLiving"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    goodsView.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbarLivingSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    goodsView.tabBarItem.title = @"生活";
    [goodsView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [goodsView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateSelected];
    
    mineView.tabBarItem.image = [[UIImage imageNamed:@"tabbarProfile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineView.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbarProfileSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineView.tabBarItem.title = @"我的";
    [mineView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [mineView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateSelected];
    
    
    [self.tabBar setTintColor:[UIColor whiteColor]];
    self.viewControllers = @[homeView,findView,goodsView,mineView];
    
    
}
- (void)tabBarDidClickPlusButton:(LMYTabBar *)tabBar
{
    NSLog(@"点击");
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
