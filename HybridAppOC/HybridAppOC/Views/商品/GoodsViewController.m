//
//  ViewController3.m
//  HybridAppOC
//
//  Created by lmy on 2018/4/26.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "GoodsViewController.h"
#import "LMYHybridViewController.h"
#import "LLSegmentBarVC.h"
@interface GoodsViewController ()
@property (nonatomic,weak) LLSegmentBarVC * segmentVC;//
@end

@implementation GoodsViewController

#pragma mark - segmentVC
- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        LLSegmentBarVC *vc = [[LLSegmentBarVC alloc]init];
        // 添加到到控制器
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavItem];
}
#pragma mark - 定制导航条内容
- (void) customNavItem {
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"compose_camerabutton_background"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    // 1 设置segmentBar的frame
    self.segmentVC.segmentBar.frame = CGRectMake(100, 0, kScreen_Width-200, 35);
    self.navigationItem.titleView = self.segmentVC.segmentBar;
    // 2 添加控制器的View
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    NSArray *items = @[@"推荐", @"分类"];
    LMYHybridViewController *follow = [LMYHybridViewController load:@"http://172.16.16.155:8085/#/left" sess:nil args:nil];
    LMYHybridViewController *hot
    = [LMYHybridViewController load:@"http://172.16.16.155:8085/#/category" sess:nil args:nil];
    // 3 添加标题数组和控住器数组
    [self.segmentVC setUpWithItems:items childVCs:@[follow,hot]];
    // 4  配置基本设置  可采用链式编程模式进行设置
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor([UIColor lightGrayColor]).itemSelectColor([UIColor blackColor]).indicatorColor([UIColor blackColor]);
    }];
}

- (void)rightAction {
    
}
- (void)leftAction {
    //    PGGTestViewController *test = [[PGGTestViewController alloc] init];
    //    [self.navigationController pushViewController:test animated:YES];
}
//- (void)setURLPath{
//    self.URLPath = @"http://172.16.16.234:8080/#/";
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
