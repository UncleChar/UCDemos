//
//  ChatRoomViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/8.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "ChatRoomViewController.h"

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.chatRoomTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}



@end
