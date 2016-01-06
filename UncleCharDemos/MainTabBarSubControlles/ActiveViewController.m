//
//  ActiveViewController.m
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "ActiveViewController.h"
#import "ConfigUITools.h"

@implementation ActiveViewController
- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"ACTIVE");
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ConfigUITools colorRandomly];
    self.title = @"ACTIVE";
    
}
@end
