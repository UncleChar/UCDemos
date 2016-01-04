//
//  MasonryViewController.m
//  UncleCharDemos
/*
 这里是Masonry给我们的属性
 
 @property (nonatomic, strong, readonly) MASConstraint *left;         //左侧
 
 @property (nonatomic, strong, readonly) MASConstraint *top;        //上侧
 
 @property (nonatomic, strong, readonly) MASConstraint *right;      //右侧
 
 @property (nonatomic, strong, readonly) MASConstraint *bottom;   //下侧
 
 @property (nonatomic, strong, readonly) MASConstraint *leading;   //首部
 
 @property (nonatomic, strong, readonly) MASConstraint *trailing;   //尾部
 
 @property (nonatomic, strong, readonly) MASConstraint *width;     //宽
 
 @property (nonatomic, strong, readonly) MASConstraint *height;    //高
 
 @property (nonatomic, strong, readonly) MASConstraint *centerX;  //横向居中
 
 @property (nonatomic, strong, readonly) MASConstraint *centerY;  //纵向居中
 
 @property (nonatomic, strong, readonly) MASConstraint *baseline; //文本基线
 
 
 
 //新增约束
 - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;
 
 //更新约束
 - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;
 
 //清楚之前的所有约束,只会保留最新的约束
 - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
 
 合理的利用这个3个函数，基本上可以应对任何情况了
 
 */
//  Created by LingLi on 15/12/29.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "MasonryViewController.h"
#import "ConfigUITools.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@implementation MasonryViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = 0;
    self.navigationController.hidesBarsWhenKeyboardAppears = YES;
    
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [ConfigUITools colorWithR:46 G:211 B:186 A:1.0];
    __weak typeof(self) weakSelf = self;
    
//    UIView *bgView = [[UIView alloc]init];
//    bgView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:bgView];
////    WS(ws);
//    UIView *bgView1 = [[UIView alloc]init];
//    bgView1.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:bgView1];
//    
//    //使用mas_makeConstraints添加约束
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.centerX.equalTo(weakSelf.view);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.top.width.offset(100);
//        
//    }];
    
    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 20)];
    text.backgroundColor = [UIColor redColor];
    [self.view addSubview:text];
    
//我们来设置一个基于父视图间距为10的view
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(weakSelf.view);
//        make.edges.mas_offset(UIEdgeInsetsMake(76, 10, 10, 10));
//    }];
//    [bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.size.mas_equalTo(CGSizeMake(150, 150));
//        make.centerX.equalTo(bgView);
//        make.top.equalTo(bgView.mas_bottom).with.offset(20);
//        
//        
//    }];
//    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
    self.navigationController.navigationBarHidden = NO;
}



















@end
