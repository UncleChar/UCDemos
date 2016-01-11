//
//  ChatRoomViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/8.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "ChatRoomViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kPicScrollerHeight 200
@interface ChatRoomViewController ()
{
    
    ALAssetsLibrary *library;
    
    
    NSMutableArray *mutableArray;
    
    UIScrollView   *picScrollView;
    BOOL            topPic;
    NSArray  *imageArray;
    BOOL         kk;
    
}
@property (nonatomic, strong) UIView       *inputBoxView;
@property (nonatomic, assign) CGFloat       inputBoxViewMinY;
@property (nonatomic, strong) UITextField  *inputTF;
@property (nonatomic, strong) UIImageView  *backIV;

@end
static NSInteger count=0;
@implementation ChatRoomViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self threadForPic];
    
    [self configChatRoomVCUI];
    
    
}


- (void)configChatRoomVCUI {
    
    

    _backIV = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_backIV];
    
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
    

    
    
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"contacts_add@2x"] forState:UIControlStateNormal];
    [_inputBoxView addSubview:addBtn];
    
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputBoxView.mas_left).with.offset(10);
        make.top.equalTo(_inputBoxView.mas_top).with.offset(5);
        make.bottom.equalTo(_inputBoxView.mas_bottom).with.offset(-5);
        make.right.equalTo(addBtn.mas_left).with.offset(-10);
        
    }];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputTF.mas_right).with.offset(10);
        make.top.equalTo(_inputBoxView.mas_top).with.offset(10);
        make.bottom.equalTo(_inputBoxView.mas_bottom).with.offset(-10);
        make.right.equalTo(_inputBoxView.mas_right).with.offset(-10);
        make.width.equalTo(@(19));
        
    }];
    
    
    
}


#pragma mark - keyboard events

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    
    
    _inputBoxViewMinY = CGRectGetMinY(_inputBoxView.frame);
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (topPic) {
        
        if (_inputBoxViewMinY + 40 > kScreenHeight -  kbHeight) {
            
            [UIView animateWithDuration:duration animations:^{

                _inputBoxView.frame = CGRectMake(0, _inputBoxViewMinY -((_inputBoxViewMinY + 40) - (kScreenHeight -  kbHeight)), kScreenWidth, 40);
                picScrollView.hidden = YES;
                topPic = NO;
                
            }];
            
        }

        
    }else {
    
        
        

        
        [UIView animateWithDuration:duration animations:^{
            
            _inputBoxView.frame = CGRectMake(0, _inputBoxViewMinY - kbHeight, kScreenWidth, 40);
            
        }];
        
    }
    

    //注明：这里不需要移除通知
}

- (void) keyboardWillHide:(NSNotification *)notify {
    
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{

         _inputBoxView.frame = CGRectMake(0, _inputBoxViewMinY, kScreenWidth, 40);
    }];
}


