//
//  LocationManager.h
//  TreasureHuntObjc
//
//  Created by Seamus on 05/11/2016.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//@protocol LocationManagerDelegate
//    func didUpdate(location: CLLocation)
//    func didFail()
//@

@protocol LocationManagerDelegate <NSObject>
    -(void) didUpdateLocation:(CLLocation*)location;
    -(void) didFail;
@end


@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property(nonatomic, weak) id <LocationManagerDelegate> delegate;
+(id) locationManager;
-(void) requestLocation;




@end
