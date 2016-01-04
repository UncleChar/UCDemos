//
//  RenewUserAvatarViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 15/12/28.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "RenewUserAvatarViewController.h"

#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface RenewUserAvatarViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong) UIImageView *userAvatar;
@property(nonatomic, strong) NSData *fileData;

@end
@implementation RenewUserAvatarViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50 , 100, 100, 100)];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"修改头像" style:UIBarButtonItemStylePlain target:self action:@selector(takePictureClick:)];
    self.navigationItem.rightBarButtonItem = left;
    [self.view addSubview:self.userAvatar];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"LeftVCElements"];
    // 创建目录
    BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"文件夹-创建成功");
       
    }else{
        NSLog(@"文件夹-创建失败");
    }

    NSString *imageFilePath = [testDirectory stringByAppendingPathComponent:@"/userAvatar.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//
    self.userAvatar.image = selfPhoto;
    [self.userAvatar.layer setCornerRadius:CGRectGetHeight([self.userAvatar bounds]) / 2];
    self.userAvatar.layer.masksToBounds = YES;

}
//从相册获取图片
-(void)takePictureClick:(UIButton *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *localAction = [UIAlertAction actionWithTitle:@"本地相簿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cameraAction];
    [alert addAction:localAction];
    [alert addAction:cancelAction];

    
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {

    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"LeftVCElements/userAvatar.jpg"];

      NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    self.userAvatar.image = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//#pragma mark -
//#pragma mark UIImagePickerControllerDelegate methods
////完成选择图片
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
//{
//    //加载图片
//    self.img.image = image;
//    //选择框消失
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
////取消选择图片
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (IBAction)cameraBtn:(id)sender
//
//{
//
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//
//    imagePicker.delegate = self;
//
//    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//获取类型是摄像头，还可以是相册
//
//    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//
//    imagePicker.allowsEditing = NO;//如果为NO照出来的照片是原图，比如4s和5的iPhone出来的尺寸应该是（2000+）*（3000+），差不多800W像素，如果是YES会有个选择区域的方形方框
//
//    //    imagePicker.showsCameraControls = NO;//默认是打开的这样才有拍照键，前后摄像头切换的控制，一半设置为NO的时候用于自定义ovelay
//
////    UIImageView *overLayImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
////    overLayImg.image = [UIImage imageNamed:@"overlay.png"];
//
////    imagePicker.cameraOverlayView = overLayImg;//3.0以后可以直接设置cameraOverlayView为overlay
////    imagePicker.wantsFullScreenLayout = YES;
//
//    [self presentModalViewController:imagePicker animated:YES];
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize
//{
//    UIImage *newimage;
//    if (nil == image) {
//        newimage = nil;
//    }
//    else{
//        UIGraphicsBeginImageContext(asize);
//        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
//        newimage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//    }
//    return newimage;
//}
//
//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}


@end
