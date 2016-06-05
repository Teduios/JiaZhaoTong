//
//  MainViewController.m
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MainViewController.h"
#import "ZZManeger.h"
#import "ZZAllCollectionViewController.h"
#import "ZZTestCollectionViewController.h"
#import "ZZLayout.h"
#import "ZZSelectionViewController.h"
#import <MapKit/MapKit.h>
@interface MainViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *modelSegment;
@property (weak, nonatomic) IBOutlet UIButton *subjectOne;
@property (weak, nonatomic) IBOutlet UIButton *subjectFour;
@property(nonatomic,strong) CLGeocoder * geocoder;
@property(nonatomic,strong) CLLocationManager * manager;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [CLLocationManager new];
    self.geocoder = [CLGeocoder new];
    self.manager.delegate = self;
    [self.manager requestWhenInUseAuthorization];
    [self.manager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(UIButton*)sender {
    ZZSelectionViewController *selectionVC=[self.storyboard instantiateViewControllerWithIdentifier:@"selectionVC"];
    selectionVC.model=[self.modelSegment titleForSegmentAtIndex:self.modelSegment.selectedSegmentIndex];
    selectionVC.subject=sender.titleLabel.text;
    [self.navigationController pushViewController:selectionVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden=YES;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.geocoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * placemark = placemarks.lastObject;
        NSString *cityName = placemark.addressDictionary[@"City"];
        [cityName writeToFile:[ZZManeger getCurrentCityName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    static int i = 0;
    if (i > 0) {
        return;
    }
    i++;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位失败" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

@end
