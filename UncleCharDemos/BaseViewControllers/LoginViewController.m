//
//  LoginViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/7.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "LoginViewController.h"
#import "UncleCharAppDelegate.h"
#import "AppBaseViewController.h"
#import "YFGIFImageView.h"
#import "AppEngineManager.h"
#import "Masonry.h"
#import "ConfigUITools.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()

@property (nonatomic, strong) UITextField  *userAccount;
@property (nonatomic, strong) UITextField  *userPassword;
//@property (nonatomic, strong) UITextField  *userPhone;
//@property (nonatomic, strong) UITextField  *userEmail;

@property (nonatomic, strong) UITextField  *firstResponderTF;
@property (nonatomic, strong) UIButton     *loginBtn;
@property (nonatomic, strong) UIButton     *registerBtn;
@property (nonatomic, strong) UIView       *baseView;

@property (nonatomic, strong) YFGIFImageView *loginHeadGif;


@end

@implementation LoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = 1;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [ConfigUITools colorRandomly];

    [self configUI];
    
  
}


- (void)configUI {
    
            _baseView = [[UIView alloc]initWithFrame:self.view.frame];
            _baseView.alpha = 0.0;
            [self.view addSubview:_baseView];
            
            NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_head.gif" ofType:nil]];
            _loginHeadGif = [[YFGIFImageView alloc]init];
            _loginHeadGif.backgroundColor = [UIColor whiteColor];
            _loginHeadGif.gifData = gifData;
            _loginHeadGif.layer.cornerRadius = 6;
            _loginHeadGif.layer.masksToBounds = 1;


            _userAccount = [[UITextField alloc]init];
            _userAccount.borderStyle = UITextBorderStyleRoundedRect;
            _userAccount.backgroundColor = [UIColor whiteColor];
            _userAccount.placeholder = @"Account";
            _userAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
            
            _userPassword = [[UITextField alloc]init];
            _userPassword.borderStyle = UITextBorderStyleRoundedRect;
            _userPassword.backgroundColor = [UIColor whiteColor];
            _userPassword.placeholder = @"Password";
            _userPassword.clearButtonMode = UITextFieldViewModeWhileEditing;

            _registerBtn = [[UIButton alloc]init];
            _registerBtn.backgroundColor = [ConfigUITools colorRandomly];
            [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
            _registerBtn.layer.cornerRadius = 6;
            _registerBtn.layer.masksToBounds = 1;
            _registerBtn.tag = 100 + 0;
            
            
            _loginBtn = [[UIButton alloc]init];
            _loginBtn.backgroundColor = [ConfigUITools colorRandomly];
            [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            _loginBtn.layer.cornerRadius = 6;
            _loginBtn.layer.masksToBounds = 1;
            _loginBtn.tag = 100 + 1;
            
            

            [_baseView addSubview:_loginHeadGif];
            [_baseView addSubview:_userAccount];
            [_baseView addSubview:_userPassword];
            [_baseView addSubview:_registerBtn];
            [_baseView addSubview:_loginBtn];

            
            
                __weak typeof(self) weakSelf = self;
            int padding = 20;
        //    *5 / 7
            [_loginHeadGif mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.centerX.mas_equalTo(_baseView.mas_centerX);
                make.left.equalTo(_baseView.mas_left).with.offset(weakSelf.view.frame.size.width / 7);
                make.right.equalTo(_baseView.mas_right).with.offset(- weakSelf.view.frame.size.width / 7);
                make.bottom.equalTo(_userAccount.mas_top).with.offset(- padding);
                make.top.equalTo(_baseView.mas_top).with.offset(weakSelf.view.frame.size.height / 10);
                make.height.mas_equalTo(@(weakSelf.view.frame.size.width / 7 * 5 /2.82));
            
                
            }];
         
            
            [_userAccount mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(_baseView.mas_centerX);
                make.left.equalTo(_baseView.mas_left).with.offset(padding);
                make.right.equalTo(_baseView.mas_right).with.offset(-padding);
                make.bottom.equalTo(_userPassword.mas_top).with.offset(- 1.5 * padding);
                make.top.equalTo(_loginHeadGif.mas_bottom).with.offset(padding);
                make.height.mas_equalTo(@40);
                make.width.equalTo(_userPassword);
            }];
            [_userPassword mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(_baseView.mas_centerX);
                make.left.equalTo(_baseView.mas_left).with.offset(padding);
                make.right.equalTo(_baseView.mas_right).with.offset(-padding);
                make.top.equalTo(_userAccount.mas_bottom).with.offset(1.5 * padding);
                make.height.mas_equalTo(@40);
                make.width.equalTo(_userAccount);
            }];
            
            [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_userPassword.mas_left).with.offset(padding);
                make.top.equalTo(_userPassword.mas_bottom).with.offset(1.5 *padding);
                make.right.equalTo(_loginBtn.mas_left).with.offset(-padding);
                make.height.mas_equalTo(@40);
                make.width.equalTo(_loginBtn);
                
            }];
            
            [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_registerBtn.mas_right).with.offset(padding);
                make.top.equalTo(_userPassword.mas_bottom).with.offset(1.5 * padding);
                make.right.equalTo(_userPassword.mas_right).with.offset(-padding);
                make.height.mas_equalTo(@40);
                make.width.equalTo(_registerBtn);
                
            }];
            
            
            [UIView animateWithDuration:2.0 animations:^{
                
                _baseView.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                [_loginHeadGif startGIF];
                [_registerBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                
            }];
  
}


- (void)contactBackBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loginBtnClicked:(UIButton *)sender {

    switch (sender.tag - 100) {
        case 0:
            
            
            break;
        case 1:
        {
            [self.view endEditing:YES];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [SVProgressHUD showWithStatus:@"Logging..."];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               
                
                [NSThread sleepForTimeInterval:2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ([_userAccount.text isEqualToString:@"123456"] && [_userPassword.text isEqualToString:@"123456"]) {
                        
                        [SVProgressHUD showSuccessWithStatus:@"Success"];

                        
                        UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:[AppEngineManager sharedInstance].baseViewController];
                        [UncleCharAppDelegate getUncleCharAppDelegateDelegate].window.rootViewController = rootNav;
                        
                        NSUserDefaults *store = [NSUserDefaults standardUserDefaults];
                        [store setBool:YES forKey:@"isLoginSuccess"];
                        [store synchronize];
 
                    }else {
                    
                        [SVProgressHUD showErrorWithStatus:@"Account or password error"];

                    }
                    
                });
            });
            
        }
            
            break;
            
        default:
            break;
    }
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
- (void)viewWillDisappear:(BOOL)animated {

    [_loginHeadGif removeFromSuperview];
    _loginHeadGif = nil;
//    [self.view removeFromSuperview];
//    self.view = nil;
}

@end
