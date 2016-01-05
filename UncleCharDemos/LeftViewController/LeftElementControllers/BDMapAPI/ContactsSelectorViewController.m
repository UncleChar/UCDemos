//
//  ContactsSelectorViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/5.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "ContactsSelectorViewController.h"
#import "Masonry.h"
#import "DaiDodgeKeyboard.h"
#import "DivideContactsViewController.h"

#import "UserModel.h"
#import "GroupModel.h"

@interface ContactsSelectorViewController ()

@property (nonatomic, strong) UIView      *baseView;
@property (nonatomic, strong) UITextField *userAccount;
@property (nonatomic, strong) UITextField *userPassword;
@property (nonatomic, strong) UITextField *userPhone;
@property (nonatomic, strong) UITextField *userEmail;

@property (nonatomic, strong) NSMutableArray *userModelArr;
@property (nonatomic, strong) NSMutableArray *grouprModelArr;

@end

@implementation ContactsSelectorViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = 0;
//    self.navigationController.hidesBarsWhenKeyboardAppears = YES;
    
}
- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                              saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                              brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                   alpha:1];
    
    [self configNavItems];
    
    [self configUI];
    
    [self handleContactsData];
    
    
}

- (void)configNavItems {

    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(addContanctsBtnClicked)];
    rightItem.image = [UIImage imageNamed:@"contact_add_btnNormal@2x"];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
}

- (void)configUI {


     _userAccount = [[UITextField alloc]init];
    _userAccount.backgroundColor = [UIColor whiteColor];
    
     _userPassword = [[UITextField alloc]init];
    _userPassword.backgroundColor = [UIColor whiteColor];
    
     _userPhone = [[UITextField alloc]init];

     _userPhone.backgroundColor = [UIColor whiteColor];
    
     _userEmail = [[UITextField alloc]init];
     _userEmail.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_userPhone];
    [self.view addSubview:_userPassword];
    [self.view addSubview:_userEmail];
    [self.view addSubview:_userAccount];
    
    __weak typeof(self) weakSelf = self;
    int padding1 = 20;
    [_userAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(padding1);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-padding1);
        make.bottom.equalTo(_userPassword.mas_top).with.offset(- padding1);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(12 * padding1);
        make.height.mas_equalTo(@40);
        make.width.equalTo(_userPassword);
    }];
    [_userPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(padding1);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-padding1);
        make.top.equalTo(_userAccount.mas_bottom).with.offset(padding1);
        make.height.mas_equalTo(@40);
        make.width.equalTo(_userAccount);
    }];
    
    [_userEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(padding1);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-padding1);
        make.top.equalTo(_userPassword.mas_bottom).with.offset(padding1);
        make.height.mas_equalTo(@40);
        make.width.equalTo(_userPassword);
    }];
    [_userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(padding1);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-padding1);
        make.top.equalTo(_userEmail.mas_bottom).with.offset(padding1);
        make.height.mas_equalTo(@40);
        make.width.equalTo(_userPassword);
    }];
    
    UIImageView *avatarImg = [[UIImageView alloc]initWithFrame:CGRectMake(4, 2, 36, 36)];
    avatarImg.image = [UIImage imageNamed:@"one_avatar@2x"];
    _userAccount.leftViewMode = UITextFieldViewModeAlways;
    _userAccount.leftView = avatarImg;
    
    //添加观察者
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
    
   
}


- (void)handleContactsData {

    
    if (nil == _userModelArr) {
        
        _userModelArr = [NSMutableArray array];
    }
    
    if (nil == _grouprModelArr) {
        
        _grouprModelArr = [NSMutableArray array];
    }
    
    ///--------groupModel 货值-----------------

            
    
    
    for (int i = 0; i < 5; i ++) {
        
        GroupModel *gmodel = [[GroupModel alloc]init];
        
        gmodel.group_name = [NSString stringWithFormat:@"rose_%d",i];
        if (i % 3 == 0) {
            
            gmodel.invited = 1;
        }else {
        
            gmodel.invited = 0;
        }
 
        int k = arc4random() % 8 + 1;
        for (int j = 0;j < k ; j ++) {
            UserModel *model = [[UserModel alloc]init];
            
            model.avatar = @"http://b.zol-img.com.cn/desk/bizhi/image/1/960x600/13479490300.jpg";
            model.real_name = [NSString stringWithFormat:@"问ijack_%d",i];
            model.phone = [NSString stringWithFormat:@"1%ld",random() % 1000000000];
            gmodel.usersAtGroModel = model;
            
        }
        
        [_grouprModelArr addObject:gmodel];
        NSLog(@"%@,%@",gmodel.group_name,gmodel.usersAtGroModel.phone);
    }
    

    
    ///--------userModel 货值-----------------
    NSArray *arr =  @[@"张飞 No.1 StinCN.",
                      @"卢布 Valoran",
                      @"吕布 Noxus",
                      @"前程司机 ",
                      @"布拉德皮特 PT",
                      @"战争学院 The Institute of War",
                      @"祖安 Zaun",
                      @"巫毒之地 Voodoo Lands",
                      @"水晶之痕 Crystal Scar",
                      @"ss",
                      @"Chambers",
                      @"试炼之地Proving Grounds",
                      @"扭曲丛林 Twisted Treeline"];
    
    for(int i = 0;i < 25;i ++){
    
        UserModel *model = [[UserModel alloc]init];

        model.avatar = @"http://b.zol-img.com.cn/desk/bizhi/image/1/960x600/13479490300.jpg";
        
        if (i % 3 == 0) {
            
            model.invited = 1;
            model.sex = 0;
            model.real_name = arr[i / 3];
        }else {
        
            model.invited = 0;
            model.sex = 1;
            model.real_name = [NSString stringWithFormat:@"dsfnsiug_%d",i];
        }
        [_userModelArr addObject:model];
        
    }
    
    

}

- (void)addContanctsBtnClicked {

    DivideContactsViewController *divideVC = [[DivideContactsViewController alloc]init];
    divideVC.usersModelArray = _userModelArr;
    divideVC.groupsModelArray = _grouprModelArr;
    [self.navigationController pushViewController:divideVC animated:YES];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}










@end
