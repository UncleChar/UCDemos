//
//  LocationVC.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/4.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "LocationVC.h"
#import "BMKClusterManager.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface LocationVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
{
    BMKMapView *_mapView;
    
    BMKClusterManager *_clusterManager;//点聚合管理类
    
    NSInteger _clusterZoom;//聚合级别
    
    BMKLocationService *_locService;//定位
    
    BMKPoiSearch *_poisearch; //点搜索
    
    int curPage;
}
@end
@implementation LocationVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    self.navigationController.navigationBarHidden = 0;
    self.navigationController.hidesBarsWhenKeyboardAppears = YES;
    _mapView.delegate = self;
    _locService.delegate = self;
    _poisearch.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    
    self.title = @"地图";
    //初始化聚合管理类
    _clusterManager = [[BMKClusterManager alloc] init];
    
    //初始化地图
    [self setupMapView];

    
    //添加聚合管理点
    [self addPoint];
    
    //检索周边信息
    //    [self setupSearchBtn];
    
    
}

//拖动地图获取经纬
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"经度:%f 维度:%f",mapView.centerCoordinate.longitude,mapView.centerCoordinate.latitude);
    
}


- (void)setupMapView
{
    _mapView = [[BMKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //初始化检索对象
    _locService = [[BMKLocationService alloc] init];
    //初始化检索对象
    _poisearch = [[BMKPoiSearch alloc] init];
    // 设置地图级别
    [_mapView setZoomLevel:15];
    //卫星图
    //    [_mapView setMapType:BMKMapTypeSatellite];
    //标准图
    [_mapView setMapType:BMKMapTypeStandard];
    //打开实时路况图层
    //    [_mapView setTrafficEnabled:YES];
    
    //打开百度城市热力图图层
    //    [_mapView setBaiduHeatMapEnabled:YES];
    
    //    [self setupAnnotation];
    
    [self.view addSubview:_mapView];
    
    // 添加一个PointAnnotation
    //    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    //    CLLocationCoordinate2D coor;
    //    coor.latitude = 31.236305;
    //    coor.longitude = 121.480237;
    //    annotation.coordinate = coor;
    //    annotation.title = @"这里是魔都";
    //    [_mapView addAnnotation:annotation];
    
    
}


//向点聚合管理类中添加点
- (void)addPoint
{
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(31.236305, 121.480237);
    //向点聚合管理类中添加标注
    for(NSInteger i = 0;i < 20;i++){
        double lat = (arc4random() % 20) *0.001f;
        double lon = (arc4random() % 20) *0.001f;
        BMKClusterItem *cluserItem = [[BMKClusterItem alloc] init];
        cluserItem.coor = CLLocationCoordinate2DMake(coor.latitude + lat, coor.longitude + lon);
        [_clusterManager addClusterItem:cluserItem];
    }
    
    _clusterZoom = (NSInteger)_mapView.zoomLevel;
    //获取聚合后的点
    NSArray *array = [_clusterManager getClusters:_clusterZoom];
    NSMutableArray *clusters = [NSMutableArray array];
    for(BMKCluster *item in array){
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        annotation.coordinate = item.coordinate;
        annotation.title = [NSString stringWithFormat:@"我是%ld个",item.size];
        [clusters addObject:annotation];
    }
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:clusters];
    
}





/**
 *  添加大头针模型
 */
- (void)addPinAnnotations
{
    NSMutableArray *annoArr = [NSMutableArray array];
    for(int i = 0;i < 50;i++){
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        CLLocationCoordinate2D coor;
        coor.latitude = 31.236305 + (arc4random() %50 *0.001) ;
        coor.longitude = 121.480237 + (arc4random() %50 *0.001)  ;
        annotation.coordinate = coor;
        annotation.title = [NSString stringWithFormat:@"我是%d",i];
        [annoArr addObject:annotation];
    }
    [_mapView addAnnotations:annoArr];
    
    
}





- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //开启定位
    [self startLocation];
    
    
}

//设置大头针视图样式
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    if([annotation isKindOfClass:[BMKPointAnnotation class]]){
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] init];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;
        return newAnnotationView;
    }
    return nil;
}






//开启定位
- (void)startLocation
{
    NSLog(@"已进入定位系统");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}




//检索周边按钮
- (void)searchAround
{
    
    curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc] init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city = @"上海";
    citySearchOption.keyword = @"餐厅";
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag){
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    
}


#pragma mark implement BMKMapViewDelegate

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
//{
//    NSString *AnnotationViewID = @"annoID";
//    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//
//    if(annotationView == nil){
//        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//        ((BMKPinAnnotationView *)annotationView).pinColor = BMKPinAnnotationColorRed;
//        ((BMKPinAnnotationView *)annotationView).animatesDrop = YES;
//    }
//    //设置位置
//    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
//    annotationView.annotation = annotation;
//
//    annotationView.canShowCallout = YES;
//    annotationView.draggable = NO;
//
//    return annotationView;
//}

#pragma mark bmkSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    NSArray *array = [NSMutableArray array];
    [_mapView removeAnnotations:array];
    
    if(errorCode == BMK_SEARCH_NO_ERROR){
        NSMutableArray *annotations = [NSMutableArray array];
        for(int i = 0; i < poiResult.poiInfoList.count; i++){
            BMKPoiInfo *poi = [poiResult.poiInfoList objectAtIndex:i];
            BMKPointAnnotation *item = [[BMKPointAnnotation alloc] init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    }else if(errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    }else{
        NSLog(@"出错");
    }
    
    
    
}


//初始化大头针数据
//- (void)setupAnnotation
//{
//    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 31.2363;
//    coor.longitude = 121.48;
//    annotation.coordinate = coor;
//    annotation.title = @"我是魔都";
//    [_mapView addAnnotation:annotation];
//}



#pragma mark locationSerce Delegate
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}


/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //    NSLog(@"经度:%f  纬度:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}





- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
    _poisearch.delegate = nil;
    
}

- (void)dealloc
{
    if(_mapView){
        _mapView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
