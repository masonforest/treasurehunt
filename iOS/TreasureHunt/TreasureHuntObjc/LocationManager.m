//
//  LocationManager.m
//  TreasureHuntObjc
//
//  Created by Seamus on 05/11/2016.
//
//

#import "LocationManager.h"

@implementation LocationManager

- (id)init
{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
        [self.locationManager requestWhenInUseAuthorization];
    }
    return self;
}

-(void) requestLocation {
    [self.locationManager requestLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation* location = locations.lastObject;
    if (location != nil) {
        [_delegate didUpdateLocation:location];
    } else {
        [_delegate didFail];
    }
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [_delegate didFail];
}

@end
