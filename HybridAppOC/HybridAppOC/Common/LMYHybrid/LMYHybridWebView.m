//
//  LMYHybridWebView.m
//  HybridAppOC
//
//  Created by lmy on 2018/4/18.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYHybridWebView.h"
#import "LMYHybridToos.h"
@interface LMYHybridWebView ()
@property (nonatomic, retain) LMYHybridToos *tools;
@end
@implementation LMYHybridWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tools = [[LMYHybridToos alloc] init];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.scrollView.bounces = false;
    self.translatesAutoresizingMaskIntoConstraints = false;
    self.keyboardDisplayRequiresUserAction = false;
    self.scalesPageToFit = true;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *MLHYBRID_SCHEME = [LMYHybridToos readSetting][@"hybridScheme"];
    NSLog(@"%@",request.URL.absoluteString);
    if ([request.URL.absoluteString hasPrefix:[NSString stringWithFormat:@"%@://",MLHYBRID_SCHEME]]) {
        
        [_tools analysisUrl:request.URL.absoluteString webView:webView appendParams:nil];
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
