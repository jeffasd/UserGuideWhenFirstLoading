//
//  ViewController.m
//  test_user_Guide_01
//
//  Created by jeffasd on 16/8/1.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UserGuideManager.h"
#import "JFHelpTools.h"

@interface ViewController ()

@property (nonatomic, weak) UIView *bottomView;

@property (nonatomic, weak) CAShapeLayer *maskLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self createUI];
    
    [self createMaskLayer];

    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    

//    [JFHelpTools compareCurrentVersionToStandBoxVersion];
    
    BOOL isFistLoading = [JFHelpTools currentVersionIsFirstLoading];
    
    if (isFistLoading) {
        [self showUserGuide];
    }
    
}

- (void)showUserGuide{
    
    UserGuideManager *manager = [UserGuideManager shareGuideManage];
    
    NSString *string = NSStringFromClass([self class]);
    
    [manager showItemsInView:self.view VCKeyStr:string FinishBlock:^{
        NSLog(@"complte ");
    }];
}

- (void)createUI{
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    self.bottomView = bottomView;
    
    UIView *circleView = [UIView new];
//    circleView.frame = CGRectMake(0, 0, 44, 44);
    circleView.backgroundColor = [UIColor blueColor];
    [bottomView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(circleView.superview).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
}

- (void)createMaskLayer{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.view.frame;
    
    layer.fillRule = kCAFillRuleEvenOdd;
    
    layer.fillColor = [UIColor orangeColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.frame];

    UIBezierPath *roundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, self.view.frame.size.height - 100, 100, 100)];
    [path appendPath:roundPath];
    
    layer.path = path.CGPath;
    [self.view.layer addSublayer:layer];
    
//    self.view.layer.mask = layer;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
