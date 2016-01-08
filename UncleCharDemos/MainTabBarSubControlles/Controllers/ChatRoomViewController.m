//
//  ChatRoomViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/8.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "ChatRoomViewController.h"

@interface ChatRoomViewController ()

@property (nonatomic, strong) UIView       *inputBoxView;
@property (nonatomic, assign) CGFloat       inputBoxViewMinY;
@property (nonatomic, strong) UITextField  *inputTF;

@end

@implementation ChatRoomViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self configChatRoomVCUI];
    
    
}


- (void)configChatRoomVCUI {

    self.title = self.chatRoomTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _inputBoxView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 40, kScreenWidth, 40)];
    _inputBoxView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self.view addSubview:_inputBoxView];
    
    _inputTF = [[UITextField alloc]init];
    _inputTF.layer.cornerRadius = 6;
    _inputTF.layer.masksToBounds = 1;
    _inputTF.backgroundColor = [UIColor whiteColor];
    [_inputBoxView addSubview:_inputTF];
    
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputBoxView.mas_left).with.offset(10);
        make.top.equalTo(_inputBoxView.mas_top).with.offset(5);
        make.bottom.equalTo(_inputBoxView.mas_bottom).with.offset(-5);
        make.right.equalTo(_inputBoxView.mas_right).with.offset(-5);
        
    }];
    
    
    
}


#pragma mark - keyboard events

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    
    _inputBoxViewMinY = CGRectGetMinY(_inputBoxView.frame);
    
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
        [UIView animateWithDuration:duration animations:^{

            _inputBoxView.frame = CGRectMake(0, _inputBoxViewMinY - kbHeight, kScreenWidth, 40);
            
        }];
    //注明：这里不需要移除通知
}

- (void) keyboardWillHide:(NSNotification *)notify {
    
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{

         _inputBoxView.frame = CGRectMake(0, _inputBoxViewMinY, kScreenWidth, 40);
    }];
}




- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [_inputTF resignFirstResponder];
}


@end
