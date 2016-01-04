//
//  MessageViewController.m
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "MessageViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#define MYBUNDLE_NAME @ “mapapi.bundle”
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface MessageViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

{

    
}
@end
@implementation MessageViewController


//- (void)viewWillAppear:(BOOL)animated {
//    
//    NSLog(@"MESSAGE");
//    [_mapView viewWillAppear];
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//     _locService.delegate = self;
//    
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil; // 不用时，置nil
//    _locService.delegate = nil;
//}
- (void)viewDidLoad {
    
     [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MESSAGE";

//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
//        //由于IOS8中定位的授权机制改变 需要进行手动授权
//        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
//        //获取授权认证
//        [locationManager requestAlwaysAuthorization];
//        [locationManager requestWhenInUseAuthorization];
//    }
//    
//    
//    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
////     [_mapView setZoomLevel:15];
////    _mapView.delegate = self;
//    [_mapView setMapType:BMKMapTypeStandard];
//
//    _mapView.showsUserLocation = YES;
//    [self.view addSubview:_mapView];
//    
//    
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    [_locService startUserLocationService];
//    
//
    

}

////实现相关delegate 处理位置信息更新
////处理方向变更信息
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
////     [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
//    NSLog(@"title %@",userLocation.title);
//}
////处理位置坐标更新
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    //     [_mapView updateLocationData:userLocation];
//    //
//    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    //
//    //    [_locService stopUserLocationService];
//    
//    CLLocationCoordinate2D userLoc;
//    userLoc.latitude = userLocation.location.coordinate.latitude;
//    userLoc.longitude = userLocation.location.coordinate.longitude;
//    _mapView.centerCoordinate = userLoc;
//    _mapView.zoomLevel = 18.0;
//    [_locService stopUserLocationService];
//    
//}
//- (void)didFailToLocateUserWithError:(NSError *)error {
//
//    NSLog(@"ddd%@",error);
//}
//

@end
