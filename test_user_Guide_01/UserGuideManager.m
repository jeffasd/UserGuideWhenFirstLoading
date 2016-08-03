//
//  UserGuidManager.m
//  test_user_Guide_01
//
//  Created by jeffasd on 16/8/1.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import "UserGuideManager.h"
#import "UserGuideModel.h"
#import "MJExtension.h"
#import "UserGuideItemModel.h"
#import "NSString+Size.h"

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height

typedef void(^CompleteBlock)(void);

@interface UserGuideManager ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) CAShapeLayer *userGuideLayer;

@property (nonatomic, copy) CompleteBlock completeBlock;

@property (nonatomic, weak) UIView *converView;

@end

@implementation UserGuideManager

+(instancetype)shareGuideManage{
    
    static UserGuideManager *_instance = nil;
    if (_instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

+(NSArray<UserGuideModel *> *)UserGuideModels{
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MovieSliceConfig" ofType:@"plist"];
    
    NSDictionary *movieSliceConfigDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
//    NSLog(@"movie is %@", movieSliceConfigDic);
    
    NSArray *userGuideDicArr = movieSliceConfigDic[@"userGuideModes"];

    NSArray<UserGuideModel *> *userGuideModelsArr = [UserGuideModel mj_objectArrayWithKeyValuesArray:userGuideDicArr];
    
    return userGuideModelsArr;

}

+ (UserGuideModel *)getUserGuideModelWithVCKey:(NSString *)vcKeyStr{
    
    NSArray<UserGuideModel *> *userGuideModelsArr = [self UserGuideModels];
    
    for (UserGuideModel *model in userGuideModelsArr) {
        
        if ([model.guideVCKey isEqualToString:vcKeyStr]) {
            
//            NSLog(@"the guidekey is %@", model.guideVCKey);
            
            return model;
        }
        
    }
    
    return nil;
}

//通过guideView来传递 引导页视图的中心位置的大小 中点
- (void)showItemsInView:(UIView *)view VCKeyStr:(NSString *)vcKeyStr FinishBlock:(void(^)())block{
    
    UserGuideModel *model = [[self class] getUserGuideModelWithVCKey:vcKeyStr];
    
//    NSLog(@"model is %@", model);

    if (view == nil) {
    
        NSAssert(view == nil, @"view can not be nil");
        
        NSLog(@"view can not be nil");
        return;
    }
    
    _backgroundView = view;
    
    if ([model.guideVCKey isEqualToString:@"ViewController"]) {
        
        //先将所有的guideItem内的内容构建完毕 再画焦点视图
        for (int i = 0; i < model.guideItmes.count; i++) {
            
            UserGuideItemModel *itemModel = model.guideItmes[i];
            
            [self createUIWithUserGuideItemModel:itemModel];
        }
        
        [self createMaskLayerWithSuperView:_backgroundView];
    }
    
    self.completeBlock = block;
    
}

- (void)createUIWithUserGuideItemModel:(UserGuideItemModel *)itemModel{
    
    //converView 添加到keyWindow上面
    UIView *converView = [UIView new];
    converView.frame = _backgroundView.bounds;
    converView.backgroundColor = [UIColor clearColor];
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:converView];
    
    self.converView = converView;
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor cyanColor];
    label.text = itemModel.guidLabelStr;
    int font = [itemModel.guidLabelFont intValue];
    label.font = [UIFont systemFontOfSize:font];
    CGSize labelSize = [label.text sizeWithFont:[UIFont systemFontOfSize:font] maxW:ScreenWidth];
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    CGPoint labelCenterPoint = CGPointMake(ScreenWidth * [itemModel.guidlabelCenterX floatValue], ScreenHeight * [itemModel.guidlabelCenterY floatValue]);
    label.center = labelCenterPoint;
    [converView addSubview:label];
    
    
    NSString *imageName = itemModel.guidImageName;
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGPoint imageCenterPoint = CGPointMake(ScreenWidth * [itemModel.guidImageCenterX floatValue], ScreenHeight * [itemModel.guidImageCenterY floatValue]);
    imageView.center = imageCenterPoint;
    [converView addSubview:imageView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:itemModel.guidBtnStr forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSString *btnStr = itemModel.guidBtnStr;
    font = [btn.titleLabel.font pointSize];
    CGSize btnSize = [btnStr sizeWithFont:[UIFont systemFontOfSize:font] maxW:ScreenWidth];
    btn.frame = CGRectMake(0, 0, btnSize.width * 2, btnSize.height * 2);
    CGPoint btnCenterPoint = CGPointMake(ScreenWidth * [itemModel.guidBtnCenterX floatValue], ScreenHeight * [itemModel.guidBtnCenterY floatValue]);
    btn.center = btnCenterPoint;
    [btn addTarget:self action:@selector(completeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [converView addSubview:btn];
    
    
}

- (void)completeBtnClick:(UIButton *)sender{
    
    if (_completeBlock) {
        
        [_converView removeFromSuperview];
        [_userGuideLayer removeFromSuperlayer];
        _completeBlock();
    }
}

- (void)createMaskLayerWithSuperView:(UIView *)superView{
    
    _userGuideLayer = [CAShapeLayer layer];
    
    _userGuideLayer.fillRule = kCAFillRuleEvenOdd;
    
    UIColor *color = [UIColor blackColor];
    color = [color colorWithAlphaComponent:0.8];
    _userGuideLayer.fillColor = color.CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:superView.frame];
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, superView.frame.size.height - 100, 100, 100)];
    [path appendPath:roundPath];
    
    _userGuideLayer.path = path.CGPath;
    
    [superView.layer addSublayer:_userGuideLayer];
    
}

@end
