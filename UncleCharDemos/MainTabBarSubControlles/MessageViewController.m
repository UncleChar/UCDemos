//
//  MessageViewController.m
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "MessageViewController.h"
#import "AppBaseViewController.h"
#import "LocationViewController.h"
#import "AppEngineManager.h"
#import "ConfigUITools.h"
   
@interface MessageViewController ()

{

    
}
@end
@implementation MessageViewController

- (void)viewDidLoad {
    
     [super viewDidLoad];
   
    self.view.backgroundColor = [ConfigUITools colorRandomly];
    self.title = @"MESSAGE";

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(LocationVC)];
    rightItem.image = [UIImage imageNamed:@"tabbar_location@2x"];
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)LocationVC {
    
    AppBaseViewController *baseVC = [AppEngineManager sharedInstance].baseViewController;
    LocationViewController *locationVC = [[LocationViewController alloc]init];
    [baseVC.navigationController pushViewController:locationVC animated:YES];
}
@end
