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
    
    

    [_baseView addSubview:_userAccount];
    [_baseView addSubview:_userPassword];
    [_baseView addSubview:_registerBtn];
    [_baseView addSubview:_loginBtn];

    
    
        __weak typeof(self) weakSelf = self;
    int padding = 20;
    
    [_userAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_baseView.mas_centerX);
        make.left.equalTo(_baseView.mas_left).with.offset(padding);
        make.right.equalTo(_baseView.mas_right).with.offset(-padding);
        make.bottom.equalTo(_userPassword.mas_top).with.offset(- 1.5 * padding);
        make.top.equalTo(_baseView.mas_top).with.offset(weakSelf.view.frame.size.height / 4);
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
        
    }];
    
    [_registerBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}


//- (void)addContanctsBtnClicked {
//    
//    DivideContactsViewController *divideVC = [[DivideContactsViewController alloc]init];
//    divideVC.usersModelArray = _userModelArr;
//    divideVC.groupsModelArray = _grouprModelArr;
//    divideVC.catchBlock = ^(NSMutableArray *modelsArray){
//        
//        NSLog(@"model %@",modelsArray);
//    };
//    [self.navigationController pushViewController:divideVC animated:YES];
//    
//}

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
                // time-consuming task
                [NSThread sleepForTimeInterval:2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ([_userAccount.text isEqualToString:@"unclechar"] && [_userPassword.text isEqualToString:@"123456"]) {
                        
                        [SVProgressHUD showSuccessWithStatus:@"Success"];

                        UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:[AppEngineManager sharedInstance].baseViewController];
                        AppBaseViewController *app = [AppEngineManager sharedInstance].baseViewController;
                        app.navigationController.navigationBarHidden = 1;
                        [self.navigationController pushViewController:app animated:YES];
 
                    }else {
                    
                        [SVProgressHUD showErrorWithStatus:@"Account or password error"];
                         UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:[AppEngineManager sharedInstance].baseViewController];


                        [UncleCharAppDelegate getUncleCharAppDelegateDelegate].window.rootViewController = rootNav;
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


@end
