//
//  LMYHybridToos.m
//  HybridAppOC
//
//  Created by lmy on 2018/4/17.
//  Copyright © 2018年 lmy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LMYHybridToos.h"
#import "NSURL+LMYHybrid.h"
#import "NSString+LMYHybrid.h"
#import "UIViewController+LMYHybrid.h"
#import "LMYHybridViewController.h"
#import "NSDictionary+LMYHybrid.h"
//typedef enum FunctionType {
//    UpdateHeader,
//    Back,
//    Forward,
//    ShowHeader,
//    CheckVersion,
//    OldPay,
//    OnWebViewShow,
//    OnWebViewHide,
//    SwitchCache,
//    CurrentPosition,
//    //支付相关
//    PayByAlipay,
//    PayByWXpay,
//    iOSBuy,
//    PayCallBack,
//    //5.0新增
//    CopyLink,
//    GetLocation,
//    OpenMap,
//    Pop,
//    Openlink,
//    //5.1
//    Addtoclipboard,
//    //CRM
//    login,
//}FunctionType;

DEFINE_ENUM(RAPDirection, Hybrid_DIRECTION)
NSString *MLHYBRID_SCHEME = @"";
NSDictionary *NATIVEMAP = nil;
NSString *mainUrl = @"http://172.16.16.234:8080/#/";
//NSString *mainUrl = @"http://172.16.16.155:8085/#/";
NSString *HybridEvent = @"Hybrid.callback";
@implementation LMYHybridToos



//读取plist文件内容
+ (NSMutableDictionary *)readSetting {
    NSString *settingListPath = [[NSBundle mainBundle] pathForResource:@"LMYHybirdSettings" ofType:@"plist"];
    return [NSMutableDictionary dictionaryWithContentsOfFile:settingListPath];
}
/*
class func readViewMap() -> NSDictionary {
    let settingListPath: String = Bundle.main.path(forResource: "NativeViewMap", ofType:"plist")!
    return NSMutableDictionary(contentsOfFile:settingListPath)!
}
 */
+ (NSDictionary *)readViewMap{
    NSString *settingListPath = [[NSBundle mainBundle] pathForResource:@"NativeViewMap" ofType:@"plist"];
    return [NSMutableDictionary dictionaryWithContentsOfFile:settingListPath];
}

- (instancetype)init{
    if (self = [super init]) {
        //开始初始化
        MLHYBRID_SCHEME = [LMYHybridToos readSetting][@"hybridScheme"];
        NATIVEMAP = [LMYHybridToos readViewMap];
    }
    return self;
}

/// 解析hybrid指令
///
/// - Parameters:
///   - urlString: 原始指令串
///   - appendParams: 附加到指令串中topage地址的参数 一般情况下不需要
/// - Returns: 执行方法名、参数、回调ID


- (NSArray *)contentResolver:(NSString *)urlString appendParams:(NSDictionary *)params{
    NSURL *url = [NSURL URLWithString:urlString];
    if (params == nil) {
        params = [NSDictionary dictionary];
    }
    if (url.scheme == MLHYBRID_SCHEME) {
        NSString *functionName = url.host;
        NSDictionary *paramDic = [url hybridURLParamsDic];
        NSDictionary *args = [[paramDic[@"param"] hybridDecodeURLString] hybridDecodeJsonStr];
        NSString *newTooageURL = [args[@"topage"] hybridURLString:params];
        [args setValue:newTooageURL forKey:@"topage"];
        NSString *callBackId = paramDic[@"callback"];
        if (callBackId == nil) {
            callBackId = @"";
        }
        return [NSArray arrayWithObjects:functionName,args,callBackId, nil];
    }else{
        NSMutableDictionary *args = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"topage",urlString,@"type",@"h5", nil];
        NSString *newTopageURL = [urlString hybridURLString:params];
        [args setObject:newTopageURL forKey:@"topage"];
        return [NSArray arrayWithObjects: [NSNumber numberWithInt:Forward],args,@"",nil];
    }
    
    return nil;
}

/// 解析并执行hybrid指令
///
/// - Parameters:
///   - urlString: 原始指令串
///   - webView: 触发指令的容器
///   - appendParams: 附加到指令串中topage地址的参数 一般情况下不需要
- (void)analysisUrl:(NSString*)urlString webView:(UIWebView *)webView appendParams:(NSDictionary *)appendParams{
    
    if (urlString.length > 0) {
        NSArray *contentResolver = [self contentResolver:urlString appendParams:appendParams];
        [self handleEvent:contentResolver[0] args:contentResolver[1] callbackID:contentResolver[2] webView:webView];
    }
}

/// 根据指令执行对应的方法
///
/// - Parameters:
///   - funType: 方法名
///   - args: 参数
///   - callbackID: 回调Id
///   - webView: 执行函数的容器

- (void)handleEvent:(NSString *)funType args:(NSDictionary *)args callbackID:(NSString *)callbackId webView:(UIWebView *)webView{
    NSLog(@"\n****************************************");
    NSLog(@"funType    === %@",funType);
    NSLog(@"args       === %@",args);
    NSLog(@"callbackID === %@",callbackId);
    NSLog(@"****************************************\n");
    RAPDirection type = RAPDirectionFromNSString(funType);
//    int type = [funType intValue];
    switch (type) {
        case Forward:
            [self forwardWithArgs:args];
            break;
        case ShowHeader:
            NSLog(@"ShowHeader");
            [self setNavigationBarHiddenWithArgs:args callbackID:callbackId webView:webView];
            break;
        default:
            break;
    }
}

