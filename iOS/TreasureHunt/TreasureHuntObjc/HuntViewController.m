//
//  HuntViewController.m
//  TreasureHuntObjc
//
//  Created by Seamus on 05/11/2016.
//
//

#import "HuntViewController.h"
#import "LocationManager.h"
#import "VideoPlaybackViewController.h"

@interface HuntViewController () {
    int numberOfLocationRequests;
    NSURLSession* ourSession;
}

@end

@implementation HuntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[LocationManager alloc] init];
    self.locationManager.delegate = self;
    numberOfLocationRequests = 0;
    
    ourSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest* someRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://treasurehunt.masonforest.com/nextHint?userId=123"]];
    [someRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [someRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [someRequest setHTTPMethod:@"GET"];
    
    
    
    NSURLSessionTask *task = [ourSession dataTaskWithRequest:someRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response != nil ) {
            NSLog(@"%@", response);
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"%@", jsonDict);
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                //Run UI Updates
                self.hintLabel.text = jsonDict[@"hint"];
                self.hintLabel.hidden = NO;
                self.tryLocationButton.hidden = NO;
            });
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [task resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 
 */

-(IBAction)tryLocationButton:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Fee" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"API CALL");
        [self.locationManager requestLocation];
        numberOfLocationRequests = 1;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) didUpdateLocation:(CLLocation *)location {
    if(numberOfLocationRequests > 0) {
        
        NSMutableURLRequest* someRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.80.224/"]];
        [someRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [someRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [someRequest setHTTPMethod:@"POST"];
        
        
        [someRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:@{@"latitude":[NSNumber numberWithDouble:location.coordinate.latitude], @"longitude":[NSNumber numberWithDouble: location.coordinate.longitude]} options:0 error:nil] ];
        
        
        NSURLSessionTask *task = [ourSession dataTaskWithRequest:someRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (response != nil ) {
                NSLog(@"%@", response);
                NSLog(@"%@", data);
            } else {
                NSLog(@"%@", data);
                NSLog(@"%@", error.localizedDescription);
            }
        }];
        [task resume];
    }
    numberOfLocationRequests--;
}

-(void) didFail {
    
}




@end
