//
//  LoginViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/7.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "LoginViewController.h"
#import "UncleCharAppDelegate.h"
#import "YFGIFImageView.h"


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
@property (nonatomic, strong) UIImageView    *loginHeadImg;

@property (nonatomic, assign) CGFloat       btnMaxY;


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

    [self configLoginVCUI];
    
  
}


- (void)configLoginVCUI {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    _baseView = [[UIView alloc]initWithFrame:self.view.frame];
    _baseView.alpha = 0.0;
    [self.view addSubview:_baseView];
    
//            NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_head.gif" ofType:nil]];
//            _loginHeadGif = [[YFGIFImageView alloc]init];
//            _loginHeadGif.backgroundColor = [UIColor whiteColor];
//            _loginHeadGif.gifData = gifData;
//            _loginHeadGif.layer.cornerRadius = 6;
//            _loginHeadGif.layer.masksToBounds = 1;


    _loginHeadImg = [[UIImageView alloc]init];
    _loginHeadImg.image = [UIImage imageNamed:@"head_login.jpg"];
    _loginHeadImg.layer.cornerRadius = 6;
    _loginHeadImg.layer.masksToBounds = 1;
    _loginHeadImg.backgroundColor = [UIColor blackColor];


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
    _userPassword.secureTextEntry = YES;

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
    
    

//            [_baseView addSubview:_loginHeadGif];
    [_baseView addSubview:_loginHeadImg];
    [_baseView addSubview:_userAccount];
    [_baseView addSubview:_userPassword];
    [_baseView addSubview:_registerBtn];
    [_baseView addSubview:_loginBtn];

    
    
//        __weak typeof(self) weakSelf = self;
    int padding = 20;
//    *5 / 7
    [_loginHeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(_baseView.mas_centerX);
        make.left.equalTo(_baseView.mas_left).with.offset(_baseView.frame.size.width / 7);
        make.right.equalTo(_baseView.mas_right).with.offset(- _baseView.frame.size.width / 7);
        make.bottom.equalTo(_userAccount.mas_top).with.offset(- padding);
        make.top.equalTo(_baseView.mas_top).with.offset(_baseView.frame.size.height / 10);
        make.height.mas_equalTo(@(_baseView.frame.size.width / 7 * 5 /(820.0/470.0)));
    
        
    }];
 
    
    [_userAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_baseView.mas_centerX);
        make.left.equalTo(_baseView.mas_left).with.offset(padding);
        make.right.equalTo(_baseView.mas_right).with.offset(-padding);
        make.bottom.equalTo(_userPassword.mas_top).with.offset(- 1.5 * padding);
        make.top.equalTo(_loginHeadImg.mas_bottom).with.offset(padding);
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
        
//                [_loginHeadGif startGIF];
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
                        
//                        [SVProgressHUD showSuccessWithStatus:@"Success"];
                        
                        UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:[AppEngineManager sharedInstance].baseViewController];
                        [UncleCharAppDelegate getUncleCharAppDelegateDelegate].window.rootViewController = rootNav;
                        
                        NSUserDefaults *store = [NSUserDefaults standardUserDefaults];
                        [store setBool:YES forKey:kUserLoginStatus];
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
#pragma mark - keyboard events

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    
        _btnMaxY = CGRectGetMaxY(_loginBtn.frame);

    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if(_btnMaxY >(self.view.frame.size.height - kbHeight)) {
        
        [UIView animateWithDuration:duration + 0.3 animations:^{
            
            _baseView.frame = CGRectMake(_baseView.frame.origin.x,-( _btnMaxY - (self.view.frame.size.height - kbHeight) + 10), _baseView.frame.size.width, _baseView.frame.size.height);
            
        }];
    }
    //注明：这里不需要移除通知
}

- (void) keyboardWillHide:(NSNotification *)notify {
    
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration + 0.3 animations:^{
        _baseView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [_loginHeadGif removeFromSuperview];
//    _loginHeadGif = nil;
////    [self.view removeFromSuperview];
////    self.view = nil;
//}

@end