- (void)forwardWithArgs:(NSDictionary *)args{
    if ([args[@"type"] isEqual: @"H5"]) {
        NSString *url = args[@"topage"];
        NSString *absoluteUrl;
//        if ([url hasSuffix:@".html"]) {
//            absoluteUrl = [NSString stringWithFormat:@"%@%@",mainUrl,url];
//        }else{
//            absoluteUrl = [NSString stringWithFormat:@"%@%@.html",mainUrl,url];
//        }
        if ([url hasPrefix:@"http"]) {
            absoluteUrl = url;
        }else{
//            NSString *maUrl = [mainUrl hybridDecodeURLString];
            
            absoluteUrl = [NSString stringWithFormat:@"%@%@",mainUrl,url];
            absoluteUrl = [absoluteUrl hybridDecodeURLString];
        }
        NSLog(@"-=-=-=-=-=%@",absoluteUrl);
        LMYHybridViewController *webViewCtrl = [LMYHybridViewController load:absoluteUrl sess:nil args:args];
        NSString *animate = args[@"animate"];
        if ([animate isEqual:@"present"]) {
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:webViewCtrl];
            [[UIViewController currentViewController:nil] presentViewController:nav animated:YES completion:nil];
        }else{
            UINavigationController *navVC = [self currentNavigationController];
            UIViewController *vc = (LMYHybridViewController*)navVC.viewControllers.lastObject;
            [navVC pushViewController:webViewCtrl animated:YES];
        }
    }else if([args[@"type"] isEqualToString:@"native"]){
        NSString *url = args[@"topage"];
        NSString *viewVCString = NATIVEMAP[url];
        NSLog(@"%@",viewVCString);
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:viewVCString];
        UIViewController *currVC = [UIViewController currentViewController:nil];
        [currVC.navigationController pushViewController:vc animated:YES];
        
    }
}

//设置header
- (void)setNavigationBarHiddenWithArgs:(NSDictionary *)args callbackID:(NSString *)callbackID webView:(UIWebView *)webView{
    BOOL hidden = [args[@"display"] intValue];
    NSLog(@"%@---------%d",args[@"display"],hidden);
    BOOL animated = [args[@"animate"] intValue];
    UIViewController *vc = [self viewControllerWithView:webView];
    if ([vc.navigationController.viewControllers.lastObject isEqual:vc]) {
        [vc.navigationController setNavigationBarHidden:hidden animated:animated];
    }
    [vc.navigationController setNavigationBarHidden:hidden];
    [vc.view setNeedsLayout];
    
}
/*
func updateHeader(_ args: [String: AnyObject], webView: UIWebView) {
    
    if let header = Hybrid_headerModel.yy_model(withJSON: args) {
        if let titleModel = header.title, let rightButtons = header.right, let leftButtons = header.left {
            let navigationItem = self.viewControllerOf(webView).navigationItem
            if titleModel.tagname == "searchbox" {
                navigationItem.leftBarButtonItem = nil
                let naviTitleView = HybridNaviTitleView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 16, height: 44))
                let navigationItem = self.viewControllerOf(webView).navigationItem
                let searchBox = HybridSearchBox(frame: naviTitleView.bounds)
                searchBox.initSearchBox(navigationItem, titleModel: titleModel, currentWebView: webView, right: rightButtons)
                naviTitleView.addSubview(searchBox)
                navigationItem.titleView = naviTitleView
            }
            else {
                if titleModel.isCustom() {
                    navigationItem.titleView = self.setUpNaviTitleView(titleModel,webView: webView)
                } else {
                    self.viewControllerOf(webView).title = titleModel.title
                }
                
                if let subviews = self.viewControllerOf(webView).navigationController?.navigationBar.subviews {
                    for view in subviews {
                        if view is UIButton {
                            //移除旧的按钮
                            view.removeFromSuperview()
                        }
                    }
                }
                self.setRightButtons(rightButtons, navigationItem: navigationItem, webView: webView)
                self.setLeftButtons(leftButtons, navigationItem: navigationItem, webView: webView)
            }
        }
    }
    
}
 */

- (void)updateHeaderWithArgs:(NSDictionary *)args webView:(UIWebView *)webView{
    
}


/// 执行回调
///
/// - Parameters:
///   - data: 回调数据
///   - err_no: 错误码
///   - msg: 描述
///   - callback: 回调方法
///   - webView: 执行回调的容器
/// - Returns: 回调执行结果

- (NSString *)callBackData:(NSDictionary *)data err_no:(int)err_no msg:(NSString *)msg callBack:(NSString *)callBack webView:(UIWebView *)webView{
    NSDictionary *callBackData = @{@"data":data,
                                   @"errno":[NSNumber numberWithInt:err_no],
                                   @"msg":msg,
                                   @"callback":callBack};
    NSString *dataStr = [callBackData hybridJSONString];
    return  [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@(%@)",HybridEvent,dataStr]];
    
}
//获取viewcontroller
- (UIViewController *)viewControllerWithView:(UIView *)view{
    UIResponder* nextResponder = view.nextResponder;
    while (![nextResponder isKindOfClass:[UIViewController class]]) {
        nextResponder = nextResponder.nextResponder;
    }
    return (UIViewController*)nextResponder;
}

//获取当前页面navVC
-(UINavigationController *)currentNavigationController{
    UIViewController *vc = [UIViewController currentViewController:nil];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)vc;
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController *currVC= (UITabBarController *)vc;
        UIViewController *tabVC = [currVC viewControllers][currVC.selectedIndex];
        if ([tabVC isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)tabVC;
        }else {
            return tabVC.navigationController;
        }
    }else{
        return vc.navigationController;
    }
    return  nil;
}
@end
