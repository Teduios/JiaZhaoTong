//
//  ZZMapViewController.m
//  驾照通
//
//  Created by Tarena on 16/5/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZMapViewController.h"
#import <MapKit/MapKit.h>
#import "ZZManeger.h"
@interface ZZMapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property(nonatomic,strong)MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)CLGeocoder *geocoder;
@property(nonatomic,strong) CLLocation *Location;
@end

@implementation ZZMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.geocoder = [CLGeocoder new];
    self.manager = [CLLocationManager new];
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    [self.manager requestWhenInUseAuthorization];
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.delegate= self;
    [self.view addSubview:self.mapView];
    
    UIButton * userButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-99, 50, 50)];
    [userButton setBackgroundImage:[UIImage imageNamed:@"icon_map_location"] forState:UIControlStateNormal];
    [userButton addTarget:self action:@selector(goBackToUserLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:userButton];
}

-(void)goBackToUserLocation
{
    MKCoordinateRegion region;
    region.center = self.Location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    region.span = span;
    [self.mapView setRegion:region animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.Location = userLocation.location;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
