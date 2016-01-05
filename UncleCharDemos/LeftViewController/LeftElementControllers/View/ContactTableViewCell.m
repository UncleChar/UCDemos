//
//  ContactTableViewCell.m
//  搜索框
//
//  Created by LingLi on 15/12/2.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "AddressBookModel.h"
#import "ContactModel.h"
#import "UserModel.h"
#import "GroupModel.h"
#import "DivideContactsViewController.h"
#import "ConfigUITools.h"
//#import "UIImageView+WebCache.h"
@interface ContactTableViewCell ()
{
    
    UIButton     *selectBtn;
    UILabel      *nameLabel;
    UILabel      *emailLabel;
    UIImageView  *headImageView;
    
}

@end

@implementation ContactTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [ConfigUITools colorRandomly];

        [self creatSelectBtn];
        
    }
    return self;

    
}

- (void)creatSelectBtn {

    
    selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(10, 9.5, 25, 25);
//    selectBtn.backgroundColor = [UIColor lightGrayColor];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_null@2x"] forState:UIControlStateNormal];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_sel@2x"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectBtn];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 2, 150, 20)];
    [nameLabel setTextColor:[UIColor whiteColor]];
//    emailLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:nameLabel];
    
    emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 26, 300, 18)];
    [emailLabel setTextColor:[UIColor whiteColor]];
    emailLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:emailLabel];


}

- (void)btnClicked:(UIButton *)sender {
    
    selectBtn.selected = !selectBtn.selected;
    
    if (selectBtn.selected) {
        
        if ([_sendModel isKindOfClass:[GroupModel class]]) {
            GroupModel *gmodel = _sendModel;
            if (gmodel.invited) {
                selectBtn.selected = NO;
                [selectBtn setBackgroundImage:[UIImage imageNamed:@"selected_unavailable@2x"] forState:UIControlStateNormal];
                UIAlertView *alret = [[UIAlertView alloc]initWithTitle:@"您已经邀请过" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alret show];
                
            }else {
                
                gmodel.isSelected = YES;
            }
        }else if ([_sendModel isKindOfClass:[UserModel class]]) {
            UserModel *umodel = _sendModel;
            if (umodel.invited) {
                
                selectBtn.selected = NO;
                [selectBtn setBackgroundImage:[UIImage imageNamed:@"selected_unavailable@2x"] forState:UIControlStateNormal];
                UIAlertView *alret = [[UIAlertView alloc]initWithTitle:@"您已经邀请过" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alret show];
                
            }else {
                
                umodel.isSelected = YES;
            }
        }else {
            AddressBookModel *admodel = _sendModel;
            admodel.isSelected = YES;
            
        }
        
        if ([_delegate respondsToSelector:@selector(btnSelected: withModel:)]) {
            [_delegate btnSelected:sender withModel:_sendModel];
        }
        
        
    }else {
        
        if ([_sendModel isKindOfClass:[UserModel class]]) {
            
            UserModel *umodel = _sendModel;
            umodel.isSelected = NO;
            
        }else if([_sendModel isKindOfClass:[GroupModel class]]) {
            
            GroupModel *gmodel = _sendModel;
            gmodel.isSelected = NO;
            
        }else {
            AddressBookModel *admodel = [[AddressBookModel alloc]init];
            admodel.isSelected = NO;
        }
        
        if ([_delegate respondsToSelector:@selector(btnUnSelected:withModel:)]) {
            [_delegate btnUnSelected:sender withModel:_sendModel];
        }
        
    }
    
}

-(void)setModel:(id)model {

    if ([model isKindOfClass:[UserModel class]]) {
        
        
        _userModel  = model;
        _sendModel = _userModel;
        nameLabel.frame  = CGRectMake(100, 2, 150, 20);
        emailLabel.frame = CGRectMake(100, 26, 300, 18);
//        [headImageView setImageWithURL:[NSURL URLWithString:_userModel.avatar] placeholderImage:[UIImage imageNamed:@""]];
        //        [headImageView sd_setImageWithURL: placeholderImage:];
        nameLabel.text  = _userModel.real_name;
        emailLabel.text = _userModel.email;
        if (_userModel.invited) {
            
            selectBtn.selected = NO;
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_selected@2x"] forState:UIControlStateNormal];
            
        }else {
            
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_null"] forState:UIControlStateNormal];
            if (_userModel.isSelected) {
                
                selectBtn.selected = YES;
            }else {
                selectBtn.selected = NO;
            }
            
        }
        
        
        
        
    }else if ([model isKindOfClass:[GroupModel class]]){
        
        _groupModel = model;
        _sendModel = _groupModel;
        nameLabel.frame = CGRectMake(100, 4, 200, 28);
        
        nameLabel.text  = [NSString stringWithFormat:@"%@(%@)",_groupModel.group_name,_groupModel.user_count];
        emailLabel.frame = CGRectMake(100, 34, 300, 10);
        emailLabel.text = @"";
        headImageView.image = [UIImage imageNamed:@"iPhone_group"];
        if (_groupModel.invited) {
            
            selectBtn.selected = NO;
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_selected@2x"] forState:UIControlStateNormal];
            
        }else {
            
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_null"] forState:UIControlStateNormal];
            
            if (_groupModel.isSelected) {
                
                selectBtn.selected = YES;
            }else {
                selectBtn.selected = NO;
            }
            
        }
        
        
    }else  {
        
        _localModel  = model;
        _sendModel = _localModel;
        nameLabel.frame = CGRectMake(100, 2, 150, 20);
        emailLabel.frame = CGRectMake(100, 26, 300, 18);
        nameLabel.text  = _localModel.name;
        emailLabel.text = _localModel.email;
        headImageView.image = [UIImage imageNamed:@"main_menu_profile_photo_default"];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_null"] forState:UIControlStateNormal];
        if (_localModel.isSelected) {
            
            selectBtn.selected = YES;
        }else {
            selectBtn.selected = NO;
        }
        
    }
    

}

@end
