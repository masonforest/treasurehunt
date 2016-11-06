//
//  ViewController.m
//  TreasureHuntObjc
//
//  Created by Seamus on 05/11/2016.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)resetContract:(UIButton *)sender {
    NSURLSession *ourSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest* someRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://treasurehunt.masonforest.com/"]];
    [someRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [someRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [someRequest setHTTPMethod:@"POST"];
    
    
    
    NSURLSessionTask *task = [ourSession dataTaskWithRequest:someRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
    
}
@end
