//
//  LeftViewController.m
//  SlideLikeQQ
//
//  Created by UncleChar on 15/12/22.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "LeftViewController.h"
#import "fuckViewController.h"
#import "loveViewController.h"
#import "AppBaseViewController.h"
#import "AppEngineManager.h"
#import "UserSignViewController.h"
#import "RenewUserAvatarViewController.h"
#import "OperateDBViewController.h"
#import "MasonryViewController.h"
#import "LocationViewController.h"
#import "LocationVC.h"

#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray      *titleListArray;
@property (nonatomic, strong) UIView       *headView;
@property (nonatomic, strong) UIImageView  *avatarImageView;
@property (nonatomic, strong) UIImageView  *headBackgrooundImg;
@property (nonatomic, strong) UIImageView  *headImgView;
@property (nonatomic, strong) UILabel      *nameLabel;
@property (nonatomic, strong) UILabel     *signNameLabel;

@end

@implementation LeftViewController

- (void)viewWillAppear:(BOOL)animated {


}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configElementsUI];
    
    [self addTargetWithTapGesture];
    
    


    
}
- (void)configElementsUI {

    self.view.frame = CGRectMake(-kScreenWidth * 5 / 6, 0, kScreenWidth  * 5 / 6, kScreenHeight);
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 2)];
    [self.view addSubview:_headView];
    
    
    _headBackgrooundImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth * 5 / 6, kScreenWidth * 5 / 12)];
    //    _headBackgrooundImg.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255  blue:200.0/255  alpha:1.0];
    _headBackgrooundImg.alpha =1;
    [_headView addSubview:_headBackgrooundImg];
    
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 45, 50, 50)];
    _avatarImageView.image = [UIImage imageNamed:@"icon"];
    _avatarImageView.layer.cornerRadius = 25;
    _avatarImageView.layer.masksToBounds = 1;
    _avatarImageView.userInteractionEnabled = 1;
    [_headView addSubview:_avatarImageView];
    
    
    
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_avatarImageView.frame) + 10, _avatarImageView.center.y - 15, 100, 30)];
    _nameLabel.text = @"UncleChar";
    [_nameLabel setTextColor:[UIColor blackColor]];
    [_headView  addSubview:_nameLabel];
    
    
    
    _signNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_avatarImageView.frame) + (CGRectGetMaxY(_headView.frame) - CGRectGetMaxY(_avatarImageView.frame)) / 2 - 15, 200, 30)];
    _signNameLabel.textColor = [UIColor colorWithRed:253.0/255 green:229.0/255 blue:29.0/255 alpha:1];
    _signNameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSign"];
    _signNameLabel.userInteractionEnabled = 1;
    [_headView addSubview:_signNameLabel];
    
  
    
    _titleListArray = @[@"数据库测试-[FMDB]", @"MasonryTest", @"定位", @"Location", @"我的收藏", @"我的相册", @"我的文件"];
    
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headBackgrooundImg.frame),self.view.frame.size.width, self.view.frame.size.height-_headView.frame.size.height) style:UITableViewStylePlain];
    _listTableView.dataSource = self;
    _listTableView.delegate = self;
    _listTableView.backgroundColor = [UIColor colorWithRed:30.0/255 green:200.0/255 blue:249.0/255 alpha:1];
    _listTableView.alpha = 0.9;
    _listTableView.layer.cornerRadius = 5;
    _listTableView.layer.masksToBounds = 1;
    [self.view addSubview:_listTableView];

    
}

- (void)addTargetWithTapGesture {

    //给头像增加点按手势
    UITapGestureRecognizer *tapGestureWithAvatar = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(elementAvatarImgClicked)];
    [_avatarImageView addGestureRecognizer:tapGestureWithAvatar];
    
    //给个性签名增加点按手势
    UITapGestureRecognizer *tapGestureWithName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(elementNameLabelClicked)];
    [_signNameLabel addGestureRecognizer:tapGestureWithName];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titleListArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentify = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _titleListArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    AppBaseViewController *baseVC = [AppEngineManager sharedInstance].baseViewController;
    [baseVC homeControllerAppear];

    switch (indexPath.row) {
        case 0:
        {
        
            OperateDBViewController *vc = [[OperateDBViewController alloc]init];
            vc.navigationTitle = _titleListArray[indexPath.row];
            [baseVC.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 1:
        {
            MasonryViewController *masonryVC = [[MasonryViewController alloc]init];
            [baseVC.navigationController pushViewController:masonryVC animated:YES];
            
        }
            
            break;
        case 2:
        {
            LocationViewController *locationVC = [[LocationViewController alloc]init];
            [baseVC.navigationController pushViewController:locationVC animated:YES];
            
        }
            
            break;
        case 3:
        {
            LocationVC *locationVC = [[LocationVC alloc]init];
            [baseVC.navigationController pushViewController:locationVC animated:YES];
            
        }
            
            break;
        case 4:
            
            
            break;
        case 5:
            
            
            break;
        case 6:
            
            
            break;
            
        default:
            break;
    }
    
   
    
}

- (void)elementAvatarImgClicked {

    AppBaseViewController *baseVC = [AppEngineManager sharedInstance].baseViewController;
    [baseVC homeControllerAppear];
    
    RenewUserAvatarViewController *userSignVC = [[RenewUserAvatarViewController alloc]init];
//    userSignVC.signName = _signNameLabel.text;
    [baseVC.navigationController pushViewController:userSignVC animated:YES];
    
    
    
}

- (void)elementNameLabelClicked {

    NSLog(@"tap");
  
            AppBaseViewController *baseVC = [AppEngineManager sharedInstance].baseViewController;
            [baseVC homeControllerAppear];
            
            UserSignViewController *userSignVC = [[UserSignViewController alloc]init];
            userSignVC.signName = _signNameLabel.text;
            [baseVC.navigationController pushViewController:userSignVC animated:YES];
    
}


- (void)refreshUserAvatar {

    if (_avatarImageView) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"LeftVCElements/userAvatar.jpg"];
        
        _avatarImageView.image = [UIImage imageWithContentsOfFile:imageFilePath];
        
    }

}


- (void)refreshSignName {

    if (_signNameLabel) {
        
        _signNameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSign"];

    }
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
