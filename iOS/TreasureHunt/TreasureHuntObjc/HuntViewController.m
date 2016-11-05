//
//  HuntViewController.m
//  TreasureHuntObjc
//
//  Created by Seamus on 05/11/2016.
//
//

#import "HuntViewController.h"

@interface HuntViewController () {
    int numberOfLocationRequests;
}

@end

@implementation HuntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.locationManager setDelegate:self];
    numberOfLocationRequests = 0;
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
         NSURLSession* ourSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSMutableURLRequest* someRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.80.224/"]];
        [someRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [someRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [someRequest setHTTPMethod:@"POST"];
        
        
        [someRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:@{@"latitude":[NSNumber numberWithDouble:location.coordinate.latitude], @"longitude":[NSNumber numberWithDouble: location.coordinate.longitude]} options:0 error:nil] ];
        
        
        NSURLSessionTask *task = [ourSession dataTaskWithRequest:someRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (response != nil ) {
                NSLog(@"%@", response);
            } else {
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