- (void)threadForPic {
    

//     mutableArray =[[NSMutableArray alloc]init];
//    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];//生成整个photolibrary句柄的实例
////    NSMutableArray *mediaArray = [[NSMutableArray alloc]init];//存放media的数组
////    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
//     NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
//     library = [[ALAssetsLibrary alloc] init];
//    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {//获取所有group
//        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {//从group里面
//
//            NSString* assetType = [result valueForProperty:ALAssetPropertyType];
//            if ([assetType isEqualToString:ALAssetTypePhoto]) {
//                
//                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
//                 NSURL *url= (NSURL*) [[result defaultRepresentation]url];
//                
//                [assetsLibrary assetForURL:url
//                 
//                         resultBlock:^(ALAsset *asset) {
//                             
//                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
//                             
//                             
//                             
////                             if ([mutableArray count]==count)
////                                 
////                             {
////                                 
////                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
////                                 
////                                 [self allPhotosCollected:imageArray];
////                                 
////                             }
//                             
//                         }
//                 
//                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
//                             
//   
//
////                NSLog(@"Photo%@",result);
//            }else if([assetType isEqualToString:ALAssetTypeVideo]){
////                NSLog(@"Video");
//            }else if([assetType isEqualToString:ALAssetTypeUnknown]){
////                NSLog(@"Unknow AssetType");
//            }
//            
//                      NSLog(@"%@",mutableArray);
//
//        }];
//
//        
//        
//        
//        
//        
//    } failureBlock:^(NSError *error) {
//        NSLog(@"Enumerate the asset groups failed.");
//    }];
//    
  

    
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    imageArray=[[NSArray alloc] init];
    
    mutableArray =[[NSMutableArray alloc]init];
    
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    
    
    library = [[ALAssetsLibrary alloc] init];
    
    
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result != nil) {
            
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                
                
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                
                
                
                [library assetForURL:url
                 
                         resultBlock:^(ALAsset *asset) {
                             
                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                             if ([mutableArray count]==count)
                                 
                             {
                                 
                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
                                 
                                 [self allPhotosCollected:imageArray];
                                 
                             }

                         }
                 
                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
                
                
                
                
            }
            
        }else {
        
            
        }
        
    };
    
    
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        
        if(group != nil) {
            
            [group enumerateAssetsUsingBlock:assetEnumerator];
            
            [assetGroups addObject:group];
            
            count=[group numberOfAssets];
            
        }
        
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
     
                           usingBlock:assetGroupEnumerator
     
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
    
            dispatch_async(dispatch_get_main_queue(), ^{
    
                
                
            });
    
        });
    
}



- (void)addPic {
    

//    if (picScrollView) {
//        
//        picScrollView.hidden = NO;
//    }
    picScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200)];
    picScrollView.backgroundColor = [ConfigUITools colorRandomly];
    [self.view addSubview:picScrollView];

    [UIView animateWithDuration:0.3 animations:^{
        
        _inputBoxView.frame = CGRectMake(0, kScreenHeight - 240, kScreenWidth, 40);
        picScrollView.frame = CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200);
        topPic = YES;
        
    }];
    
        
           [self allPhotosCollected:mutableArray];
        

    
}

-(void)allPhotosCollected:(NSArray*)imgArray

{
    
    //write your code here after getting all the photos from library...
    
    NSLog(@"all pictures are %@",imgArray);
    
    if (topPic) {
        
        CGFloat length = 1;
        CGFloat margin = 5;
        for (UIImage *img in imgArray) {
            UIImageView *iv = [[UIImageView alloc]init];
            
            CGFloat ratio = img.size.width / img.size.height;
            
            if (img.size.height >= kPicScrollerHeight - 2 * margin) {

                iv.frame = CGRectMake(length, margin, ratio * (kPicScrollerHeight - 2 * margin), (kPicScrollerHeight - 2 * margin));
                
            }else {

                iv.frame = CGRectMake(length, kPicScrollerHeight / 2.0 - img.size.height / 2.0, img.size.width, img.size.height);
                
            }
            
            length = CGRectGetMaxX(iv.frame) + margin;
            [picScrollView addSubview:iv];
            iv.image = img;
            NSLog(@"%@",NSStringFromCGSize(img.size));
            
        }
        picScrollView.contentSize = CGSizeMake(length, kPicScrollerHeight);
    }
    
    
    
}




- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

   
    if (topPic) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _inputBoxView.frame = CGRectMake(0, kScreenHeight - 40, kScreenWidth, 40);
            picScrollView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
            topPic = NO;
        }];

        for (UIImageView *f in picScrollView.subviews) {
            
            [f removeFromSuperview];
            f == nil;
            
        }
                [picScrollView removeFromSuperview];
        picScrollView = nil;
        
    }else {
    
     [_inputTF resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            
            _inputBoxView.frame = CGRectMake(0, kScreenHeight - 40, kScreenWidth, 40);
            picScrollView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
            topPic = NO;
        }];
    }
}


@end
