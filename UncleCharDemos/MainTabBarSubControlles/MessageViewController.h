//
//  MessageViewController.h
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
@interface MessageViewController : BaseViewController

@property (nonatomic, strong) BMKMapView          *mapView;
@property (nonatomic, strong) BMKLocationService  *locService;
//- (void)jumpToOtherController;

@end
