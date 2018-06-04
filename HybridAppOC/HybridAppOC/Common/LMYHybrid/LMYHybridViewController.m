//
//  LMYHybridViewController.m
//  HybridAppOC
//
//  Created by lmy on 2018/4/17.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYHybridViewController.h"
#import "NSString+LMYHybrid.h"
#import "LMYHybridToos.h"
#import "LMYHybridWebView.h"

#define SCREENWIDTH    [UIScreen mainScreen].bounds.size.width;
#define SCREENHEIGHT   [UIScreen mainScreen].bounds.size.height;
@interface LMYHybridViewController ()

@property (nonatomic,retain)LMYHybridWebView *contentView;
@end

@implementation LMYHybridViewController


+ (LMYHybridViewController *)load:(NSString*)urlString sess:(NSString*)sess args:(NSDictionary*)args{
    
    NSURL *url = [NSURL URLWithString:urlString];
    LMYHybridViewController *webViewCtrl = [[LMYHybridViewController alloc] init];
    
    webViewCtrl.hidesBottomBarWhenPushed = YES;
    NSString *MLHYBRID_SCHEME = [LMYHybridToos readSetting][@"hybridScheme"];
    if (url.scheme == MLHYBRID_SCHEME) {
        //。。解析url
        NSArray *contentResolver = [[[LMYHybridToos alloc] init] contentResolver:urlString appendParams:nil];
        NSString *topageURL = contentResolver[1][@"topage"];
        if (topageURL.length > 0) {
            webViewCtrl.URLPath = [NSString stringWithFormat:@"%@?id=%@",topageURL,contentResolver[1][@"contentid"]];
            NSLog(@"%@",webViewCtrl.URLPath);
            return webViewCtrl;
        }else if(url.host != nil){
            webViewCtrl.URLPath = url.absoluteString;
            return webViewCtrl;
        }
    }else{
        if(args != nil){
            webViewCtrl.URLPath = [NSString stringWithFormat:@"%@?",url.absoluteString];
            for (int i = 0; i < args.allKeys.count; i++) {
                if (i != 0) {
                    webViewCtrl.URLPath = [NSString stringWithFormat:@"%@&%@=%@",webViewCtrl.URLPath,args.allKeys[i],args[args.allKeys[i]]];
                }else{
                    webViewCtrl.URLPath = [NSString stringWithFormat:@"%@%@=%@",webViewCtrl.URLPath,args.allKeys[i],args[args.allKeys[i]]];
                }
            }
            NSLog(@"%@",webViewCtrl.URLPath);
            //        webViewCtrl.URLPath = [NSString stringWithFormat:@"%@?name=%@",url.absoluteString,args[@"name"]];
            return webViewCtrl;
        }else{
            webViewCtrl.URLPath = url.absoluteString;
            return webViewCtrl;
        }
        
    }
    return nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contentView = [[LMYHybridWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height)];
    [self.view addSubview:_contentView];
    /*
    if self.URLPath == nil {
        setUrlPath()
    }
    if let path = self.URLPath {
        if let request = self.getRequest(urlString: path) {
            
            self.contentView.loadRequest(request)
        }
    }
     */
    if (self.URLPath == nil) {
        [self setURLPath];
    }
    NSLog(@"----url------%@",_URLPath);
    NSURLRequest *request = [self getRequestWithString:self.URLPath];
    NSLog(@"requst:%@",request);
    [self.contentView  loadRequest:request];
}
- (void)setURLPath{
    
}

-(NSURLRequest *)getRequestWithString:(NSString *)urlString{
//    NSString *urlStr = [urlString hybridUrlPathAllowedString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
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
