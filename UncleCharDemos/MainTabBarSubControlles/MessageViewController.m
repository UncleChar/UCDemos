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

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic, strong) UITableView         *userChatTableView;
@property (nonatomic, strong) NSMutableArray      *userChatArrary;
@property (nonatomic, strong) NSMutableArray      *userSearchResultArrary;
@property (nonatomic, strong) UISearchController  *userSearchController;

@end
@implementation MessageViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    self.userSearchController.searchBar.hidden = NO;
}

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
    
    _userSearchResultArrary = _userChatArrary;
}

- (void)configMessageVCUI {

//    self.view.backgroundColor = [ConfigUITools colorRandomly];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(LocationVC)];
    rightItem.image = [UIImage imageNamed:@"tabbar_location@2x"];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    

    
    
    _userChatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _userChatTableView.delegate   = self;
    _userChatTableView.dataSource = self;
//    _userChatTableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_userChatTableView];
    
    _userSearchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _userSearchController.searchResultsUpdater = self;
    _userSearchController.dimsBackgroundDuringPresentation = NO;
//    _userSearchController.searchBar.text = @"kaisho";
//    [_userSearchController.searchBar setShowsCancelButton:YES];
    [_userSearchController.searchBar sizeToFit];
    _userSearchController.searchBar.delegate = self;
    _userChatTableView.tableHeaderView = self.userSearchController.searchBar;
    
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (nil == _userSearchResultArrary || _userSearchResultArrary.count == 0) {
        
        _userSearchResultArrary = _userChatArrary;
    }
    return _userSearchResultArrary.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"icon"];
    cell.textLabel.text = _userSearchResultArrary[indexPath.row];
    cell.imageView.layer.cornerRadius = 24;
    cell.imageView.layer.masksToBounds = 1;
    [cell setSelected:YES animated:YES];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    ChatRoomViewController *chatRoomVC = [[ChatRoomViewController alloc]init];
    chatRoomVC.chatRoomTitle = _userSearchResultArrary[indexPath.row];
    self.userSearchController.searchBar.hidden = YES;
    [self.userSearchController.searchBar resignFirstResponder];
    
    [[AppEngineManager sharedInstance] baseViewControllerPushViewController:chatRoomVC animated:YES];
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *filterString = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
    
    _userSearchResultArrary = [NSMutableArray arrayWithArray:[self.userChatArrary filteredArrayUsingPredicate:predicate]];
    
    [self.userChatTableView reloadData];
}


- (void)LocationVC {
    
    LocationViewController *locationVC = [[LocationViewController alloc]init];
    [[AppEngineManager sharedInstance] baseViewControllerPushViewController:locationVC animated:YES];
}

@end
