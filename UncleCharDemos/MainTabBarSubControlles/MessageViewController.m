//
//  MessageViewController.m
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "MessageViewController.h"
#import "LocationViewController.h"
#import "ChatRoomViewController.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView       *userChatTableView;
@property (nonatomic, strong) NSMutableArray    *userChatArrary;

@end
@implementation MessageViewController

- (void)viewDidLoad {
    
     [super viewDidLoad];
    
    [self configMessageVCUI];
    
    [self handleMessageVCData];
    
    
    
    
   


}


- (void)handleMessageVCData {
    
    if (nil == _userChatArrary) {
        
        _userChatArrary = [NSMutableArray arrayWithCapacity:0];
    }
    
    NSString *name1 = @"UncleChar";
    NSString *name2 = @"Tingting.Xia";
    NSString *name3 = @"Qianbin";
    NSString *name4 = @"Karray.Meng";
    NSString *name5 = @"Charles";
    [_userChatArrary addObject:name1];
    [_userChatArrary addObject:name2];
    [_userChatArrary addObject:name3];
    [_userChatArrary addObject:name4];
    [_userChatArrary addObject:name5];
    
}

- (void)configMessageVCUI {

//    self.view.backgroundColor = [ConfigUITools colorRandomly];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(LocationVC)];
    rightItem.image = [UIImage imageNamed:@"tabbar_location@2x"];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _userChatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 3, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _userChatTableView.delegate   = self;
    _userChatTableView.dataSource = self;
//    _userChatTableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_userChatTableView];
    
}



#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _userChatArrary.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"icon"];
    cell.textLabel.text = _userChatArrary[indexPath.row];
    cell.imageView.layer.cornerRadius = 24;
    cell.imageView.layer.masksToBounds = 1;
    [cell setSelected:YES animated:NO];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ChatRoomViewController *chatRoomVC = [[ChatRoomViewController alloc]init];
    chatRoomVC.chatRoomTitle = _userChatArrary[indexPath.row];
    [[AppEngineManager sharedInstance] baseViewControllerPushViewController:chatRoomVC animated:YES];
    
}


















- (void)LocationVC {
    
    LocationViewController *locationVC = [[LocationViewController alloc]init];
    [[AppEngineManager sharedInstance] baseViewControllerPushViewController:locationVC animated:YES];
}
@end
